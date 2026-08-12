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
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Row(
                children: [
                  Icon(Icons.location_on, color: Color(0xFF10B981), size: 20),
                  SizedBox(width: 8),
                  Text(
                    'Route Stop Progress',
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14, color: Color(0xFF0F172A)),
                  ),
                ],
              ),
              Text(
                'Stop ${currentStopIndex + 1} of ${stops.length}',
                style: const TextStyle(fontSize: 12, color: Color(0xFF94A3B8)),
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
                          ? const Color(0xFF10B981)
                          : (isPast ? const Color(0xFFECFDF5) : const Color(0xFFF8FAFC)),
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(
                        color: isCurrent
                            ? const Color(0xFF10B981)
                            : (isPast
                                ? const Color(0xFFA7F3D0)
                                : const Color(0xFFE2E8F0)),
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
                          color: isCurrent ? Colors.white : (isPast ? const Color(0xFF10B981) : const Color(0xFF94A3B8)),
                        ),
                        const SizedBox(width: 6),
                        Text(
                          stops[index],
                          style: TextStyle(
                            fontSize: 13,
                            fontWeight: isCurrent ? FontWeight.bold : FontWeight.normal,
                            color: isCurrent ? Colors.white : const Color(0xFF0F172A),
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
