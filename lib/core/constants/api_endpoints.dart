class ApiEndpoints {
  static const String baseUrl = 'https://api.syncride.transport.gov';
  static const String realtimeDbUrl = 'https://syncride-default-rtdb.firebaseio.com';

  // Auth
  static const String login = '$baseUrl/v1/auth/login';
  static const String register = '$baseUrl/v1/auth/register';

  // Bus & Routes
  static const String getBuses = '$baseUrl/v1/buses';
  static const String getBusDetails = '$baseUrl/v1/buses/';
  static const String getRoutes = '$baseUrl/v1/routes';
  static const String getRecommendations = '$baseUrl/v1/routes/recommendations';

  // Conductor Ticketing
  static const String issueTicket = '$baseUrl/v1/conductor/tickets';
  static const String syncOfflineTickets = '$baseUrl/v1/conductor/sync';

  // Analytics
  static const String getAuthorityMetrics = '$baseUrl/v1/analytics/metrics';
  static const String getHeatmapData = '$baseUrl/v1/analytics/heatmap';

  // WebSocket / Realtime paths
  static const String busLocationStream = 'buses/locations';
  static const String busOccupancyStream = 'buses/occupancy';
}
