import '../models/bus_model.dart';
import '../models/route_model.dart';
import '../models/recommendation_model.dart';

class PassengerRepository {
  final List<BusModel> _mockBuses = [
    BusModel(
      busId: 'BUS-101',
      routeNumber: 'Route 138',
      routeName: 'Pettah - Maharagama Express',
      totalCapacity: 54,
      currentOccupancy: 22,
      latitude: 6.9271,
      longitude: 79.8612,
      predictedEtaMinutes: 4,
      hasAvailableSeats: true,
      operatorName: 'SLTB Colombo Depot',
      busType: 'Semi-Luxury AC',
      currentStop: 'Borella Junction',
      nextStop: 'Nawala Junction',
      seatPredictionScore: 88,
      distanceKm: 1.2,
      speedKmh: 34.0,
    ),
    BusModel(
      busId: 'BUS-204',
      routeNumber: 'Route 100',
      routeName: 'Panadura - Colombo Fort',
      totalCapacity: 54,
      currentOccupancy: 52,
      latitude: 6.8480,
      longitude: 79.9265,
      predictedEtaMinutes: 12,
      hasAvailableSeats: false,
      operatorName: 'Western Provincial Transit',
      busType: 'Standard City Commuter',
      currentStop: 'Mount Lavinia',
      nextStop: 'Dehiwala Flyover',
      seatPredictionScore: 15,
      distanceKm: 4.8,
      speedKmh: 28.0,
    ),
    BusModel(
      busId: 'BUS-318',
      routeNumber: 'Route 120',
      routeName: 'Horana - Pettah Central',
      totalCapacity: 60,
      currentOccupancy: 36,
      latitude: 6.8650,
      longitude: 79.8980,
      predictedEtaMinutes: 7,
      hasAvailableSeats: true,
      operatorName: 'SLTB Horana Depot',
      busType: 'Air-Conditioned Express',
      currentStop: 'Pamankada Bridge',
      nextStop: 'Havelock Town',
      seatPredictionScore: 65,
      distanceKm: 2.3,
      speedKmh: 38.5,
    ),
    BusModel(
      busId: 'BUS-409',
      routeNumber: 'Route 177',
      routeName: 'Kaduwela - Kollupitiya',
      totalCapacity: 50,
      currentOccupancy: 50,
      latitude: 6.9010,
      longitude: 79.9120,
      predictedEtaMinutes: 18,
      hasAvailableSeats: false,
      operatorName: 'City Link Ltd',
      busType: 'Regular Transit',
      currentStop: 'Battaramulla',
      nextStop: 'Rajagiriya Junction',
      seatPredictionScore: 5,
      distanceKm: 6.1,
      speedKmh: 22.0,
    ),
  ];

  final List<RouteModel> _mockRoutes = [
    RouteModel(
      routeId: 'R-138',
      routeNumber: 'Route 138',
      routeName: 'Pettah - Maharagama',
      origin: 'Pettah Fort',
      destination: 'Maharagama Depot',
      totalStops: 18,
      frequencyMinutes: 5,
      baseFare: 80.0,
      activeBusesCount: 14,
      distanceKm: '18.4 km',
    ),
    RouteModel(
      routeId: 'R-100',
      routeNumber: 'Route 100',
      routeName: 'Panadura - Colombo Fort',
      origin: 'Panadura Station',
      destination: 'Colombo Fort',
      totalStops: 24,
      frequencyMinutes: 8,
      baseFare: 110.0,
      activeBusesCount: 10,
      distanceKm: '27.2 km',
    ),
  ];

  final List<RecommendationModel> _mockRecommendations = [
    RecommendationModel(
      recommendationId: 'REC-01',
      title: 'Kelani Valley Commuter Line',
      description: 'Avoid Route 100 severe congestion (52/54 full). Take Express Train from Nugegoda Station.',
      mode: TransportMode.train,
      primaryRouteNumber: 'Route 100',
      alternativeRouteName: 'Kelani Valley Railway (Train #9142)',
      totalDurationMinutes: 18,
      timeSavedMinutes: 14,
      crowdStatus: 'Low',
      fareAmount: 60.00,
      transferInstructions: 'Walk 120m to Nugegoda Platform 1 -> Board Colombo Fort bound Train at 08:42 AM.',
      isRecommended: true,
    ),
    RecommendationModel(
      recommendationId: 'REC-02',
      title: 'Multimodal Express Bus 138/1',
      description: 'Air-Conditioned Express Bypass via Marine Drive.',
      mode: TransportMode.expressBus,
      primaryRouteNumber: 'Route 177',
      alternativeRouteName: 'Route 138/1 Highway Shuttle',
      totalDurationMinutes: 22,
      timeSavedMinutes: 9,
      crowdStatus: 'Moderate',
      fareAmount: 180.00,
      transferInstructions: 'Board at Rajagiriya Express Bay.',
      isRecommended: false,
    ),
  ];

  List<BusModel> get liveBuses => List.unmodifiable(_mockBuses);
  List<RouteModel> get routes => List.unmodifiable(_mockRoutes);
  List<RecommendationModel> get recommendations => List.unmodifiable(_mockRecommendations);

  // Search live buses by query or stop
  List<BusModel> searchBuses(String query) {
    if (query.trim().isEmpty) return liveBuses;
    final q = query.toLowerCase();
    return _mockBuses.where((b) {
      final matchesRoute = b.routeNumber.toLowerCase().contains(q);
      final matchesName = b.routeName.toLowerCase().contains(q);
      final matchesStop = b.currentStop.toLowerCase().contains(q) ||
          b.nextStop.toLowerCase().contains(q);
      return matchesRoute || matchesName || matchesStop;
    }).toList();
  }

  // Filter buses with available seating
  List<BusModel> getBusesWithSeats() {
    return _mockBuses.where((b) => b.hasAvailableSeats).toList();
  }

  // Get specific bus details by ID
  BusModel? getBusById(String busId) {
    try {
      return _mockBuses.firstWhere((b) => b.busId == busId);
    } catch (_) {
      return _mockBuses.isNotEmpty ? _mockBuses.first : null;
    }
  }
}
