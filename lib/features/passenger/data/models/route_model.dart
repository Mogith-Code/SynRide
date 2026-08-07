class RouteModel {
  final String routeId;
  final String routeNumber;
  final String routeName;
  final String origin;
  final String destination;
  final int totalStops;
  final int frequencyMinutes;
  final double baseFare;
  final int activeBusesCount;
  final String distanceKm;

  RouteModel({
    required this.routeId,
    required this.routeNumber,
    required this.routeName,
    required this.origin,
    required this.destination,
    required this.totalStops,
    required this.frequencyMinutes,
    required this.baseFare,
    required this.activeBusesCount,
    required this.distanceKm,
  });
}
