import 'package:flutter/material.dart';
import '../../../../core/constants/app_colors.dart';
import '../../data/models/ticket_model.dart';
import 'package:intl/intl.dart';

class DigitalReceiptDialog extends StatelessWidget {
  final TicketModel ticket;

  const DigitalReceiptDialog({super.key, required this.ticket});

  @override
  Widget build(BuildContext context) {
    final dateFormat = DateFormat('yyyy-MM-dd HH:mm');

    return Dialog(
      backgroundColor: Colors.transparent,
      insetPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 24),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(20),
          boxShadow: const [
            BoxShadow(
              color: Colors.black45,
              blurRadius: 20,
              offset: Offset(0, 10),
            ),
          ],
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            // Thermal Receipt Header Banner
            Container(
              padding: const EdgeInsets.all(16),
              decoration: const BoxDecoration(
                color: AppColors.surface,
                borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
              ),
              child: Row(
                children: [
                  const Icon(Icons.confirmation_number, color: AppColors.primary),
                  const SizedBox(width: 10),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'SYNCRIDE DIGITAL TICKET',
                          style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 14,
                            letterSpacing: 1.0,
                          ),
                        ),
                        Text(
                          'Ticket #: ${ticket.ticketNumber}',
                          style: const TextStyle(
                            color: AppColors.textSecondary,
                            fontSize: 12,
                          ),
                        ),
                      ],
                    ),
                  ),
                  IconButton(
                    icon: const Icon(Icons.close, color: Colors.white),
                    onPressed: () => Navigator.pop(context),
                  ),
                ],
              ),
            ),

            // Thermal Paper Content Body
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                children: [
                  const Text(
                    '--- OFFICIAL BUS PASS ---',
                    style: TextStyle(
                      color: Colors.black54,
                      fontWeight: FontWeight.w600,
                      letterSpacing: 1.2,
                      fontSize: 12,
                    ),
                  ),
                  const SizedBox(height: 16),

                  // Route & Bus Details
                  _buildReceiptRow('Route', ticket.routeNumber, isBold: true),
                  _buildReceiptRow('Bus Unit', ticket.busId),
                  _buildReceiptRow('Conductor ID', ticket.conductorId),
                  _buildReceiptRow('Date & Time', dateFormat.format(ticket.issuedAt)),

                  const Divider(height: 24, color: Colors.black26, thickness: 1),

                  // Travel Details
                  _buildReceiptRow('Origin', ticket.originStop),
                  _buildReceiptRow('Destination', ticket.destinationStop),
                  _buildReceiptRow('Passenger Category', ticket.passengerType),
                  _buildReceiptRow('Passengers', '${ticket.passengerCount} Person(s)'),
                  _buildReceiptRow('Payment Method', ticket.paymentMethod),

                  const Divider(height: 24, color: Colors.black26, thickness: 1),

                  // Total Fare
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        'TOTAL FARE',
                        style: TextStyle(
                          color: Colors.black87,
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                        ),
                      ),
                      Text(
                        'LKR ${ticket.fareAmount.toStringAsFixed(2)}',
                        style: const TextStyle(
                          color: AppColors.primary,
                          fontWeight: FontWeight.bold,
                          fontSize: 22,
                        ),
                      ),
                    ],
                  ),

                  const SizedBox(height: 20),

                  // Simulated QR Code Container
                  Container(
                    width: 130,
                    height: 130,
                    padding: const EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      color: Colors.grey.shade100,
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(color: Colors.black12),
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Icon(Icons.qr_code_2_rounded, size: 84, color: Colors.black87),
                        const SizedBox(height: 2),
                        Text(
                          ticket.ticketId,
                          style: const TextStyle(
                            fontSize: 9,
                            color: Colors.black54,
                            fontFamily: 'monospace',
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    ticket.isSynced ? '✓ Cloud Synced Live' : '⏳ Pending Offline Queue',
                    style: TextStyle(
                      fontSize: 11,
                      fontWeight: FontWeight.bold,
                      color: ticket.isSynced ? AppColors.success : AppColors.warning,
                    ),
                  ),
                ],
              ),
            ),

            // Dialog Footer Action Buttons
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
              decoration: BoxDecoration(
                color: Colors.grey.shade100,
                borderRadius: const BorderRadius.vertical(bottom: Radius.circular(20)),
              ),
              child: Row(
                children: [
                  Expanded(
                    child: OutlinedButton.icon(
                      style: OutlinedButton.styleFrom(
                        foregroundColor: Colors.black87,
                        side: const BorderSide(color: Colors.black26),
                      ),
                      onPressed: () {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text('Simulated Thermal Receipt Print Sent!'),
                            duration: Duration(seconds: 2),
                          ),
                        );
                        Navigator.pop(context);
                      },
                      icon: const Icon(Icons.print_rounded, size: 18),
                      label: const Text('Print Receipt'),
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: ElevatedButton.icon(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppColors.primary,
                        foregroundColor: Colors.white,
                      ),
                      onPressed: () => Navigator.pop(context),
                      icon: const Icon(Icons.check_circle_outline, size: 18),
                      label: const Text('Done'),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildReceiptRow(String label, String value, {bool isBold = false}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 3.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            label,
            style: const TextStyle(color: Colors.black54, fontSize: 13),
          ),
          Text(
            value,
            style: TextStyle(
              color: Colors.black87,
              fontSize: 13,
              fontWeight: isBold ? FontWeight.bold : FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }
}
