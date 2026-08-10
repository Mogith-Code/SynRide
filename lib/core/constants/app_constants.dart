class AppConstants {
  static const String appName = 'SyncRide';
  static const String appVersion = '1.0.0';

  // Realtime Sync Intervals
  static const int locationUpdateIntervalSeconds = 5;
  static const int occupancySyncIntervalSeconds = 3;

  // Local Storage
  static const String sqliteDbName = 'syncride_conductor_offline.db';
  static const int sqliteDbVersion = 1;
  static const String offlineTicketsTable = 'offline_tickets';

  // Bus Defaults
  static const int defaultBusCapacity = 45;
  static const double speedKmHDefault = 35.0;

  // Occupancy Thresholds
  static const double occupancyLowThreshold = 0.40;
  static const double occupancyMediumThreshold = 0.75;
  static const double occupancyHighThreshold = 0.90;
}
