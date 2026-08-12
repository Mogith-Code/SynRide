import 'package:flutter/material.dart';
import '../../../../core/constants/app_colors.dart';
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
          backgroundColor: AppColors.success,
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
          backgroundColor: AppColors.danger,
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
      backgroundColor: const Color(0xFFF8FAFC),
      appBar: AppBar(
        backgroundColor: const Color(0xFFF8FAFC),
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_rounded, color: Color(0xFF0F172A)),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text(
          'Passenger Exit',
          style: TextStyle(
            color: Color(0xFF0F172A),
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Top Blue-Teal Hero Gradient Card: On Board Passengers
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
    );
  }

  // Top Card: Gradient Hero Banner matching design mockup
  Widget _buildOnBoardCard(int count) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(vertical: 28.0, horizontal: 20.0),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            Color(0xFF2563EB),
            Color(0xFF0EA5E9),
            Color(0xFF0D9488),
          ],
        ),
        borderRadius: BorderRadius.circular(24),
        boxShadow: [
          BoxShadow(
            color: const Color(0xFF0D9488).withValues(alpha: 0.25),
            blurRadius: 18,
            spreadRadius: 1,
            offset: const Offset(0, 8),
          ),
        ],
      ),
      child: Column(
        children: [
          Text(
            'On Board',
            style: TextStyle(
              color: Colors.white.withValues(alpha: 0.85),
              fontSize: 14,
              fontWeight: FontWeight.w500,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            '$count',
            style: const TextStyle(
              color: Colors.white,
              fontSize: 52,
              fontWeight: FontWeight.bold,
              letterSpacing: -1,
              height: 1.1,
            ),
          ),
          const SizedBox(height: 2),
          Text(
            'passengers',
            style: TextStyle(
              color: Colors.white.withValues(alpha: 0.85),
              fontSize: 13,
              fontWeight: FontWeight.w400,
            ),
          ),
        ],
      ),
    );
  }

  // Interactive Plus / Minus Controller Row matching design mockup
  Widget _buildCounterControlRow({
    required int availableSeats,
    required VoidCallback onIncrement,
    required VoidCallback onDecrement,
  }) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        // Minus Button (-) Soft Pink Tint
        GestureDetector(
          onTap: onDecrement,
          child: Container(
            width: 72,
            height: 72,
            decoration: BoxDecoration(
              color: const Color(0xFFFEF2F2),
              borderRadius: BorderRadius.circular(20),
              border: Border.all(color: const Color(0xFFFECACA)),
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
                fontSize: 30,
                fontWeight: FontWeight.bold,
                color: Color(0xFF10B981),
              ),
            ),
          ],
        ),

        // Plus Button (+) Soft Mint Green Tint
        GestureDetector(
          onTap: onIncrement,
          child: Container(
            width: 72,
            height: 72,
            decoration: BoxDecoration(
              color: const Color(0xFFECFDF5),
              borderRadius: BorderRadius.circular(20),
              border: Border.all(color: const Color(0xFFA7F3D0)),
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
            color: Colors.black.withValues(alpha: 0.03),
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
                  color: Color(0xFF94A3B8),
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
                Color(0xFFF59E0B),
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
                valueColor: const Color(0xFF2563EB),
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: _buildMetricCard(
                value: '$_exitedToday',
                label: 'Exited Today',
                valueColor: const Color(0xFF10B981),
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
                valueColor: const Color(0xFFF59E0B),
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: _buildMetricCard(
                value: '3/6',
                label: 'Stops Done',
                valueColor: const Color(0xFF10B981),
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
            color: Colors.black.withValues(alpha: 0.03),
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
