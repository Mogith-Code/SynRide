import 'package:flutter/material.dart';
import '../../../../core/constants/app_colors.dart';

class TicketCounterWidget extends StatelessWidget {
  final VoidCallback onIssueSingleTicket;
  final VoidCallback onAlightPassenger;
  final Function(int) onQuickAdd;

  const TicketCounterWidget({
    super.key,
    required this.onIssueSingleTicket,
    required this.onAlightPassenger,
    required this.onQuickAdd,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // Quick increment pills
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              'Quick Boarding:',
              style: TextStyle(fontSize: 12, color: AppColors.textSecondary),
            ),
            const SizedBox(width: 8),
            _buildPill(context, '+1', 1),
            _buildPill(context, '+2', 2),
            _buildPill(context, '+3', 3),
            _buildPill(context, '+5', 5),
          ],
        ),
        const SizedBox(height: 12),

        // Main Ergonomic Action Buttons
        Row(
          children: [
            Expanded(
              child: ElevatedButton.icon(
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.danger.withValues(alpha: 0.9),
                  foregroundColor: Colors.white,
                  padding: const EdgeInsets.symmetric(vertical: 18),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16),
                  ),
                  elevation: 4,
                ),
                onPressed: onAlightPassenger,
                icon: const Icon(Icons.person_remove_rounded, size: 24),
                label: const Text(
                  'Alighted (-1)',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: ElevatedButton.icon(
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.success,
                  foregroundColor: Colors.white,
                  padding: const EdgeInsets.symmetric(vertical: 18),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16),
                  ),
                  elevation: 4,
                ),
                onPressed: onIssueSingleTicket,
                icon: const Icon(Icons.confirmation_number_rounded, size: 24),
                label: const Text(
                  'Issue Ticket (+1)',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildPill(BuildContext context, String label, int count) {
    return Padding(
      padding: const EdgeInsets.only(right: 6.0),
      child: InkWell(
        onTap: () => onQuickAdd(count),
        borderRadius: BorderRadius.circular(12),
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
          decoration: BoxDecoration(
            color: AppColors.surfaceLight,
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: AppColors.primary.withValues(alpha: 0.4)),
          ),
          child: Text(
            label,
            style: const TextStyle(
              color: AppColors.primary,
              fontWeight: FontWeight.bold,
              fontSize: 13,
            ),
          ),
        ),
      ),
    );
  }
}
