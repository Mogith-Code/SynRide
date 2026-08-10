class AnalyticsModel {
  final int totalBusesActive;
  final int totalPassengersToday;
  final double averageOccupancyRate;
  final double averageDelayMinutes;
  final Map<String, double> hourlyDemand;
  final List<HeatmapPoint> congestionHeatmap;

  const AnalyticsModel({
    required this.totalBusesActive,
    required this.totalPassengersToday,
    required this.averageOccupancyRate,
    required this.averageDelayMinutes,
    required this.hourlyDemand,
    required this.congestionHeatmap,
  });

  factory AnalyticsModel.fromJson(Map<String, dynamic> json) {
    return AnalyticsModel(
      totalBusesActive: json['totalBusesActive'] ?? 0,
      totalPassengersToday: json['totalPassengersToday'] ?? 0,
      averageOccupancyRate: (json['averageOccupancyRate'] ?? 0.0).toDouble(),
      averageDelayMinutes: (json['averageDelayMinutes'] ?? 0.0).toDouble(),
      hourlyDemand: Map<String, double>.from(json['hourlyDemand'] ?? {}),
      congestionHeatmap: (json['congestionHeatmap'] as List<dynamic>? ?? [])
          .map((e) => HeatmapPoint.fromJson(e as Map<String, dynamic>))
          .toList(),
    );
  }
}

class HeatmapPoint {
  final double latitude;
  final double longitude;
  final double intensity;

  const HeatmapPoint({
    required this.latitude,
    required this.longitude,
    required this.intensity,
  });

  factory HeatmapPoint.fromJson(Map<String, dynamic> json) {
    return HeatmapPoint(
      latitude: (json['latitude'] ?? 0.0).toDouble(),
      longitude: (json['longitude'] ?? 0.0).toDouble(),
      intensity: (json['intensity'] ?? 0.0).toDouble(),
    );
  }
}
