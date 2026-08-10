import 'package:flutter/material.dart';
import '../../data/repositories/ticket_repository.dart';

class PassengerExitScreen extends StatefulWidget {
  const PassengerExitScreen({super.key});

  @override
  State<PassengerExitScreen> createState() => _PassengerExitScreenState();
}

class _PassengerExitScreenState extends State<PassengerExitScreen> {
  final TicketRepository _repository = TicketRepository();

  late int _onBoard;
  late int _capacity;
  int _boardedToday = 89;
  int _exitedToday = 66;

  @override
  void initState() {
    super.initState();
    final shift = _repository.activeShift;
    _onBoard = shift.currentOccupancy;
    _capacity = shift.totalCapacity;
  }

  void _incrementPassenger() {
    if (_onBoard < _capacity * 2) { // Allow slight overcrowding or cap at capacity
      setState(() {
        _onBoard++;
        _boardedToday++;
      });
      _repository.incrementPassengerCount(1);

      ScaffoldMessenger.of(context).hideCurrentSnackBar();
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Passenger Boarded (+1)'),
          duration: Duration(milliseconds: 800),
          backgroundColor: Color(0xFF10B981),
        ),
      );
    }
  }

  void _decrementPassenger() {
    if (_onBoard > 0) {
      setState(() {
        _onBoard--;
        _exitedToday++;
      });
      _repository.alightPassengers(1);

      ScaffoldMessenger.of(context).hideCurrentSnackBar();
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Passenger Exited (-1)'),
          duration: Duration(milliseconds: 800),
          backgroundColor: Color(0xFFEF4444),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final int availableSeats = (_capacity - _onBoard).clamp(0, _capacity);
    final int occupancyPercent =
        _capacity > 0 ? ((_onBoard / _capacity) * 100).round() : 0;

    return Scaffold(
      backgroundColor: const Color(0xFF0D192B), // Dark ambient outer theme
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: const BoxDecoration(
          gradient: RadialGradient(
            center: Alignment(0.4, -0.6),
            radius: 1.2,
            colors: [
              Color(0xFF0F3A36), // Deep emerald glow
              Color(0xFF0B192A), // Dark slate teal
              Color(0xFF070E1A), // Dark ambient space
            ],
          ),
        ),
        child: SafeArea(
          child: Column(
            children: [
              // Outer Header Navigation Bar
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 20.0, vertical: 12.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    // Back to Hub Button
                    InkWell(
                      onTap: () => Navigator.pop(context),
                      borderRadius: BorderRadius.circular(20),
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 14, vertical: 8),
                        decoration: BoxDecoration(
                          color: Colors.white.withOpacity(0.1),
                          borderRadius: BorderRadius.circular(20),
                          border: Border.all(
                            color: Colors.white.withOpacity(0.15),
                          ),
                        ),
                        child: Row(
                          children: const [
                            Icon(Icons.arrow_back_rounded,
                                color: Colors.white, size: 16),
                            SizedBox(width: 6),
                            Text(
                              'Back to Hub',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 13,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),

                    // App Identifier Badge
                    const Text(
                      'Conductor App',
                      style: TextStyle(
                        color: Color(0xFF10B981),
                        fontSize: 13,
                        fontWeight: FontWeight.w600,
                        letterSpacing: 0.3,
                      ),
                    ),
                  ],
                ),
              ),

              // Main Mobile Screen Frame Container
              Expanded(
                child: Center(
                  child: Container(
                    constraints: const BoxConstraints(maxWidth: 430),
                    margin: const EdgeInsets.symmetric(horizontal: 16.0),
                    decoration: BoxDecoration(
                      color: const Color(0xFFF8FAFC),
                      borderRadius: BorderRadius.circular(32),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.4),
                          blurRadius: 30,
                          spreadRadius: 2,
                          offset: const Offset(0, 10),
                        ),
                      ],
                    ),
                    clipBehavior: Clip.antiAlias,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Inner Header Row: Back Arrow + Passenger Exit
                        Padding(
                          padding: const EdgeInsets.fromLTRB(20, 20, 20, 14),
                          child: Row(
                            children: [
                              InkWell(
                                onTap: () => Navigator.pop(context),
                                borderRadius: BorderRadius.circular(10),
                                child: const Padding(
                                  padding: EdgeInsets.all(4.0),
                                  child: Icon(
                                    Icons.arrow_back_rounded,
                                    color: Color(0xFF0F172A),
                                    size: 22,
                                  ),
                                ),
                              ),
                              const SizedBox(width: 12),
                              const Text(
                                'Passenger Exit',
                                style: TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                  color: Color(0xFF0F172A),
                                  letterSpacing: -0.3,
                                ),
                              ),
                            ],
                          ),
                        ),

                        // Scrollable Body Content
                        Expanded(
                          child: SingleChildScrollView(
                            physics: const BouncingScrollPhysics(),
                            padding: const EdgeInsets.symmetric(
                                horizontal: 20.0, vertical: 8.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                // Top Blue/Teal Card: On Board Passengers
                                _buildOnBoardCard(_onBoard),

                                const SizedBox(height: 24),

                                // Interactive Plus / Minus Controller Row
                                _buildCounterControlRow(
                                  availableSeats: availableSeats,
                                  onIncrement: _incrementPassenger,
                                  onDecrement: _decrementPassenger,
                                ),

                                const SizedBox(height: 24),

                                // Occupancy Progress Card
                                _buildOccupancyBarCard(occupancyPercent),

                                const SizedBox(height: 20),

                                // Bottom 2x2 Metrics Grid Cards
                                _buildMetricsGrid(),

                                const SizedBox(height: 20),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // Top Blue to Cyan Gradient On Board Card
  Widget _buildOnBoardCard(int count) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(vertical: 24.0, horizontal: 20.0),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            Color(0xFF2563EB), // Deep Blue
            Color(0xFF0284C7), // Sky Blue
            Color(0xFF06B6D4), // Cyan
          ],
        ),
        borderRadius: BorderRadius.circular(22),
        boxShadow: [
          BoxShadow(
            color: const Color(0xFF0284C7).withOpacity(0.35),
            blurRadius: 18,
            spreadRadius: 1,
            offset: const Offset(0, 6),
          ),
        ],
      ),
      child: Column(
        children: [
          const Text(
            'On Board',
            style: TextStyle(
              color: Colors.white70,
              fontSize: 13.5,
              fontWeight: FontWeight.w500,
            ),
          ),
          const SizedBox(height: 6),
          Text(
            '$count',
            style: const TextStyle(
              color: Colors.white,
              fontSize: 48,
              fontWeight: FontWeight.bold,
              letterSpacing: -1,
              height: 1.1,
            ),
          ),
          const SizedBox(height: 2),
          const Text(
            'passengers',
            style: TextStyle(
              color: Colors.white70,
              fontSize: 13,
              fontWeight: FontWeight.w400,
            ),
          ),
        ],
      ),
    );
  }

  // Interactive Plus / Minus Controller Row
  Widget _buildCounterControlRow({
    required int availableSeats,
    required VoidCallback onIncrement,
    required VoidCallback onDecrement,
  }) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        // Minus Button (-)
        GestureDetector(
          onTap: onDecrement,
          child: Container(
            width: 72,
            height: 72,
            decoration: BoxDecoration(
              color: const Color(0xFFFEE2E2), // Light Soft Red
              borderRadius: BorderRadius.circular(20),
            ),
            child: const Center(
              child: Icon(
                Icons.remove_rounded,
                color: Color(0xFFEF4444),
                size: 32,
              ),
            ),
          ),
        ),

        // Available Seats Middle Metric
        Column(
          children: [
            const Text(
              'Available Seats',
              style: TextStyle(
                fontSize: 12.5,
                fontWeight: FontWeight.w500,
                color: Color(0xFF94A3B8),
              ),
            ),
            const SizedBox(height: 4),
            Text(
              '$availableSeats',
              style: const TextStyle(
                fontSize: 28,
                fontWeight: FontWeight.bold,
                color: Color(0xFF10B981),
              ),
            ),
          ],
        ),

        // Plus Button (+)
        GestureDetector(
          onTap: onIncrement,
          child: Container(
            width: 72,
            height: 72,
            decoration: BoxDecoration(
              color: const Color(0xFFECFDF5), // Light Soft Green
              borderRadius: BorderRadius.circular(20),
            ),
            child: const Center(
              child: Icon(
                Icons.add_rounded,
                color: Color(0xFF10B981),
                size: 32,
              ),
            ),
          ),
        ),
      ],
    );
  }

  // Occupancy Progress Bar Card
  Widget _buildOccupancyBarCard(int percent) {
    return Container(
      padding: const EdgeInsets.all(18.0),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: const Color(0xFFF1F5F9)),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.03),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                'Occupancy',
                style: TextStyle(
                  fontSize: 14.5,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF0F172A),
                ),
              ),
              Text(
                '$percent%',
                style: const TextStyle(
                  fontSize: 13.5,
                  fontWeight: FontWeight.w600,
                  color: Color(0xFF64748B),
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          ClipRRect(
            borderRadius: BorderRadius.circular(6),
            child: LinearProgressIndicator(
              value: (percent / 100).clamp(0.0, 1.0),
              minHeight: 10,
              backgroundColor: const Color(0xFFF1F5F9),
              valueColor: const AlwaysStoppedAnimation<Color>(
                Color(0xFFF59E0B), // Orange fill
              ),
            ),
          ),
        ],
      ),
    );
  }

  // 2x2 Metrics Grid Cards
  Widget _buildMetricsGrid() {
    return Column(
      children: [
        Row(
          children: [
            Expanded(
              child: _buildMetricCard(
                value: '$_boardedToday',
                label: 'Boarded Today',
                valueColor: const Color(0xFF2563EB), // Blue
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: _buildMetricCard(
                value: '$_exitedToday',
                label: 'Exited Today',
                valueColor: const Color(0xFF10B981), // Teal
              ),
            ),
          ],
        ),
        const SizedBox(height: 12),
        Row(
          children: [
            Expanded(
              child: _buildMetricCard(
                value: 'University',
                label: 'Next Stop',
                valueColor: const Color(0xFFF59E0B), // Orange
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: _buildMetricCard(
                value: '3/6',
                label: 'Stops Done',
                valueColor: const Color(0xFF10B981), // Green
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildMetricCard({
    required String value,
    required String label,
    required Color valueColor,
  }) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 16.0),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: const Color(0xFFF1F5F9)),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.03),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            value,
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: valueColor,
              letterSpacing: -0.3,
            ),
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
          const SizedBox(height: 4),
          Text(
            label,
            style: const TextStyle(
              fontSize: 11.5,
              fontWeight: FontWeight.w500,
              color: Color(0xFF94A3B8),
            ),
          ),
        ],
      ),
    );
  }
}
