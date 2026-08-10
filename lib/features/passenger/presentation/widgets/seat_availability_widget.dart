import 'package:flutter/material.dart';
import '../../../../core/constants/app_colors.dart';
import '../../data/models/bus_model.dart';

class SeatAvailabilityWidget extends StatelessWidget {
  final BusModel bus;

  const SeatAvailabilityWidget({super.key, required this.bus});

  @override
  Widget build(BuildContext context) {
    final entries = bus.stopOccupancies.entries.toList();

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
            children: const [
              Icon(Icons.insights_rounded, color: AppColors.accent, size: 20),
              SizedBox(width: 8),
              Text(
                'AI Smart Boarding - Seat Availability Forecast',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14),
              ),
            ],
          ),
          const SizedBox(height: 12),
          SizedBox(
            height: 92,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: entries.length,
              itemBuilder: (context, index) {
                final stopName = entries[index].key;
                final onboardCount = entries[index].value;
                final freeSeats = (bus.totalCapacity - onboardCount).clamp(0, bus.totalCapacity);
                final seatPercent = ((freeSeats / bus.totalCapacity) * 100).round();

                final isGood = seatPercent >= 40;

                return Container(
                  width: 110,
                  margin: const EdgeInsets.only(right: 10),
                  padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    color: isGood
                        ? AppColors.success.withOpacity(0.12)
                        : AppColors.warning.withOpacity(0.12),
                    borderRadius: BorderRadius.circular(14),
                    border: Border.all(
                      color: isGood ? AppColors.success.withOpacity(0.4) : AppColors.warning.withOpacity(0.4),
                    ),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        stopName,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 12),
                      ),
                      Row(
                        children: [
                          Icon(
                            isGood ? Icons.event_seat : Icons.person_off,
                            size: 14,
                            color: isGood ? AppColors.success : AppColors.warning,
                          ),
                          const SizedBox(width: 4),
                          Text(
                            '$freeSeats Seats',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 13,
                              color: isGood ? AppColors.success : AppColors.warning,
                            ),
                          ),
                        ],
                      ),
                      Text(
                        '$seatPercent% Boarding Prob',
                        style: const TextStyle(fontSize: 10, color: AppColors.textSecondary),
                      ),
                    ],
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
