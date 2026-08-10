import 'package:flutter/material.dart';
import '../../data/models/bus_model.dart';
import '../../../../core/constants/app_colors.dart';

class OccupancyIndicatorWidget extends StatelessWidget {
  final OccupancyStatus status;
  final double percentage;
  final bool showLabelOnly;

  const OccupancyIndicatorWidget({
    super.key,
    required this.status,
    required this.percentage,
    this.showLabelOnly = false,
  });

  Color _getStatusColor() {
    switch (status) {
      case OccupancyStatus.low:
        return AppColors.success;
      case OccupancyStatus.moderate:
        return AppColors.accent;
      case OccupancyStatus.high:
        return AppColors.warning;
      case OccupancyStatus.full:
        return AppColors.danger;
    }
  }

  String _getStatusLabel() {
    switch (status) {
      case OccupancyStatus.low:
        return 'Seats Free';
      case OccupancyStatus.moderate:
        return 'Moderate Crowd';
      case OccupancyStatus.high:
        return 'Standing Only';
      case OccupancyStatus.full:
        return 'Overcrowded';
    }
  }

  IconData _getStatusIcon() {
    switch (status) {
      case OccupancyStatus.low:
        return Icons.event_seat_rounded;
      case OccupancyStatus.moderate:
        return Icons.directions_bus_rounded;
      case OccupancyStatus.high:
        return Icons.people_alt_rounded;
      case OccupancyStatus.full:
        return Icons.warning_rounded;
    }
  }

  @override
  Widget build(BuildContext context) {
    final color = _getStatusColor();

    if (showLabelOnly) {
      return Container(
        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
        decoration: BoxDecoration(
          color: color.withValues(alpha: 0.15),
          borderRadius: BorderRadius.circular(10),
        ),
        child: Text(
          '${_getStatusLabel()} (${percentage.toStringAsFixed(0)}%)',
          style: TextStyle(color: color, fontWeight: FontWeight.bold, fontSize: 11),
        ),
      );
    }

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.15),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: color.withValues(alpha: 0.6), width: 1.2),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(_getStatusIcon(), size: 14, color: color),
          const SizedBox(width: 6),
          Text(
            '${_getStatusLabel()} • ${percentage.toStringAsFixed(0)}%',
            style: TextStyle(color: color, fontWeight: FontWeight.bold, fontSize: 12),
          ),
        ],
      ),
    );
  }
}
