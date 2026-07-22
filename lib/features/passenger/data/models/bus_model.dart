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
  });

  double get occupancyPercentage => (currentOccupancy / totalCapacity) * 100;

  OccupancyStatus get status {
    if (occupancyPercentage < 50) return OccupancyStatus.low;
    if (occupancyPercentage < 80) return OccupancyStatus.moderate;
    if (occupancyPercentage < 100) return OccupancyStatus.high;
    return OccupancyStatus.full;
  }
}
