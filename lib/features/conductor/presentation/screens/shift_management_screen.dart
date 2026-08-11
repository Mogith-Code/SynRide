import 'package:flutter/material.dart';
import '../../../../core/constants/app_colors.dart';
import '../../data/repositories/ticket_repository.dart';
import 'package:intl/intl.dart';

class ShiftManagementScreen extends StatelessWidget {
  const ShiftManagementScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final repository = TicketRepository();
    final shift = repository.activeShift;
    final tickets = repository.tickets;
    final dateFormat = DateFormat('EEE, dd MMM yyyy • HH:mm');

    // Payment breakdowns
    double cashTotal = 0;
    double qrTotal = 0;
    double cardTotal = 0;

    for (var t in tickets) {
      if (t.paymentMethod == 'Cash') cashTotal += t.fareAmount;
      if (t.paymentMethod == 'SyncPass QR') qrTotal += t.fareAmount;
      if (t.paymentMethod == 'Contactless Card') cardTotal += t.fareAmount;
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text('Shift & Waybill Report'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Conductor Profile & Active Shift Badge
            Container(
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: AppColors.surface,
                borderRadius: BorderRadius.circular(20),
              ),
              child: Row(
                children: [
                  CircleAvatar(
                    radius: 28,
                    backgroundColor: AppColors.primary.withValues(alpha: 0.2),
                    child: const Icon(Icons.badge, color: AppColors.primary, size: 30),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          shift.conductorName,
                          style: const TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text(
                          'ID: ${shift.conductorId} • Bus: ${shift.busId}',
                          style: const TextStyle(color: AppColors.textSecondary, fontSize: 13),
                        ),
                        const SizedBox(height: 4),
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                          decoration: BoxDecoration(
                            color: AppColors.success.withValues(alpha: 0.15),
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: const Text(
                            '● SHIFT ACTIVE',
                            style: TextStyle(
                              fontSize: 10,
                              fontWeight: FontWeight.bold,
                              color: AppColors.success,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 24),

            // Trip & Shift Overview Metrics
            const Text(
              'Live Shift Financial Summary',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
            ),
            const SizedBox(height: 12),

            Row(
              children: [
                _buildStatCard('Total Revenue', 'LKR ${shift.totalRevenue.toStringAsFixed(0)}', AppColors.success),
                const SizedBox(width: 12),
                _buildStatCard('Tickets Issued', '${shift.totalTicketsIssued}', AppColors.primary),
              ],
            ),
            const SizedBox(height: 12),
            Row(
              children: [
                _buildStatCard('Shift Start', dateFormat.format(shift.startTime), AppColors.textPrimary, isSmall: true),
                const SizedBox(width: 12),
                _buildStatCard('Current Route', shift.routeNumber, AppColors.accent, isSmall: true),
              ],
            ),
            const SizedBox(height: 24),

            // Revenue Breakdown by Channel
            Container(
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: AppColors.surface,
                borderRadius: BorderRadius.circular(20),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Revenue Breakdown by Payment Channel',
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14),
                  ),
                  const SizedBox(height: 16),
                  _buildPaymentRow(Icons.payments, 'Cash Collection', cashTotal, AppColors.success),
                  const Divider(height: 20),
                  _buildPaymentRow(Icons.qr_code_scanner, 'SyncPass QR Payments', qrTotal, AppColors.primary),
                  const Divider(height: 20),
                  _buildPaymentRow(Icons.credit_card, 'Contactless Card', cardTotal, AppColors.accent),
                ],
              ),
            ),
            const SizedBox(height: 32),

            // End Shift & Submit Waybill Button
            SizedBox(
              width: double.infinity,
              height: 56,
              child: ElevatedButton.icon(
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.danger,
                  foregroundColor: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16),
                  ),
                ),
                onPressed: () {
                  showDialog(
                    context: context,
                    builder: (context) => AlertDialog(
                      backgroundColor: AppColors.surface,
                      title: const Text('End Shift & Submit Waybill?'),
                      content: Text(
                        'Total tickets issued: ${shift.totalTicketsIssued}\nTotal revenue: LKR ${shift.totalRevenue.toStringAsFixed(2)}\n\nThis action will finalize your daily conductor waybill report.',
                      ),
                      actions: [
                        TextButton(
                          child: const Text('Cancel'),
                          onPressed: () => Navigator.pop(context),
                        ),
                        ElevatedButton(
                          style: ElevatedButton.styleFrom(backgroundColor: AppColors.danger),
                          child: const Text('End Shift'),
                          onPressed: () {
                            Navigator.pop(context);
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                content: Text('Shift Ended & Official Waybill Submitted!'),
                                backgroundColor: AppColors.success,
                              ),
                            );
                          },
                        ),
                      ],
                    ),
                  );
                },
                icon: const Icon(Icons.power_settings_new_rounded),
                label: const Text(
                  'END SHIFT & SUBMIT WAYBILL',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildStatCard(String label, String value, Color color, {bool isSmall = false}) {
    return Expanded(
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: AppColors.surface,
          borderRadius: BorderRadius.circular(16),
          border: Border(left: BorderSide(color: color, width: 4)),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(label, style: const TextStyle(color: AppColors.textSecondary, fontSize: 11)),
            const SizedBox(height: 6),
            Text(
              value,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(
                fontSize: isSmall ? 13 : 20,
                fontWeight: FontWeight.bold,
                color: color,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildPaymentRow(IconData icon, String title, double amount, Color color) {
    return Row(
      children: [
        Icon(icon, color: color, size: 20),
        const SizedBox(width: 12),
        Expanded(
          child: Text(title, style: const TextStyle(fontWeight: FontWeight.w500)),
        ),
        Text(
          'LKR ${amount.toStringAsFixed(2)}',
          style: TextStyle(fontWeight: FontWeight.bold, color: color, fontSize: 15),
        ),
      ],
    );
  }
}
