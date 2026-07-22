import 'package:flutter/material.dart';
import '../../../../core/constants/app_colors.dart';
import '../widgets/occupancy_indicator_widget.dart';
import '../../data/models/bus_model.dart';

class PassengerHomeScreen extends StatefulWidget {
  const PassengerHomeScreen({super.key});

  @override
  State<PassengerHomeScreen> createState() => _PassengerHomeScreenState();
}

class _PassengerHomeScreenState extends State<PassengerHomeScreen> {
  final List<BusModel> mockBuses = [
    BusModel(
      busId: 'BUS-101',
      routeNumber: 'Route 138',
      routeName: 'Pettah - Maharagama',
      totalCapacity: 54,
      currentOccupancy: 22,
      latitude: 6.9271,
      longitude: 79.8612,
      predictedEtaMinutes: 4,
      hasAvailableSeats: true,
    ),
    BusModel(
      busId: 'BUS-204',
      routeNumber: 'Route 100',
      routeName: 'Panadura - Colombo Fort',
      totalCapacity: 54,
      currentOccupancy: 52,
      latitude: 6.8480,
      longitude: 79.9265,
      predictedEtaMinutes: 12,
      hasAvailableSeats: false,
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('SyncRide Passenger Hub'),
        actions: [
          IconButton(
            icon: const Icon(Icons.confirmation_number_outlined),
            tooltip: 'Switch to Conductor Mode',
            onPressed: () => Navigator.pushNamed(context, '/conductor'),
          ),
          IconButton(
            icon: const Icon(Icons.analytics_outlined),
            tooltip: 'Authority Dashboard',
            onPressed: () => Navigator.pushNamed(context, '/authority'),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: AppColors.surface,
                borderRadius: BorderRadius.circular(16),
              ),
              child: Row(
                children: [
                  const Icon(Icons.search, color: AppColors.primary),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Text(
                      'Where do you want to go today?',
                      style: TextStyle(color: AppColors.textSecondary),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 24),
            const Text(
              'Approaching Buses & Live Occupancy',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 12),
            Expanded(
              child: ListView.builder(
                itemCount: mockBuses.length,
                itemBuilder: (context, index) {
                  final bus = mockBuses[index];
                  return Card(
                    margin: const EdgeInsets.only(bottom: 12),
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                bus.routeNumber,
                                style: const TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                  color: AppColors.primary,
                                ),
                              ),
                              Container(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 10,
                                  vertical: 4,
                                ),
                                decoration: BoxDecoration(
                                  color: AppColors.surfaceLight,
                                  borderRadius: BorderRadius.circular(12),
                                ),
                                child: Text(
                                  'ETA: ${bus.predictedEtaMinutes} mins',
                                  style: const TextStyle(fontWeight: FontWeight.w600),
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 6),
                          Text(
                            bus.routeName,
                            style: const TextStyle(color: AppColors.textSecondary),
                          ),
                          const SizedBox(height: 12),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              OccupancyIndicatorWidget(
                                status: bus.status,
                                percentage: bus.occupancyPercentage,
                              ),
                              Text(
                                '${bus.currentOccupancy} / ${bus.totalCapacity} Passengers',
                                style: const TextStyle(fontSize: 12),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
