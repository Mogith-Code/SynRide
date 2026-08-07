import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core/constants/app_colors.dart';
import '../../logic/conductor_cubit/conductor_cubit.dart';
import '../../logic/conductor_cubit/conductor_state.dart';
import '../../data/repositories/ticket_repository.dart';
import '../widgets/occupancy_gauge_widget.dart';
import '../widgets/ticket_counter_widget.dart';
import '../widgets/stop_selector_widget.dart';
import '../widgets/sync_status_badge.dart';

class ConductorHomeScreen extends StatelessWidget {
  const ConductorHomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ConductorCubit(repository: TicketRepository())..loadConductorData(),
      child: const _ConductorHomeScreenView(),
    );
  }
}

class _ConductorHomeScreenView extends StatelessWidget {
  const _ConductorHomeScreenView();

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ConductorCubit, ConductorState>(
      listener: (context, state) {
        if (state.message != null) {
          ScaffoldMessenger.of(context).hideCurrentSnackBar();
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(state.message!),
              duration: const Duration(seconds: 2),
              backgroundColor: state is ConductorError
                  ? AppColors.danger
                  : (state is OfflineSyncSuccess ? AppColors.success : AppColors.primary),
            ),
          );
        }
      },
      builder: (context, state) {
        final shift = state.shift;
        final cubit = context.read<ConductorCubit>();
        final pendingCount = state.tickets.where((t) => !t.isSynced).length;

        return Scaffold(
          appBar: AppBar(
            title: Column(
              children: [
                const Text(
                  'SyncRide Conductor Hub',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                Text(
                  '${shift.busId} • ${shift.routeNumber}',
                  style: const TextStyle(fontSize: 12, color: AppColors.accent),
                ),
              ],
            ),
            actions: [
              IconButton(
                icon: const Icon(Icons.swap_calls_rounded),
                tooltip: 'Toggle Network Mode',
                onPressed: () => cubit.toggleOnlineMode(!state.isOnline),
              ),
              IconButton(
                icon: const Icon(Icons.assignment_turned_in_outlined),
                tooltip: 'Shift Summary',
                onPressed: () => Navigator.pushNamed(context, '/conductor/shift'),
              ),
            ],
          ),
          body: SingleChildScrollView(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                // Network Sync Status Banner
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    SyncStatusBadge(
                      isOnline: state.isOnline,
                      pendingCount: pendingCount,
                      onTap: () => Navigator.pushNamed(context, '/conductor/sync-queue'),
                    ),
                    Text(
                      'Today\'s Rev: Rs. ${shift.totalRevenue.toStringAsFixed(0)}',
                      style: const TextStyle(
                        color: AppColors.accent,
                        fontWeight: FontWeight.bold,
                        fontSize: 13,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 16),

                // Occupancy Circular Gauge Meter
                OccupancyGaugeWidget(
                  currentOccupancy: shift.currentOccupancy,
                  totalCapacity: shift.totalCapacity,
                ),
                const SizedBox(height: 20),

                // Quick Increment / Alight Buttons
                TicketCounterWidget(
                  onIssueSingleTicket: () {
                    cubit.issueTicket(
                      originStop: shift.currentStop,
                      destinationStop: shift.nextStop,
                      passengerType: 'Adult',
                      paymentMethod: 'Cash',
                      passengerCount: 1,
                      fareAmount: 180.00,
                    );
                  },
                  onAlightPassenger: () => cubit.alightPassengers(1),
                  onQuickAdd: (count) => cubit.incrementPassengerCount(count),
                ),
                const SizedBox(height: 20),

                // Route Stop Sequence Stepper
                StopSelectorWidget(
                  stops: shift.stops,
                  currentStopIndex: shift.currentStopIndex,
                  onStopSelected: (index) => cubit.updateCurrentStop(index),
                ),
                const SizedBox(height: 24),

                // Action Grid Dashboard Buttons
                const Text(
                  'Conductor Operations',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 12),
                GridView.count(
                  crossAxisCount: 2,
                  crossAxisSpacing: 12,
                  mainAxisSpacing: 12,
                  childAspectRatio: 1.6,
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  children: [
                    _buildNavCard(
                      context,
                      title: 'Issue Custom Ticket',
                      subtitle: 'Full fare & stop selector',
                      icon: Icons.confirmation_number_rounded,
                      color: AppColors.primary,
                      onTap: () => Navigator.pushNamed(context, '/conductor/issue-ticket'),
                    ),
                    _buildNavCard(
                      context,
                      title: 'Trip History',
                      subtitle: '${state.tickets.length} Tickets issued',
                      icon: Icons.receipt_long_rounded,
                      color: AppColors.accent,
                      onTap: () => Navigator.pushNamed(context, '/conductor/history'),
                    ),
                    _buildNavCard(
                      context,
                      title: 'Offline Sync Queue',
                      subtitle: '$pendingCount Pending upload',
                      icon: Icons.sync_rounded,
                      color: pendingCount > 0 ? AppColors.warning : AppColors.success,
                      onTap: () => Navigator.pushNamed(context, '/conductor/sync-queue'),
                    ),
                    _buildNavCard(
                      context,
                      title: 'Shift & Waybill',
                      subtitle: 'Active: ${shift.conductorName}',
                      icon: Icons.badge_rounded,
                      color: AppColors.surfaceLight,
                      onTap: () => Navigator.pushNamed(context, '/conductor/shift'),
                    ),
                  ],
                ),
                const SizedBox(height: 20),
              ],
            ),
          ),
          floatingActionButton: FloatingActionButton.extended(
            backgroundColor: AppColors.success,
            onPressed: () => Navigator.pushNamed(context, '/conductor/issue-ticket'),
            icon: const Icon(Icons.add_shopping_cart_rounded),
            label: const Text(
              'NEW TICKET',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
          ),
        );
      },
    );
  }

  Widget _buildNavCard(
    BuildContext context, {
    required String title,
    required String subtitle,
    required IconData icon,
    required Color color,
    required VoidCallback onTap,
  }) {
    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(16),
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Row(
                children: [
                  Container(
                    padding: const EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      color: color.withOpacity(0.2),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Icon(icon, color: color, size: 20),
                  ),
                  const Spacer(),
                  const Icon(Icons.chevron_right, color: AppColors.textSecondary, size: 18),
                ],
              ),
              const SizedBox(height: 10),
              Text(
                title,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 13),
              ),
              const SizedBox(height: 2),
              Text(
                subtitle,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: const TextStyle(color: AppColors.textSecondary, fontSize: 11),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
