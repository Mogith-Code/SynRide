import 'package:flutter/material.dart';
import '../../../../core/constants/app_colors.dart';
import '../../data/repositories/ticket_repository.dart';

class TripSummaryScreen extends StatefulWidget {
  const TripSummaryScreen({super.key});

  @override
  State<TripSummaryScreen> createState() => _TripSummaryScreenState();
}

class _TripSummaryScreenState extends State<TripSummaryScreen> {
  final TicketRepository _repository = TicketRepository();

  final List<Map<String, dynamic>> _routeStops = [
    {
      'name': 'City Center',
      'time': '07:30',
      'isCompleted': true,
    },
    {
      'name': 'Main Station',
      'time': '07:48',
      'isCompleted': true,
    },
    {
      'name': 'Hospital Gate',
      'time': '08:05',
      'isCompleted': true,
    },
    {
      'name': 'University',
      'time': '08:20',
      'isCompleted': false,
    },
    {
      'name': 'Mall Junction',
      'time': '08:38',
      'isCompleted': false,
    },
    {
      'name': 'Airport',
      'time': '09:00',
      'isCompleted': false,
    },
  ];

  void _handleEndTrip() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        backgroundColor: AppColors.surface,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        title: const Text(
          'End Current Trip?',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: AppColors.textPrimary,
          ),
        ),
        content: const Text(
          'Are you sure you want to finalize this trip summary? This will record all passenger stats and revenue into your shift waybill.',
          style: TextStyle(color: AppColors.textSecondary, fontSize: 14),
        ),
        actions: [
          TextButton(
            child: const Text('Cancel', style: TextStyle(color: AppColors.textSecondary)),
            onPressed: () => Navigator.pop(context),
          ),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: AppColors.danger,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
            ),
            child: const Text(
              'End Trip',
              style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
            ),
            onPressed: () {
              Navigator.pop(context);
              _repository.endShift();
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text('Trip Ended Successfully! Waybill updated.'),
                  backgroundColor: AppColors.success,
                ),
              );
              Navigator.pushReplacementNamed(context, '/conductor/home');
            },
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final shift = _repository.activeShift;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Trip Summary'),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Section 1: TODAY'S PERFORMANCE
              const Text(
                'TODAY\'S PERFORMANCE',
                style: TextStyle(
                  fontSize: 11.5,
                  fontWeight: FontWeight.bold,
                  color: AppColors.textSecondary,
                  letterSpacing: 0.6,
                ),
              ),

              const SizedBox(height: 12),

              // 2x2 Performance Metrics Grid
              _buildPerformanceGrid(
                totalPassengers: 89,
                revenue: shift.totalRevenue,
                tripsCompleted: 3,
                avgOccupancyPercent: 64,
              ),

              const SizedBox(height: 24),

              // Section 2: ROUTE PROGRESS
              const Text(
                'ROUTE PROGRESS',
                style: TextStyle(
                  fontSize: 11.5,
                  fontWeight: FontWeight.bold,
                  color: AppColors.textSecondary,
                  letterSpacing: 0.6,
                ),
              ),

              const SizedBox(height: 12),

              // Route Progress Stepper List Card
              _buildRouteProgressCard(),

              const SizedBox(height: 24),

              // End Trip Action Button
              SizedBox(
                width: double.infinity,
                height: 52,
                child: ElevatedButton(
                  onPressed: _handleEndTrip,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.danger,
                    foregroundColor: Colors.white,
                    elevation: 4,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16),
                    ),
                  ),
                  child: const Text(
                    'End Trip',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                      letterSpacing: 0.2,
                    ),
                  ),
                ),
              ),

              const SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }

  // 2x2 Today's Performance Metrics Grid
  Widget _buildPerformanceGrid({
    required int totalPassengers,
    required double revenue,
    required int tripsCompleted,
    required int avgOccupancyPercent,
  }) {
    return Column(
      children: [
        Row(
          children: [
            Expanded(
              child: _buildPerformanceCard(
                icon: Icons.people_alt_outlined,
                iconBgColor: AppColors.primary.withValues(alpha: 0.15),
                iconColor: AppColors.primary,
                value: '$totalPassengers',
                label: 'Total Passengers',
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: _buildPerformanceCard(
                icon: Icons.payments_outlined,
                iconBgColor: AppColors.success.withValues(alpha: 0.15),
                iconColor: AppColors.success,
                value: 'LKR ${revenue.toStringAsFixed(0)}',
                label: 'Revenue',
              ),
            ),
          ],
        ),
        const SizedBox(height: 12),
        Row(
          children: [
            Expanded(
              child: _buildPerformanceCard(
                icon: Icons.alt_route_rounded,
                iconBgColor: AppColors.accent.withValues(alpha: 0.15),
                iconColor: AppColors.accent,
                value: '$tripsCompleted',
                label: 'Trips Completed',
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: _buildPerformanceCard(
                icon: Icons.show_chart_rounded,
                iconBgColor: AppColors.warning.withValues(alpha: 0.15),
                iconColor: AppColors.warning,
                value: '$avgOccupancyPercent%',
                label: 'Avg Occupancy',
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildPerformanceCard({
    required IconData icon,
    required Color iconBgColor,
    required Color iconColor,
    required String value,
    required String label,
  }) {
    return Container(
      padding: const EdgeInsets.all(16.0),
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: AppColors.surfaceLight.withValues(alpha: 0.5)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 36,
            height: 36,
            decoration: BoxDecoration(
              color: iconBgColor,
              shape: BoxShape.circle,
            ),
            child: Icon(icon, color: iconColor, size: 20),
          ),
          const SizedBox(height: 12),
          Text(
            value,
            style: const TextStyle(
              fontSize: 22,
              fontWeight: FontWeight.bold,
              color: AppColors.textPrimary,
              letterSpacing: -0.5,
            ),
          ),
          const SizedBox(height: 2),
          Text(
            label,
            style: const TextStyle(
              fontSize: 12.5,
              fontWeight: FontWeight.w500,
              color: AppColors.textSecondary,
            ),
          ),
        ],
      ),
    );
  }

  // Route Progress Timeline Stepper List
  Widget _buildRouteProgressCard() {
    return Container(
      padding: const EdgeInsets.all(20.0),
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: AppColors.surfaceLight.withValues(alpha: 0.5)),
      ),
      child: ListView.builder(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        itemCount: _routeStops.length,
        itemBuilder: (context, index) {
          final stop = _routeStops[index];
          final bool isCompleted = stop['isCompleted'] as bool;
          final bool isLast = index == _routeStops.length - 1;

          return IntrinsicHeight(
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                // Timeline Column (Icon + Vertical Line)
                SizedBox(
                  width: 32,
                  child: Column(
                    children: [
                      // Status Icon
                      isCompleted
                          ? const Icon(
                              Icons.check_circle,
                              color: AppColors.success,
                              size: 20,
                            )
                          : Container(
                              width: 14,
                              height: 14,
                              margin: const EdgeInsets.only(top: 3),
                              decoration: const BoxDecoration(
                                color: AppColors.surfaceLight,
                                shape: BoxShape.circle,
                              ),
                            ),
                      // Connecting Vertical Line
                      if (!isLast)
                        Expanded(
                          child: Container(
                            width: 2,
                            margin: const EdgeInsets.symmetric(vertical: 4),
                            color: isCompleted
                                ? AppColors.success
                                : AppColors.surfaceLight,
                          ),
                        ),
                    ],
                  ),
                ),

                const SizedBox(width: 8),

                // Stop Info Row
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.only(bottom: 24.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          stop['name'] as String,
                          style: TextStyle(
                            fontSize: 14.5,
                            fontWeight: isCompleted
                                ? FontWeight.bold
                                : FontWeight.w500,
                            color: isCompleted
                                ? AppColors.textPrimary
                                : AppColors.textSecondary,
                          ),
                        ),
                        Text(
                          stop['time'] as String,
                          style: TextStyle(
                            fontSize: 13,
                            fontWeight: isCompleted
                                ? FontWeight.bold
                                : FontWeight.w500,
                            color: isCompleted
                                ? AppColors.success
                                : AppColors.textSecondary,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
