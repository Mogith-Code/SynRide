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
      appBar: AppBar(
        title: const Text('Passenger Exit Counter'),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 16.0),
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
    );
  }

  // Top Card
  Widget _buildOnBoardCard(int count) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(vertical: 24.0, horizontal: 20.0),
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(22),
        border: Border.all(color: AppColors.primary.withValues(alpha: 0.5)),
        boxShadow: [
          BoxShadow(
            color: AppColors.primary.withValues(alpha: 0.15),
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
              color: AppColors.textSecondary,
              fontSize: 13.5,
              fontWeight: FontWeight.w500,
            ),
          ),
          const SizedBox(height: 6),
          Text(
            '$count',
            style: const TextStyle(
              color: AppColors.primary,
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
              color: AppColors.textSecondary,
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
              color: AppColors.danger.withValues(alpha: 0.15),
              borderRadius: BorderRadius.circular(20),
              border: Border.all(color: AppColors.danger.withValues(alpha: 0.3)),
            ),
            child: const Center(
              child: Icon(
                Icons.remove_rounded,
                color: AppColors.danger,
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
                color: AppColors.textSecondary,
              ),
            ),
            const SizedBox(height: 4),
            Text(
              '$availableSeats',
              style: const TextStyle(
                fontSize: 28,
                fontWeight: FontWeight.bold,
                color: AppColors.success,
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
              color: AppColors.success.withValues(alpha: 0.15),
              borderRadius: BorderRadius.circular(20),
              border: Border.all(color: AppColors.success.withValues(alpha: 0.3)),
            ),
            child: const Center(
              child: Icon(
                Icons.add_rounded,
                color: AppColors.success,
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
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: AppColors.surfaceLight.withValues(alpha: 0.5)),
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
                  color: AppColors.textPrimary,
                ),
              ),
              Text(
                '$percent%',
                style: const TextStyle(
                  fontSize: 13.5,
                  fontWeight: FontWeight.w600,
                  color: AppColors.textSecondary,
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
              backgroundColor: AppColors.surfaceLight,
              valueColor: const AlwaysStoppedAnimation<Color>(
                AppColors.warning,
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
                valueColor: AppColors.primary,
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: _buildMetricCard(
                value: '$_exitedToday',
                label: 'Exited Today',
                valueColor: AppColors.success,
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
                valueColor: AppColors.warning,
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: _buildMetricCard(
                value: '3/6',
                label: 'Stops Done',
                valueColor: AppColors.accent,
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
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: AppColors.surfaceLight.withValues(alpha: 0.5)),
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
              color: AppColors.textSecondary,
            ),
          ),
        ],
      ),
    );
  }
}
