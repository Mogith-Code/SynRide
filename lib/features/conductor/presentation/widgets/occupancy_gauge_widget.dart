import 'package:flutter/material.dart';
import '../../../../core/constants/app_colors.dart';

class OccupancyGaugeWidget extends StatelessWidget {
  final int currentOccupancy;
  final int totalCapacity;

  const OccupancyGaugeWidget({
    super.key,
    required this.currentOccupancy,
    required this.totalCapacity,
  });

  double get percentage =>
      totalCapacity > 0 ? (currentOccupancy / totalCapacity).clamp(0.0, 1.5) : 0.0;

  Color get statusColor {
    if (percentage >= 1.0) return AppColors.danger;
    if (percentage >= 0.85) return const Color(0xFFF97316); // Standing only / Orange
    if (percentage >= 0.60) return AppColors.warning;
    return AppColors.success;
  }

  String get statusText {
    if (percentage >= 1.0) return 'OVERCROWDED (+${currentOccupancy - totalCapacity})';
    if (percentage >= 0.85) return 'STANDING ONLY';
    if (percentage >= 0.60) return 'MODERATE SEATING';
    return 'SEATS AVAILABLE';
  }

  @override
  Widget build(BuildContext context) {
    final double displayPercent = (percentage * 100).clamp(0, 150);

    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(24),
        border: Border.all(
          color: statusColor.withValues(alpha: 0.3),
          width: 2,
        ),
        boxShadow: [
          BoxShadow(
            color: statusColor.withValues(alpha: 0.1),
            blurRadius: 16,
            spreadRadius: 2,
          ),
        ],
      ),
      child: Column(
        children: [
          Stack(
            alignment: Alignment.center,
            children: [
              SizedBox(
                width: 170,
                height: 170,
                child: CircularProgressIndicator(
                  value: percentage.clamp(0.0, 1.0),
                  strokeWidth: 14,
                  backgroundColor: AppColors.surfaceLight,
                  valueColor: AlwaysStoppedAnimation<Color>(statusColor),
                  strokeCap: StrokeCap.round,
                ),
              ),
              Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    '$currentOccupancy',
                    style: TextStyle(
                      fontSize: 48,
                      fontWeight: FontWeight.bold,
                      color: statusColor,
                      height: 1.0,
                    ),
                  ),
                  Text(
                    'of $totalCapacity Seats',
                    style: const TextStyle(
                      fontSize: 13,
                      color: AppColors.textSecondary,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                    decoration: BoxDecoration(
                      color: statusColor.withValues(alpha: 0.15),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Text(
                      '${displayPercent.toStringAsFixed(0)}%',
                      style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.bold,
                        color: statusColor,
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
          const SizedBox(height: 16),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            decoration: BoxDecoration(
              color: statusColor.withValues(alpha: 0.15),
              borderRadius: BorderRadius.circular(20),
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(
                  percentage >= 1.0
                      ? Icons.warning_amber_rounded
                      : (percentage >= 0.85 ? Icons.directions_bus : Icons.event_seat),
                  size: 18,
                  color: statusColor,
                ),
                const SizedBox(width: 8),
                Text(
                  statusText,
                  style: TextStyle(
                    color: statusColor,
                    fontWeight: FontWeight.bold,
                    fontSize: 13,
                    letterSpacing: 0.5,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
