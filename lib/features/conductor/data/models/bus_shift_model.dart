class BusShiftModel {
  final String shiftId;
  final String busId;
  final String routeNumber;
  final String routeName;
  final String conductorId;
  final String conductorName;
  final int totalCapacity;
  final int currentOccupancy;
  final int currentStopIndex;
  final List<String> stops;
  final DateTime startTime;
  final bool isActive;
  final double totalRevenue;
  final int totalTicketsIssued;

  BusShiftModel({
    required this.shiftId,
    required this.busId,
    required this.routeNumber,
    required this.routeName,
    required this.conductorId,
    required this.conductorName,
    required this.totalCapacity,
    required this.currentOccupancy,
    required this.currentStopIndex,
    required this.stops,
    required this.startTime,
    this.isActive = true,
    this.totalRevenue = 0.0,
    this.totalTicketsIssued = 0,
  });

  String get currentStop => stops.isNotEmpty && currentStopIndex < stops.length
      ? stops[currentStopIndex]
      : 'Depot';

  String get nextStop => stops.isNotEmpty && currentStopIndex + 1 < stops.length
      ? stops[currentStopIndex + 1]
      : 'Terminal Destination';

  double get occupancyPercentage =>
      totalCapacity > 0 ? (currentOccupancy / totalCapacity) * 100 : 0.0;

  String get occupancyStatus {
    if (occupancyPercentage >= 100) return 'Overcrowded';
    if (occupancyPercentage >= 85) return 'Standing Only';
    if (occupancyPercentage >= 60) return 'Moderate';
    return 'Seats Available';
  }

  BusShiftModel copyWith({
    String? shiftId,
    String? busId,
    String? routeNumber,
    String? routeName,
    String? conductorId,
    String? conductorName,
    int? totalCapacity,
    int? currentOccupancy,
    int? currentStopIndex,
    List<String>? stops,
    DateTime? startTime,
    bool? isActive,
    double? totalRevenue,
    int? totalTicketsIssued,
  }) {
    return BusShiftModel(
      shiftId: shiftId ?? this.shiftId,
      busId: busId ?? this.busId,
      routeNumber: routeNumber ?? this.routeNumber,
      routeName: routeName ?? this.routeName,
      conductorId: conductorId ?? this.conductorId,
      conductorName: conductorName ?? this.conductorName,
      totalCapacity: totalCapacity ?? this.totalCapacity,
      currentOccupancy: currentOccupancy ?? this.currentOccupancy,
      currentStopIndex: currentStopIndex ?? this.currentStopIndex,
      stops: stops ?? this.stops,
      startTime: startTime ?? this.startTime,
      isActive: isActive ?? this.isActive,
      totalRevenue: totalRevenue ?? this.totalRevenue,
      totalTicketsIssued: totalTicketsIssued ?? this.totalTicketsIssued,
    );
  }
}
