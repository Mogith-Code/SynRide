import 'dart:math';

class EtaPredictionService {
  /// Calculate predicted ETA in minutes based on distance (km), average speed (km/h), traffic factor, and passenger delay factor.
  static int predictEtaMinutes({
    required double distanceKm,
    double averageSpeedKmH = 35.0,
    double trafficCongestionFactor = 1.2, // 1.0 = clear, >1.0 = heavy traffic
    int stopCount = 3,
  }) {
    if (distanceKm <= 0) return 0;
    
    final baseTimeHours = distanceKm / max(averageSpeedKmH, 5.0);
    final adjustedMinutes = baseTimeHours * 60 * trafficCongestionFactor;
    
    // Allow 1.5 minutes per intermediate bus stop
    final totalEtaMinutes = adjustedMinutes + (stopCount * 1.5);
    
    return max(1, totalEtaMinutes.round());
  }

  /// Predict seat availability status at downstream stop given current occupancy and historical boarding rate.
  static String predictSeatAvailability({
    required int currentOccupancy,
    required int maxCapacity,
    int stopsAway = 2,
  }) {
    final availableSeats = maxCapacity - currentOccupancy;
    if (availableSeats <= 0) {
      return 'Standing Only';
    } else if (availableSeats < 10) {
      return 'Few Seats ($availableSeats left)';
    } else {
      return 'Seats Available ($availableSeats left)';
    }
  }
}
