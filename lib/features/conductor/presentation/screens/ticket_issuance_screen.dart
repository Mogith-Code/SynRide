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

  String? _selectedTicketType;

  // Ticket Options Data matching UI spec
  final List<Map<String, dynamic>> _ticketOptions = [
    {
      'type': 'Adult',
      'price': 25,
      'priceDisplay': 'LKR 25',
      'color': const Color(0xFF3B82F6), // Blue
    },
    {
      'type': 'Child',
      'price': 15,
      'priceDisplay': 'LKR 15',
      'color': const Color(0xFF10B981), // Teal/Green
    },
    {
      'type': 'Student',
      'price': 12,
      'priceDisplay': 'LKR 12',
      'color': const Color(0xFF06B6D4), // Cyan
    },
    {
      'type': 'Senior',
      'price': 10,
      'priceDisplay': 'LKR 10',
      'color': const Color(0xFFF59E0B), // Amber/Orange
    },
  ];

  void _handleIssueTicket() async {
    if (_selectedTicketType == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Please select a ticket type first.'),
          backgroundColor: AppColors.warning,
        ),
      );
      return;
    }

    final selectedOpt = _ticketOptions.firstWhere(
      (opt) => opt['type'] == _selectedTicketType,
    );

    final shift = _repository.activeShift;

    // Issue ticket in repository
    final ticket = await _repository.issueTicket(
      originStop: shift.currentStop,
      destinationStop: shift.nextStop,
      passengerType: selectedOpt['type'],
      paymentMethod: 'Cash',
      passengerCount: 1,
      fareAmount: (selectedOpt['price'] as int).toDouble(),
    );

    if (!mounted) return;

    // Show thermal receipt modal
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => DigitalReceiptDialog(ticket: ticket),
    ).then((_) {
      setState(() {
        _selectedTicketType = null;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    final shift = _repository.activeShift;
    final int currentPassengers = shift.currentOccupancy;
    final int capacity = shift.totalCapacity;
    final int seatsAvailable = (capacity - currentPassengers).clamp(0, capacity);
    final double capacityRatio =
        capacity > 0 ? (currentPassengers / capacity).clamp(0.0, 1.0) : 0.0;

    final int totalTickets = shift.totalTicketsIssued;
    final double totalRevenue = shift.totalRevenue;
    final int avgTrip = 34;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Issue Ticket'),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Top Emerald Container: Current Passengers
              _buildCurrentPassengersCard(
                currentPassengers: currentPassengers,
                capacity: capacity,
                seatsAvailable: seatsAvailable,
                capacityRatio: capacityRatio,
              ),

              const SizedBox(height: 24),

              // Section Title: Select Ticket Type
              const Text(
                'Select Ticket Type',
                style: TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.bold,
                  color: AppColors.textPrimary,
                ),
              ),

              const SizedBox(height: 12),

              // 2x2 Ticket Options Grid
              _buildTicketTypeGrid(),

              const SizedBox(height: 24),

              // Issue Ticket Action Button
              GestureDetector(
                onTap: _handleIssueTicket,
                child: Container(
                  width: double.infinity,
                  height: 54,
                  decoration: BoxDecoration(
                    gradient: _selectedTicketType != null
                        ? const LinearGradient(
                            colors: [
                              AppColors.primary,
                              AppColors.accent,
                            ],
                          )
                        : null,
                    color: _selectedTicketType == null
                        ? AppColors.surfaceLight.withValues(alpha: 0.5)
                        : null,
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.confirmation_number_outlined,
                        size: 20,
                        color: _selectedTicketType != null
                            ? Colors.white
                            : AppColors.textSecondary,
                      ),
                      const SizedBox(width: 8),
                      Text(
                        _selectedTicketType != null
                            ? 'Issue $_selectedTicketType Ticket'
                            : 'Select Ticket Type Above',
                        style: TextStyle(
                          fontSize: 15.5,
                          fontWeight: FontWeight.bold,
                          color: _selectedTicketType != null
                              ? Colors.white
                              : AppColors.textSecondary,
                        ),
                      ),
                    ],
                  ),
                ),
              ),

              const SizedBox(height: 24),

              // Bottom 3 Metrics Cards Row
              Row(
                children: [
                  Expanded(
                    child: _buildBottomStatCard(
                      value: '$totalTickets',
                      label: 'Issued Today',
                    ),
                  ),
                  const SizedBox(width: 10),
                  Expanded(
                    child: _buildBottomStatCard(
                      value: 'LKR ${totalRevenue.toStringAsFixed(0)}',
                      label: 'Revenue',
                    ),
                  ),
                  const SizedBox(width: 10),
                  Expanded(
                    child: _buildBottomStatCard(
                      value: '$avgTrip',
                      label: 'Avg/Trip',
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }

  // Top Emerald Green Passengers Card
  Widget _buildCurrentPassengersCard({
    required int currentPassengers,
    required int capacity,
    required int seatsAvailable,
    required double capacityRatio,
  }) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 22.0),
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(22),
        border: Border.all(color: AppColors.primary.withValues(alpha: 0.5)),
        boxShadow: [
          BoxShadow(
            color: AppColors.primary.withValues(alpha: 0.1),
            blurRadius: 16,
            spreadRadius: 1,
            offset: const Offset(0, 6),
          ),
        ],
      ),
      child: Column(
        children: [
          const Text(
            'Current Passengers',
            style: TextStyle(
              color: AppColors.textSecondary,
              fontSize: 13,
              fontWeight: FontWeight.w500,
            ),
          ),
          const SizedBox(height: 6),
          Text(
            '$currentPassengers',
            style: const TextStyle(
              color: AppColors.primary,
              fontSize: 44,
              fontWeight: FontWeight.bold,
              letterSpacing: -1,
              height: 1.1,
            ),
          ),
          Text(
            'of $capacity capacity',
            style: const TextStyle(
              color: AppColors.textSecondary,
              fontSize: 12.5,
              fontWeight: FontWeight.w400,
            ),
          ),

          const SizedBox(height: 16),

          // Horizontal Progress Pill
          Container(
            height: 7,
            width: double.infinity,
            decoration: BoxDecoration(
              color: AppColors.surfaceLight,
              borderRadius: BorderRadius.circular(4),
            ),
            child: FractionallySizedBox(
              alignment: Alignment.centerLeft,
              widthFactor: capacityRatio,
              child: Container(
                decoration: BoxDecoration(
                  color: AppColors.primary,
                  borderRadius: BorderRadius.circular(4),
                ),
              ),
            ),
          ),

          const SizedBox(height: 10),

          Text(
            '$seatsAvailable seats available',
            style: const TextStyle(
              color: AppColors.textPrimary,
              fontSize: 12.5,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }

  // 2x2 Ticket Type Selector Grid
  Widget _buildTicketTypeGrid() {
    return Column(
      children: [
        Row(
          children: [
            Expanded(child: _buildTicketTypeCard(_ticketOptions[0])),
            const SizedBox(width: 12),
            Expanded(child: _buildTicketTypeCard(_ticketOptions[1])),
          ],
        ),
        const SizedBox(width: 12, height: 12),
        Row(
          children: [
            Expanded(child: _buildTicketTypeCard(_ticketOptions[2])),
            const SizedBox(width: 12),
            Expanded(child: _buildTicketTypeCard(_ticketOptions[3])),
          ],
        ),
      ],
    );
  }

  // Single Ticket Type Card
  Widget _buildTicketTypeCard(Map<String, dynamic> option) {
    final String type = option['type'];
    final String priceDisplay = option['priceDisplay'];
    final Color color = option['color'];
    final bool isSelected = _selectedTicketType == type;

    return GestureDetector(
      onTap: () {
        setState(() {
          _selectedTicketType = type;
        });
      },
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 180),
        padding: const EdgeInsets.symmetric(vertical: 18.0, horizontal: 16.0),
        decoration: BoxDecoration(
          color: AppColors.surface,
          borderRadius: BorderRadius.circular(20),
          border: Border.all(
            color: isSelected ? AppColors.primary : AppColors.surfaceLight.withValues(alpha: 0.5),
            width: isSelected ? 2.0 : 1.0,
          ),
          boxShadow: [
            BoxShadow(
              color: isSelected
                  ? AppColors.primary.withValues(alpha: 0.15)
                  : Colors.black.withValues(alpha: 0.1),
              blurRadius: isSelected ? 12 : 8,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Column(
          children: [
            Text(
              type,
              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: AppColors.textPrimary,
              ),
            ),
            const SizedBox(height: 4),
            Text(
              priceDisplay,
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.bold,
                color: color,
              ),
            ),
          ],
        ),
      ),
    );
  }

  // Bottom Summary Stat Card
  Widget _buildBottomStatCard({
    required String value,
    required String label,
  }) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 14.0, horizontal: 12.0),
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: AppColors.surfaceLight.withValues(alpha: 0.5)),
      ),
      child: Column(
        children: [
          Text(
            value,
            style: const TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: AppColors.textPrimary,
              letterSpacing: -0.3,
            ),
          ),
          const SizedBox(height: 2),
          Text(
            label,
            style: const TextStyle(
              fontSize: 11,
              fontWeight: FontWeight.w500,
              color: AppColors.textSecondary,
            ),
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
        ],
      ),
    );
  }
}
