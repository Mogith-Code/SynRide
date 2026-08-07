import 'package:flutter/material.dart';
import '../../../../core/constants/app_colors.dart';
import '../../data/repositories/passenger_repository.dart';
import '../widgets/multimodal_recommendation_card.dart';

class RouteRecommendationScreen extends StatelessWidget {
  const RouteRecommendationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final repository = PassengerRepository();
    final recommendations = repository.recommendations;

    return Scaffold(
      appBar: AppBar(
        title: const Text('AI Multimodal Route Finder'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Congestion Alert Header
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: AppColors.surface,
                borderRadius: BorderRadius.circular(20),
                border: Border.all(color: AppColors.warning.withOpacity(0.5)),
              ),
              child: Row(
                children: [
                  const Icon(Icons.warning_amber_rounded, color: AppColors.warning, size: 32),
                  const SizedBox(width: 14),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: const [
                        Text(
                          'Route 100 & 177 Heavy Delays',
                          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15, color: AppColors.warning),
                        ),
                        SizedBox(height: 2),
                        Text(
                          'Bus occupancy at 96% capacity. AI Engine suggests alternative multimodal transit options below.',
                          style: TextStyle(color: AppColors.textSecondary, fontSize: 12),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 24),

            // AI Recommendations List Header
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  'Recommended Alternative Routes',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                ),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                  decoration: BoxDecoration(
                    color: AppColors.accent.withOpacity(0.15),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: const Text(
                    'AI POWERED',
                    style: TextStyle(fontSize: 10, fontWeight: FontWeight.bold, color: AppColors.accent),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 12),

            // Recommendations Cards
            ListView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: recommendations.length,
              itemBuilder: (context, index) {
                final rec = recommendations[index];
                return MultimodalRecommendationCard(
                  recommendation: rec,
                  onTap: () {
                    showModalBottomSheet(
                      context: context,
                      backgroundColor: AppColors.surface,
                      shape: const RoundedRectangleBorder(
                        borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
                      ),
                      builder: (context) => Padding(
                        padding: const EdgeInsets.all(24.0),
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              rec.title,
                              style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: AppColors.accent),
                            ),
                            const SizedBox(height: 6),
                            Text(rec.alternativeRouteName, style: const TextStyle(color: AppColors.textSecondary)),
                            const Divider(height: 24),
                            const Text('Step-by-Step Directions:', style: TextStyle(fontWeight: FontWeight.bold)),
                            const SizedBox(height: 8),
                            Text('1. ${rec.transferInstructions}'),
                            const SizedBox(height: 4),
                            Text('2. Total journey duration: ${rec.totalDurationMinutes} mins.'),
                            const SizedBox(height: 4),
                            Text('3. Estimated Fare: Rs. ${rec.fareAmount.toStringAsFixed(0)}'),
                            const SizedBox(height: 20),
                            SizedBox(
                              width: double.infinity,
                              child: ElevatedButton(
                                style: ElevatedButton.styleFrom(backgroundColor: AppColors.accent),
                                onPressed: () => Navigator.pop(context),
                                child: const Text('Start Navigation', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
