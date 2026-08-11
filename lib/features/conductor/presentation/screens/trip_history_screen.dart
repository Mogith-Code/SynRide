import 'package:flutter/material.dart';
import '../../../../core/constants/app_colors.dart';
import '../../data/repositories/ticket_repository.dart';
import '../widgets/digital_receipt_dialog.dart';
import 'package:intl/intl.dart';

class TripHistoryScreen extends StatefulWidget {
  const TripHistoryScreen({super.key});

  @override
  State<TripHistoryScreen> createState() => _TripHistoryScreenState();
}

class _TripHistoryScreenState extends State<TripHistoryScreen> {
  final TicketRepository _repository = TicketRepository();
  String _filter = 'All'; // 'All', 'Synced', 'Pending'
  String _searchQuery = '';

  @override
  Widget build(BuildContext context) {
    final tickets = _repository.tickets;
    final dateFormat = DateFormat('HH:mm - dd MMM');

    // Filter tickets
    final filteredTickets = tickets.where((t) {
      if (_filter == 'Synced' && !t.isSynced) return false;
      if (_filter == 'Pending' && t.isSynced) return false;
      if (_searchQuery.isNotEmpty) {
        final query = _searchQuery.toLowerCase();
        final matchesNumber = t.ticketNumber.toLowerCase().contains(query);
        final matchesOrigin = t.originStop.toLowerCase().contains(query);
        final matchesDest = t.destinationStop.toLowerCase().contains(query);
        return matchesNumber || matchesOrigin || matchesDest;
      }
      return true;
    }).toList();

    final totalRev = tickets.fold<double>(0, (sum, t) => sum + t.fareAmount);
    final pendingCount = tickets.where((t) => !t.isSynced).length;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Trip Ticket Log'),
      ),
      body: Column(
        children: [
          // Revenue & Ticket Summary Bar
          Container(
            padding: const EdgeInsets.all(16),
            color: AppColors.surface,
            child: Row(
              children: [
                _buildMetricItem('Total Tickets', '${tickets.length}', AppColors.primary),
                _buildMetricItem('Total Revenue', 'LKR ${totalRev.toStringAsFixed(0)}', AppColors.success),
                _buildMetricItem('Unsynced Queue', '$pendingCount', pendingCount > 0 ? AppColors.warning : AppColors.textSecondary),
              ],
            ),
          ),

          // Search & Filter Row
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              children: [
                TextField(
                  onChanged: (val) => setState(() => _searchQuery = val),
                  style: const TextStyle(color: AppColors.textPrimary),
                  decoration: InputDecoration(
                    hintText: 'Search ticket # or stop name...',
                    hintStyle: const TextStyle(color: AppColors.textSecondary),
                    prefixIcon: const Icon(Icons.search, color: AppColors.textSecondary),
                    filled: true,
                    fillColor: AppColors.surface,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(14),
                      borderSide: BorderSide(color: AppColors.surfaceLight.withValues(alpha: 0.5)),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(14),
                      borderSide: BorderSide(color: AppColors.surfaceLight.withValues(alpha: 0.5)),
                    ),
                    contentPadding: const EdgeInsets.symmetric(vertical: 12),
                  ),
                ),
                const SizedBox(height: 12),

                // Filter Pills
                Row(
                  children: ['All', 'Synced', 'Pending'].map((f) {
                    final isSelected = _filter == f;
                    return Padding(
                      padding: const EdgeInsets.only(right: 8.0),
                      child: ChoiceChip(
                        label: Text(f),
                        selected: isSelected,
                        selectedColor: AppColors.primary,
                        backgroundColor: AppColors.surface,
                        side: BorderSide(
                          color: isSelected ? AppColors.primary : AppColors.surfaceLight,
                        ),
                        labelStyle: TextStyle(
                          color: isSelected ? Colors.white : AppColors.textSecondary,
                          fontWeight: FontWeight.bold,
                        ),
                        onSelected: (selected) {
                          if (selected) setState(() => _filter = f);
                        },
                      ),
                    );
                  }).toList(),
                ),
              ],
            ),
          ),

          // Ticket List View
          Expanded(
            child: filteredTickets.isEmpty
                ? const Center(
                    child: Text(
                      'No tickets found.',
                      style: TextStyle(color: AppColors.textSecondary),
                    ),
                  )
                : ListView.builder(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    itemCount: filteredTickets.length,
                    itemBuilder: (context, index) {
                      final ticket = filteredTickets[index];

                      return Card(
                        color: AppColors.surface,
                        elevation: 0,
                        margin: const EdgeInsets.only(bottom: 12),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(16),
                          side: BorderSide(
                            color: AppColors.surfaceLight.withValues(alpha: 0.5),
                          ),
                        ),
                        child: InkWell(
                          onTap: () {
                            showDialog(
                              context: context,
                              builder: (context) => DigitalReceiptDialog(ticket: ticket),
                            );
                          },
                          borderRadius: BorderRadius.circular(16),
                          child: Padding(
                            padding: const EdgeInsets.all(16.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      ticket.ticketNumber,
                                      style: const TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 15,
                                        color: AppColors.primary,
                                      ),
                                    ),
                                    Container(
                                      padding: const EdgeInsets.symmetric(
                                        horizontal: 8,
                                        vertical: 3,
                                      ),
                                      decoration: BoxDecoration(
                                        color: ticket.isSynced
                                            ? AppColors.success.withValues(alpha: 0.15)
                                            : AppColors.warning.withValues(alpha: 0.15),
                                        borderRadius: BorderRadius.circular(8),
                                      ),
                                      child: Text(
                                        ticket.isSynced ? 'Synced' : 'Pending',
                                        style: TextStyle(
                                          fontSize: 11,
                                          fontWeight: FontWeight.bold,
                                          color: ticket.isSynced
                                              ? AppColors.success
                                              : AppColors.warning,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                                const SizedBox(height: 8),
                                Row(
                                  children: [
                                    const Icon(Icons.trip_origin, size: 14, color: AppColors.success),
                                    const SizedBox(width: 6),
                                    Text(
                                      ticket.originStop,
                                      style: const TextStyle(
                                        fontWeight: FontWeight.w500,
                                        fontSize: 13,
                                        color: AppColors.textPrimary,
                                      ),
                                    ),
                                    const Padding(
                                      padding: EdgeInsets.symmetric(horizontal: 6.0),
                                      child: Icon(Icons.arrow_forward, size: 12, color: AppColors.textSecondary),
                                    ),
                                    const Icon(Icons.location_on, size: 14, color: AppColors.danger),
                                    const SizedBox(width: 6),
                                    Text(
                                      ticket.destinationStop,
                                      style: const TextStyle(
                                        fontWeight: FontWeight.w500,
                                        fontSize: 13,
                                        color: AppColors.textPrimary,
                                      ),
                                    ),
                                  ],
                                ),
                                const SizedBox(height: 10),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      '${ticket.passengerType} (${ticket.paymentMethod}) • ${dateFormat.format(ticket.issuedAt)}',
                                      style: const TextStyle(
                                        fontSize: 11,
                                        color: AppColors.textSecondary,
                                      ),
                                    ),
                                    Text(
                                      'LKR ${ticket.fareAmount.toStringAsFixed(2)}',
                                      style: const TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 16,
                                        color: AppColors.textPrimary,
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ),
                      );
                    },
                  ),
          ),
        ],
      ),
    );
  }

  Widget _buildMetricItem(String label, String value, Color color) {
    return Expanded(
      child: Column(
        children: [
          Text(label, style: const TextStyle(color: AppColors.textSecondary, fontSize: 11)),
          const SizedBox(height: 4),
          Text(
            value,
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: color),
          ),
        ],
      ),
    );
  }
}
