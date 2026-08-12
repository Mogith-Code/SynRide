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
      backgroundColor: const Color(0xFFF8FAFC),
      appBar: AppBar(
        backgroundColor: const Color(0xFFF8FAFC),
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_rounded, color: Color(0xFF0F172A)),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text(
          'Shift & Waybill Report',
          style: TextStyle(
            color: Color(0xFF0F172A),
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
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
              child: Row(
                children: [
                  CircleAvatar(
                    radius: 28,
                    backgroundColor: const Color(0xFF10B981).withValues(alpha: 0.15),
                    child: const Icon(Icons.badge, color: Color(0xFF10B981), size: 30),
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
                            color: Color(0xFF0F172A),
                          ),
                        ),
                        Text(
                          'ID: ${shift.conductorId} • Bus: ${shift.busId}',
                          style: const TextStyle(color: Color(0xFF94A3B8), fontSize: 13),
                        ),
                        const SizedBox(height: 6),
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                          decoration: BoxDecoration(
                            color: const Color(0xFFECFDF5),
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: const Text(
                            '● SHIFT ACTIVE',
                            style: TextStyle(
                              fontSize: 10,
                              fontWeight: FontWeight.bold,
                              color: Color(0xFF10B981),
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
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16, color: Color(0xFF0F172A)),
            ),
            const SizedBox(height: 12),

            Row(
              children: [
                _buildStatCard('Total Revenue', 'LKR ${shift.totalRevenue.toStringAsFixed(0)}', const Color(0xFF10B981)),
                const SizedBox(width: 12),
                _buildStatCard('Tickets Issued', '${shift.totalTicketsIssued}', const Color(0xFF2563EB)),
              ],
            ),
            const SizedBox(height: 12),
            Row(
              children: [
                _buildStatCard('Shift Start', dateFormat.format(shift.startTime), const Color(0xFF0F172A), isSmall: true),
                const SizedBox(width: 12),
                _buildStatCard('Current Route', shift.routeNumber, const Color(0xFF0284C7), isSmall: true),
              ],
            ),
            const SizedBox(height: 24),

            // Revenue Breakdown by Channel
            Container(
              padding: const EdgeInsets.all(20),
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
                  const Text(
                    'Revenue Breakdown by Payment Channel',
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14, color: Color(0xFF0F172A)),
                  ),
                  const SizedBox(height: 16),
                  _buildPaymentRow(Icons.payments_outlined, 'Cash Collected', cashTotal, const Color(0xFF10B981)),
                  const Divider(height: 24, color: Color(0xFFF1F5F9)),
                  _buildPaymentRow(Icons.qr_code_2_rounded, 'SyncPass QR', qrTotal, const Color(0xFF2563EB)),
                  const Divider(height: 24, color: Color(0xFFF1F5F9)),
                  _buildPaymentRow(Icons.contactless_outlined, 'Contactless Card', cardTotal, const Color(0xFF8B5CF6)),
                ],
              ),
            ),
            const SizedBox(height: 32),

            // End Shift & Submit Waybill Button
            // End Shift & Submit Waybill Button
            SizedBox(
              width: double.infinity,
              height: 56,
              child: ElevatedButton.icon(
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFFEF4444),
                  foregroundColor: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16),
                  ),
                  elevation: 4,
                ),
                onPressed: () {
                  showDialog(
                    context: context,
                    builder: (context) => AlertDialog(
                      backgroundColor: Colors.white,
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
                      title: const Text(
                        'End Shift & Submit Waybill?',
                        style: TextStyle(color: Color(0xFF0F172A), fontWeight: FontWeight.bold),
                      ),
                      content: Text(
                        'Total tickets issued: ${shift.totalTicketsIssued}\nTotal revenue: LKR ${shift.totalRevenue.toStringAsFixed(2)}\n\nThis action will finalize your daily conductor waybill report and log you out of the session.',
                        style: const TextStyle(color: Color(0xFF64748B), fontSize: 13.5),
                      ),
                      actions: [
                        TextButton(
                          child: const Text('Cancel', style: TextStyle(color: Color(0xFF64748B), fontWeight: FontWeight.w600)),
                          onPressed: () => Navigator.pop(context),
                        ),
                        ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: const Color(0xFFEF4444),
                            foregroundColor: Colors.white,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                          ),
                          child: const Text('End Shift & Logout', style: TextStyle(fontWeight: FontWeight.bold)),
                          onPressed: () {
                            repository.endShift();
                            Navigator.pop(context);
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                content: Text('Shift Ended & Official Waybill Submitted! Logged Out.'),
                                backgroundColor: Color(0xFF10B981),
                              ),
                            );
                            Navigator.pushNamedAndRemoveUntil(context, '/conductor/login', (route) => false);
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
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: const Color(0xFFF1F5F9)),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.03),
              blurRadius: 8,
              offset: const Offset(0, 3),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Container(
                  width: 4,
                  height: 12,
                  margin: const EdgeInsets.only(right: 6),
                  decoration: BoxDecoration(
                    color: color,
                    borderRadius: BorderRadius.circular(2),
                  ),
                ),
                Text(label, style: const TextStyle(color: Color(0xFF64748B), fontSize: 11.5, fontWeight: FontWeight.w500)),
              ],
            ),
            const SizedBox(height: 6),
            Text(
              value,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(
                fontSize: isSmall ? 12.5 : 20,
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
        Container(
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: color.withValues(alpha: 0.12),
            borderRadius: BorderRadius.circular(10),
          ),
          child: Icon(icon, color: color, size: 20),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: Text(
            title,
            style: const TextStyle(fontWeight: FontWeight.w600, color: Color(0xFF0F172A), fontSize: 14),
          ),
        ),
        Text(
          'LKR ${amount.toStringAsFixed(2)}',
          style: TextStyle(fontWeight: FontWeight.bold, color: color, fontSize: 15),
        ),
      ],
    );
  }
}
