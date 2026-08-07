import 'package:flutter/material.dart';
import '../../../../core/constants/app_colors.dart';
import '../../data/models/recommendation_model.dart';

class MultimodalRecommendationCard extends StatelessWidget {
  final RecommendationModel recommendation;
  final VoidCallback onTap;

  const MultimodalRecommendationCard({
    super.key,
    required this.recommendation,
    required this.onTap,
  });

  IconData _getModeIcon() {
    switch (recommendation.mode) {
      case TransportMode.train:
        return Icons.train_rounded;
      case TransportMode.expressBus:
        return Icons.directions_bus_filled_rounded;
      case TransportMode.bus:
        return Icons.directions_bus_rounded;
      case TransportMode.metro:
        return Icons.subway_rounded;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(18),
        border: Border.all(
          color: recommendation.isRecommended ? AppColors.accent : AppColors.surfaceLight,
          width: recommendation.isRecommended ? 1.5 : 1.0,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Container(
                    padding: const EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      color: AppColors.accent.withOpacity(0.2),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Icon(_getModeIcon(), color: AppColors.accent, size: 22),
                  ),
                  const SizedBox(width: 10),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        recommendation.title,
                        style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
                      ),
                      Text(
                        recommendation.alternativeRouteName,
                        style: const TextStyle(color: AppColors.textSecondary, fontSize: 12),
                      ),
                    ],
                  ),
                ],
              ),
              if (recommendation.isRecommended)
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                  decoration: BoxDecoration(
                    color: AppColors.accent.withOpacity(0.15),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: const Text(
                    '⚡ AI BEST PICK',
                    style: TextStyle(
                      fontSize: 10,
                      fontWeight: FontWeight.bold,
                      color: AppColors.accent,
                    ),
                  ),
                ),
            ],
          ),
          const SizedBox(height: 12),
          Text(
            recommendation.description,
            style: const TextStyle(fontSize: 13, color: AppColors.textPrimary),
          ),
          const SizedBox(height: 12),
          Row(
            children: [
              _buildBadge(Icons.timer_outlined, 'Saves ${recommendation.timeSavedMinutes} mins', AppColors.success),
              const SizedBox(width: 8),
              _buildBadge(Icons.people_outline, '${recommendation.crowdStatus} Crowd', AppColors.primary),
              const SizedBox(width: 8),
              _buildBadge(Icons.payments_outlined, 'Rs. ${recommendation.fareAmount.toStringAsFixed(0)}', AppColors.textSecondary),
            ],
          ),
          const SizedBox(height: 12),
          InkWell(
            onTap: onTap,
            borderRadius: BorderRadius.circular(10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Text(
                    'Transfer: ${recommendation.transferInstructions}',
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(fontSize: 11, color: AppColors.textSecondary),
                  ),
                ),
                const Icon(Icons.arrow_forward_ios, size: 12, color: AppColors.accent),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildBadge(IconData icon, String label, Color color) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        color: color.withOpacity(0.15),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: 12, color: color),
          const SizedBox(width: 4),
          Text(
            label,
            style: TextStyle(fontSize: 11, fontWeight: FontWeight.bold, color: color),
          ),
        ],
      ),
    );
  }
}
