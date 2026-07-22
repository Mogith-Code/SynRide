import 'package:flutter/material.dart';
import '../../data/models/bus_model.dart';
import '../../../../core/constants/app_colors.dart';

class OccupancyIndicatorWidget extends StatelessWidget {
  final OccupancyStatus status;
  final double percentage;

  const OccupancyIndicatorWidget({
    super.key,
    required this.status,
    required this.percentage,
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
        return 'Low Crowd (Seats Free)';
      case OccupancyStatus.moderate:
        return 'Moderate Crowd';
      case OccupancyStatus.high:
        return 'Standing Only';
      case OccupancyStatus.full:
        return 'Bus Overcrowded';
    }
  }

  @override
  Widget build(BuildContext context) {
    final color = _getStatusColor();
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      decoration: BoxDecoration(
        color: color.withOpacity(0.15),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: color, width: 1),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          CircleAvatar(radius: 4, backgroundColor: color),
          const SizedBox(width: 8),
          Text(
            '${_getStatusLabel()} (${percentage.toStringAsFixed(0)}%)',
            style: TextStyle(color: color, fontWeight: FontWeight.bold, fontSize: 12),
          ),
        ],
      ),
    );
  }
}
