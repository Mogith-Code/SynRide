import 'package:flutter/material.dart';
import '../../../../core/constants/app_colors.dart';
import '../../data/repositories/ticket_repository.dart';
import '../widgets/digital_receipt_dialog.dart';

class TicketIssuanceScreen extends StatefulWidget {
  const TicketIssuanceScreen({super.key});

  @override
  State<TicketIssuanceScreen> createState() => _TicketIssuanceScreenState();
}

class _TicketIssuanceScreenState extends State<TicketIssuanceScreen> {
  final TicketRepository _repository = TicketRepository();

  late String _selectedOrigin;
  late String _selectedDestination;
  String _passengerType = 'Adult';
  String _paymentMethod = 'Cash';
  int _passengerCount = 1;

  final List<String> _passengerTypes = ['Adult', 'Child', 'Student', 'Senior'];
  final List<String> _paymentMethods = ['Cash', 'SyncPass QR', 'Contactless Card'];

  @override
  void initState() {
    super.initState();
    final shift = _repository.activeShift;
    _selectedOrigin = shift.currentStop;
    _selectedDestination = shift.stops.last;
  }

  double get _calculatedFare => _repository.calculateFare(
        origin: _selectedOrigin,
        destination: _selectedDestination,
        passengerType: _passengerType,
        passengerCount: _passengerCount,
      );

  void _onIssueTicketPressed() async {
    final ticket = await _repository.issueTicket(
      originStop: _selectedOrigin,
      destinationStop: _selectedDestination,
      passengerType: _passengerType,
      paymentMethod: _paymentMethod,
      passengerCount: _passengerCount,
      fareAmount: _calculatedFare,
    );

    if (!mounted) return;

    // Show thermal receipt modal
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => DigitalReceiptDialog(ticket: ticket),
    );
  }

  @override
  Widget build(BuildContext context) {
    final stops = _repository.activeShift.stops;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Digital Ticket Issuance'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Header Info Card
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: AppColors.surface,
                borderRadius: BorderRadius.circular(16),
              ),
              child: Row(
                children: [
                  const Icon(Icons.directions_bus, color: AppColors.primary, size: 28),
                  const SizedBox(width: 12),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        _repository.activeShift.routeNumber,
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                          color: AppColors.primary,
                        ),
                      ),
                      Text(
                        _repository.activeShift.routeName,
                        style: const TextStyle(color: AppColors.textSecondary, fontSize: 12),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            const SizedBox(height: 24),

            // Stop Selector Section
            const Text(
              'Journey Details',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
            ),
            const SizedBox(height: 12),

            // Origin Dropdown
            _buildDropdown(
              label: 'Boarding Stop (Origin)',
              icon: Icons.trip_origin,
              iconColor: AppColors.success,
              value: _selectedOrigin,
              items: stops,
              onChanged: (val) {
                if (val != null) setState(() => _selectedOrigin = val);
              },
            ),
            const SizedBox(height: 12),

            // Destination Dropdown
            _buildDropdown(
              label: 'Destination Stop',
              icon: Icons.location_on,
              iconColor: AppColors.danger,
              value: _selectedDestination,
              items: stops,
              onChanged: (val) {
                if (val != null) setState(() => _selectedDestination = val);
              },
            ),
            const SizedBox(height: 24),

            // Passenger Category Chips
            const Text(
              'Passenger Category',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
            ),
            const SizedBox(height: 10),
            Row(
              children: _passengerTypes.map((type) {
                final isSelected = _passengerType == type;
                return Padding(
                  padding: const EdgeInsets.only(right: 8.0),
                  child: FilterChip(
                    label: Text(type),
                    selected: isSelected,
                    selectedColor: AppColors.primary.withOpacity(0.3),
                    checkmarkColor: AppColors.primary,
                    onSelected: (selected) {
                      if (selected) setState(() => _passengerType = type);
                    },
                  ),
                );
              }).toList(),
            ),
            const SizedBox(height: 24),

            // Passenger Count Stepper & Payment Method
            Row(
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'Quantity',
                        style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14),
                      ),
                      const SizedBox(height: 8),
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                        decoration: BoxDecoration(
                          color: AppColors.surface,
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            IconButton(
                              icon: const Icon(Icons.remove_circle_outline),
                              onPressed: _passengerCount > 1
                                  ? () => setState(() => _passengerCount--)
                                  : null,
                            ),
                            Text(
                              '$_passengerCount',
                              style: const TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            IconButton(
                              icon: const Icon(Icons.add_circle_outline),
                              onPressed: () => setState(() => _passengerCount++),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'Payment Method',
                        style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14),
                      ),
                      const SizedBox(height: 8),
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 12),
                        decoration: BoxDecoration(
                          color: AppColors.surface,
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: DropdownButtonHideUnderline(
                          child: DropdownButton<String>(
                            value: _paymentMethod,
                            isExpanded: true,
                            items: _paymentMethods.map((pm) {
                              return DropdownMenuItem(value: pm, child: Text(pm));
                            }).toList(),
                            onChanged: (val) {
                              if (val != null) setState(() => _paymentMethod = val);
                            },
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(height: 28),

            // Total Fare Display Card
            Container(
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: AppColors.surface,
                borderRadius: BorderRadius.circular(20),
                border: Border.all(color: AppColors.primary.withOpacity(0.4)),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'Calculated Fare',
                        style: TextStyle(color: AppColors.textSecondary, fontSize: 13),
                      ),
                      Text(
                        '$_passengerCount x $_passengerType Pass',
                        style: const TextStyle(fontSize: 12, fontWeight: FontWeight.w500),
                      ),
                    ],
                  ),
                  Text(
                    'Rs. ${_calculatedFare.toStringAsFixed(2)}',
                    style: const TextStyle(
                      fontSize: 28,
                      fontWeight: FontWeight.bold,
                      color: AppColors.primary,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 32),

            // Issue Ticket Big Action Button
            SizedBox(
              width: double.infinity,
              height: 56,
              child: ElevatedButton.icon(
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.success,
                  foregroundColor: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16),
                  ),
                  elevation: 6,
                ),
                onPressed: _onIssueTicketPressed,
                icon: const Icon(Icons.print_rounded, size: 24),
                label: const Text(
                  'ISSUE & PRINT TICKET',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildDropdown({
    required String label,
    required IconData icon,
    required Color iconColor,
    required String value,
    required List<String> items,
    required ValueChanged<String?> onChanged,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label, style: const TextStyle(color: AppColors.textSecondary, fontSize: 12)),
        const SizedBox(height: 6),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
          decoration: BoxDecoration(
            color: AppColors.surface,
            borderRadius: BorderRadius.circular(14),
          ),
          child: Row(
            children: [
              Icon(icon, color: iconColor, size: 20),
              const SizedBox(width: 12),
              Expanded(
                child: DropdownButtonHideUnderline(
                  child: DropdownButton<String>(
                    value: value,
                    isExpanded: true,
                    items: items.map((stop) {
                      return DropdownMenuItem(value: stop, child: Text(stop));
                    }).toList(),
                    onChanged: onChanged,
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
