enum TransportMode { bus, train, expressBus, metro }

class RecommendationModel {
  final String recommendationId;
  final String title;
  final String description;
  final TransportMode mode;
  final String primaryRouteNumber;
  final String alternativeRouteName;
  final int totalDurationMinutes;
  final int timeSavedMinutes;
  final String crowdStatus; // 'Low', 'Moderate', 'High'
  final double fareAmount;
  final String transferInstructions;
  final bool isRecommended;

  RecommendationModel({
    required this.recommendationId,
    required this.title,
    required this.description,
    required this.mode,
    required this.primaryRouteNumber,
    required this.alternativeRouteName,
    required this.totalDurationMinutes,
    required this.timeSavedMinutes,
    required this.crowdStatus,
    required this.fareAmount,
    required this.transferInstructions,
    this.isRecommended = true,
  });
}
