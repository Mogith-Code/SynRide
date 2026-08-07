import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core/constants/app_colors.dart';
import '../../logic/passenger_cubit/passenger_cubit.dart';
import '../../logic/passenger_cubit/passenger_state.dart';
import '../../data/repositories/passenger_repository.dart';
import '../widgets/live_bus_card.dart';
import '../widgets/seat_availability_widget.dart';

class PassengerHomeScreen extends StatelessWidget {
  const PassengerHomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => PassengerCubit(repository: PassengerRepository())..loadPassengerData(),
      child: const _PassengerHomeScreenView(),
    );
  }
}

class _PassengerHomeScreenView extends StatefulWidget {
  const _PassengerHomeScreenView();

  @override
  State<_PassengerHomeScreenView> createState() => _PassengerHomeScreenViewState();
}

class _PassengerHomeScreenViewState extends State<_PassengerHomeScreenView> {
  final TextEditingController _searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<PassengerCubit, PassengerState>(
      builder: (context, state) {
        final cubit = context.read<PassengerCubit>();
        final buses = state.buses;
        final recommendations = state.recommendations;

        return Scaffold(
          appBar: AppBar(
            title: Row(
              children: const [
                Icon(Icons.directions_bus_rounded, color: AppColors.primary),
                SizedBox(width: 8),
                Text(
                  'SyncRide Passenger Hub',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                ),
              ],
            ),
            actions: [
              IconButton(
                icon: const Icon(Icons.qr_code_2_rounded),
                tooltip: 'My SyncPass QR',
                onPressed: () => Navigator.pushNamed(context, '/passenger/pass'),
              ),
              IconButton(
                icon: const Icon(Icons.confirmation_number_outlined),
                tooltip: 'Conductor Mode',
                onPressed: () => Navigator.pushNamed(context, '/conductor'),
              ),
              IconButton(
                icon: const Icon(Icons.analytics_outlined),
                tooltip: 'Authority Dashboard',
                onPressed: () => Navigator.pushNamed(context, '/authority'),
              ),
            ],
          ),
          body: SingleChildScrollView(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Search Input Card
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
                  decoration: BoxDecoration(
                    color: AppColors.surface,
                    borderRadius: BorderRadius.circular(20),
                    border: Border.all(color: AppColors.primary.withOpacity(0.3)),
                  ),
                  child: Row(
                    children: [
                      const Icon(Icons.search, color: AppColors.primary),
                      const SizedBox(width: 12),
                      Expanded(
                        child: TextField(
                          controller: _searchController,
                          onChanged: (val) => cubit.searchBuses(val),
                          decoration: const InputDecoration(
                            hintText: 'Search bus #, route, or destination...',
                            hintStyle: TextStyle(color: AppColors.textSecondary, fontSize: 14),
                            border: InputBorder.none,
                          ),
                        ),
                      ),
                      if (_searchController.text.isNotEmpty)
                        IconButton(
                          icon: const Icon(Icons.clear, size: 18, color: AppColors.textSecondary),
                          onPressed: () {
                            _searchController.clear();
                            cubit.searchBuses('');
                          },
                        ),
                    ],
                  ),
                ),
                const SizedBox(height: 16),

                // Navigation Quick Tiles
                Row(
                  children: [
                    _buildNavTile(
                      context,
                      title: 'Live Tracking Map',
                      icon: Icons.map_rounded,
                      color: AppColors.primary,
                      onTap: () => Navigator.pushNamed(context, '/passenger/map'),
                    ),
                    const SizedBox(width: 10),
                    _buildNavTile(
                      context,
                      title: 'AI Smart Routes',
                      icon: Icons.alt_route_rounded,
                      color: AppColors.accent,
                      onTap: () => Navigator.pushNamed(context, '/passenger/recommendations'),
                    ),
                    const SizedBox(width: 10),
                    _buildNavTile(
                      context,
                      title: 'SyncPass QR',
                      icon: Icons.badge_rounded,
                      color: AppColors.success,
                      onTap: () => Navigator.pushNamed(context, '/passenger/pass'),
                    ),
                  ],
                ),
                const SizedBox(height: 20),

                // AI Multimodal Recommendation Banner (Alert if bus crowded)
                if (recommendations.isNotEmpty)
                  GestureDetector(
                    onTap: () => Navigator.pushNamed(context, '/passenger/recommendations'),
                    child: Container(
                      padding: const EdgeInsets.all(14),
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          colors: [
                            AppColors.accent.withOpacity(0.25),
                            AppColors.primary.withOpacity(0.15),
                          ],
                        ),
                        borderRadius: BorderRadius.circular(16),
                        border: Border.all(color: AppColors.accent.withOpacity(0.5)),
                      ),
                      child: Row(
                        children: [
                          Container(
                            padding: const EdgeInsets.all(8),
                            decoration: BoxDecoration(
                              color: AppColors.accent,
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: const Icon(Icons.psychology_rounded, color: Colors.white, size: 20),
                          ),
                          const SizedBox(width: 12),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const Text(
                                  'AI Route Recommendation Available!',
                                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 13),
                                ),
                                Text(
                                  '${recommendations.first.title} saves ${recommendations.first.timeSavedMinutes} mins.',
                                  style: const TextStyle(fontSize: 11, color: AppColors.textSecondary),
                                ),
                              ],
                            ),
                          ),
                          const Icon(Icons.arrow_forward_ios, size: 14, color: AppColors.accent),
                        ],
                      ),
                    ),
                  ),
                const SizedBox(height: 20),

                // Seat Availability Forecast Widget
                if (buses.isNotEmpty) SeatAvailabilityWidget(bus: buses.first),
                const SizedBox(height: 24),

                // Section Header & Seats Only Filter Chip
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      'Approaching Buses & Live Crowd Density',
                      style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                    ),
                    FilterChip(
                      label: const Text('Seats Only', style: TextStyle(fontSize: 11)),
                      selected: state.seatsOnlyFilter,
                      selectedColor: AppColors.success.withOpacity(0.3),
                      checkmarkColor: AppColors.success,
                      onSelected: (selected) => cubit.toggleSeatsOnlyFilter(selected),
                    ),
                  ],
                ),
                const SizedBox(height: 12),

                // Live Bus List
                buses.isEmpty
                    ? const Center(
                        child: Padding(
                          padding: EdgeInsets.all(32.0),
                          child: Text(
                            'No buses matching your criteria.',
                            style: TextStyle(color: AppColors.textSecondary),
                          ),
                        ),
                      )
                    : ListView.builder(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        itemCount: buses.length,
                        itemBuilder: (context, index) {
                          final bus = buses[index];
                          return LiveBusCard(
                            bus: bus,
                            onTrackOnMap: () {
                              cubit.selectBusForTracking(bus.busId);
                              Navigator.pushNamed(context, '/passenger/map');
                            },
                            onViewDetails: () {
                              cubit.selectBusForTracking(bus.busId);
                              Navigator.pushNamed(context, '/passenger/bus-details');
                            },
                          );
                        },
                      ),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _buildNavTile(
    BuildContext context, {
    required String title,
    required IconData icon,
    required Color color,
    required VoidCallback onTap,
  }) {
    return Expanded(
      child: Card(
        color: AppColors.surface,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        child: InkWell(
          onTap: onTap,
          borderRadius: BorderRadius.circular(16),
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 14, horizontal: 8),
            child: Column(
              children: [
                Container(
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: color.withOpacity(0.2),
                    shape: BoxShape.circle,
                  ),
                  child: Icon(icon, color: color, size: 20),
                ),
                const SizedBox(height: 8),
                Text(
                  title,
                  textAlign: TextAlign.center,
                  style: const TextStyle(fontSize: 11, fontWeight: FontWeight.bold),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
