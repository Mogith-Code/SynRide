import 'package:flutter/material.dart';
import '../../../../core/constants/app_colors.dart';
import '../../data/repositories/passenger_repository.dart';
import '../../data/models/bus_model.dart';
import '../widgets/occupancy_indicator_widget.dart';
import '../widgets/seat_availability_widget.dart';

class BusDetailsScreen extends StatelessWidget {
  const BusDetailsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final repository = PassengerRepository();
    final bus = repository.liveBuses.first; // Default active bus selection

    return Scaffold(
      appBar: AppBar(
        title: Text('${bus.routeNumber} Details'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Bus Unit Header Card
            Container(
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: AppColors.surface,
                borderRadius: BorderRadius.circular(20),
              ),
              child: Row(
                children: [
                  CircleAvatar(
                    radius: 26,
                    backgroundColor: AppColors.primary.withOpacity(0.2),
                    child: const Icon(Icons.directions_bus, color: AppColors.primary, size: 28),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          bus.routeName,
                          style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                        ),
                        Text(
                          'Unit: ${bus.busId} • ${bus.busType}',
                          style: const TextStyle(color: AppColors.textSecondary, fontSize: 12),
                        ),
                        Text(
                          'Operator: ${bus.operatorName}',
                          style: const TextStyle(color: AppColors.accent, fontSize: 11, fontWeight: FontWeight.w600),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20),

            // Real-Time Occupancy Progress
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: AppColors.surface,
                borderRadius: BorderRadius.circular(20),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        'Live Passenger Occupancy',
                        style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14),
                      ),
                      OccupancyIndicatorWidget(
                        status: bus.status,
                        percentage: bus.occupancyPercentage,
                        showLabelOnly: true,
                      ),
                    ],
                  ),
                  const SizedBox(height: 12),
                  ClipRRect(
                    borderRadius: BorderRadius.circular(8),
                    child: LinearProgressIndicator(
                      value: (bus.currentOccupancy / bus.totalCapacity).clamp(0.0, 1.0),
                      minHeight: 12,
                      backgroundColor: AppColors.surfaceLight,
                      valueColor: AlwaysStoppedAnimation<Color>(
                        bus.occupancyPercentage > 85 ? AppColors.danger : AppColors.primary,
                      ),
                    ),
                  ),
                  const SizedBox(height: 8),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Onboard: ${bus.currentOccupancy} Passengers',
                        style: const TextStyle(fontSize: 12, color: AppColors.textSecondary),
                      ),
                      Text(
                        'Capacity: ${bus.totalCapacity} Seats',
                        style: const TextStyle(fontSize: 12, color: AppColors.textSecondary),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20),

            // Smart Boarding Seating Predictor Timeline
            SeatAvailabilityWidget(bus: bus),
            const SizedBox(height: 24),

            // Realtime Conductor Sync Log Feed
            const Text(
              'Conductor Ticketing Live Feed',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
            ),
            const SizedBox(height: 10),
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: AppColors.surface,
                borderRadius: BorderRadius.circular(20),
              ),
              child: Column(
                children: [
                  _buildLogItem('1 min ago', 'Ticket Issued: Borella ➔ Nawala (+1 Pax)', AppColors.success),
                  const Divider(height: 16),
                  _buildLogItem('4 mins ago', 'Alighted at Torenton Square (-2 Pax)', AppColors.danger),
                  const Divider(height: 16),
                  _buildLogItem('8 mins ago', 'Ticket Issued: Pettah ➔ Maharagama (+2 Pax)', AppColors.success),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildLogItem(String time, String action, Color color) {
    return Row(
      children: [
        Icon(Icons.bolt, size: 16, color: color),
        const SizedBox(width: 8),
        Expanded(
          child: Text(action, style: const TextStyle(fontSize: 12, fontWeight: FontWeight.w500)),
        ),
        Text(time, style: const TextStyle(fontSize: 10, color: AppColors.textSecondary)),
      ],
    );
  }
}
