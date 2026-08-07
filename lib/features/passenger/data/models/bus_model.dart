enum OccupancyStatus { low, moderate, high, full }

class BusModel {
  final String busId;
  final String routeNumber;
  final String routeName;
  final int totalCapacity;
  final int currentOccupancy;
  final double latitude;
  final double longitude;
  final int predictedEtaMinutes;
  final bool hasAvailableSeats;
  final String operatorName;
  final String busType;
  final String currentStop;
  final String nextStop;
  final int seatPredictionScore; // 0 to 100% chance of seat at next stop
  final double distanceKm;
  final double speedKmh;
  final List<String> stops;
  final Map<String, int> stopOccupancies;

  BusModel({
    required this.busId,
    required this.routeNumber,
    required this.routeName,
    required this.totalCapacity,
    required this.currentOccupancy,
    required this.latitude,
    required this.longitude,
    required this.predictedEtaMinutes,
    required this.hasAvailableSeats,
    this.operatorName = 'SLTB Express',
    this.busType = 'Semi-Comfortable AC',
    this.currentStop = 'Borella Junction',
    this.nextStop = 'Nawala Junction',
    this.seatPredictionScore = 85,
    this.distanceKm = 1.4,
    this.speedKmh = 32.5,
    this.stops = const [
      'Pettah Fort',
      'Torenton Square',
      'Borella Junction',
      'Nawala Junction',
      'Nugegoda Town',
      'Delkanda Junction',
      'Maharagama Depot',
    ],
    this.stopOccupancies = const {
      'Pettah Fort': 45,
      'Torenton Square': 48,
      'Borella Junction': 52,
      'Nawala Junction': 38,
      'Nugegoda Town': 25,
      'Delkanda Junction': 18,
      'Maharagama Depot': 5,
    },
  });

  double get occupancyPercentage =>
      totalCapacity > 0 ? (currentOccupancy / totalCapacity) * 100 : 0.0;

  OccupancyStatus get status {
    if (occupancyPercentage < 50) return OccupancyStatus.low;
    if (occupancyPercentage < 80) return OccupancyStatus.moderate;
    if (occupancyPercentage < 100) return OccupancyStatus.high;
    return OccupancyStatus.full;
  }

  BusModel copyWith({
    String? busId,
    String? routeNumber,
    String? routeName,
    int? totalCapacity,
    int? currentOccupancy,
    double? latitude,
    double? longitude,
    int? predictedEtaMinutes,
    bool? hasAvailableSeats,
    String? operatorName,
    String? busType,
    String? currentStop,
    String? nextStop,
    int? seatPredictionScore,
    double? distanceKm,
    double? speedKmh,
    List<String>? stops,
    Map<String, int>? stopOccupancies,
  }) {
    return BusModel(
      busId: busId ?? this.busId,
      routeNumber: routeNumber ?? this.routeNumber,
      routeName: routeName ?? this.routeName,
      totalCapacity: totalCapacity ?? this.totalCapacity,
      currentOccupancy: currentOccupancy ?? this.currentOccupancy,
      latitude: latitude ?? this.latitude,
      longitude: longitude ?? this.longitude,
      predictedEtaMinutes: predictedEtaMinutes ?? this.predictedEtaMinutes,
      hasAvailableSeats: hasAvailableSeats ?? this.hasAvailableSeats,
      operatorName: operatorName ?? this.operatorName,
      busType: busType ?? this.busType,
      currentStop: currentStop ?? this.currentStop,
      nextStop: nextStop ?? this.nextStop,
      seatPredictionScore: seatPredictionScore ?? this.seatPredictionScore,
      distanceKm: distanceKm ?? this.distanceKm,
      speedKmh: speedKmh ?? this.speedKmh,
      stops: stops ?? this.stops,
      stopOccupancies: stopOccupancies ?? this.stopOccupancies,
    );
  }
}
