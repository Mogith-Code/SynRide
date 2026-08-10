import 'package:flutter/material.dart';
import '../../../../core/constants/app_colors.dart';

class StopSelectorWidget extends StatelessWidget {
  final List<String> stops;
  final int currentStopIndex;
  final Function(int) onStopSelected;

  const StopSelectorWidget({
    super.key,
    required this.stops,
    required this.currentStopIndex,
    required this.onStopSelected,
  });

  @override
  Widget build(BuildContext context) {
    if (stops.isEmpty) return const SizedBox.shrink();

    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Row(
                children: [
                  Icon(Icons.location_on, color: AppColors.primary, size: 20),
                  SizedBox(width: 8),
                  Text(
                    'Route Stop Progress',
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14),
                  ),
                ],
              ),
              Text(
                'Stop ${currentStopIndex + 1} of ${stops.length}',
                style: const TextStyle(fontSize: 12, color: AppColors.textSecondary),
              ),
            ],
          ),
          const SizedBox(height: 12),
          SizedBox(
            height: 48,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: stops.length,
              itemBuilder: (context, index) {
                final isCurrent = index == currentStopIndex;
                final isPast = index < currentStopIndex;

                return GestureDetector(
                  onTap: () => onStopSelected(index),
                  child: Container(
                    margin: const EdgeInsets.only(right: 8),
                    padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                    decoration: BoxDecoration(
                      color: isCurrent
                          ? AppColors.primary
                          : (isPast ? AppColors.surfaceLight : AppColors.background),
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(
                        color: isCurrent
                            ? AppColors.primary
                            : (isPast
                                ? AppColors.surfaceLight
                                : AppColors.textSecondary.withValues(alpha: 0.3)),
                      ),
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(
                          isCurrent
                              ? Icons.directions_bus
                              : (isPast ? Icons.check_circle : Icons.circle_outlined),
                          size: 16,
                          color: isCurrent ? Colors.white : (isPast ? AppColors.success : AppColors.textSecondary),
                        ),
                        const SizedBox(width: 6),
                        Text(
                          stops[index],
                          style: TextStyle(
                            fontSize: 13,
                            fontWeight: isCurrent ? FontWeight.bold : FontWeight.normal,
                            color: isCurrent ? Colors.white : AppColors.textPrimary,
                          ),
                        ),
                      ],
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
}
