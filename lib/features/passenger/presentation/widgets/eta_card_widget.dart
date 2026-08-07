import 'package:flutter/material.dart';
import '../../../../core/constants/app_colors.dart';
import '../../data/models/bus_model.dart';

class EtaCardWidget extends StatelessWidget {
  final BusModel bus;

  const EtaCardWidget({super.key, required this.bus});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: AppColors.surfaceLight.withOpacity(0.5),
        borderRadius: BorderRadius.circular(14),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          // ETA Pill
          Row(
            children: [
              Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: AppColors.primary.withOpacity(0.2),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: const Icon(Icons.timer_rounded, color: AppColors.primary, size: 20),
              ),
              const SizedBox(width: 10),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'AI PREDICTED ETA',
                    style: TextStyle(fontSize: 10, color: AppColors.textSecondary, letterSpacing: 0.5),
                  ),
                  Text(
                    '${bus.predictedEtaMinutes} Mins Away',
                    style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 14, color: AppColors.primary),
                  ),
                ],
              ),
            ],
          ),

          // Seat Predictor Badge
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
            decoration: BoxDecoration(
              color: bus.seatPredictionScore > 50
                  ? AppColors.success.withOpacity(0.15)
                  : AppColors.warning.withOpacity(0.15),
              borderRadius: BorderRadius.circular(12),
              border: Border.all(
                color: bus.seatPredictionScore > 50 ? AppColors.success : AppColors.warning,
                width: 1,
              ),
            ),
            child: Row(
              children: [
                Icon(
                  Icons.event_seat_rounded,
                  size: 14,
                  color: bus.seatPredictionScore > 50 ? AppColors.success : AppColors.warning,
                ),
                const SizedBox(width: 6),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      '${bus.seatPredictionScore}% Seat Chance',
                      style: TextStyle(
                        fontSize: 11,
                        fontWeight: FontWeight.bold,
                        color: bus.seatPredictionScore > 50 ? AppColors.success : AppColors.warning,
                      ),
                    ),
                    Text(
                      'at ${bus.nextStop}',
                      style: const TextStyle(fontSize: 9, color: AppColors.textSecondary),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
