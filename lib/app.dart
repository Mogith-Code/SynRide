import 'package:flutter/material.dart';
import 'core/theme/app_theme.dart';
import 'features/passenger/presentation/screens/welcome_splash_screen.dart';
import 'features/passenger/presentation/screens/onboarding_screen.dart';
import 'features/passenger/presentation/screens/login_screen.dart';
import 'features/passenger/presentation/screens/passenger_home_screen.dart';
import 'features/passenger/presentation/screens/location_tracker_search_screen.dart';
import 'features/passenger/presentation/screens/live_map_screen.dart';
import 'features/passenger/presentation/screens/route_recommendation_screen.dart';
import 'features/passenger/presentation/screens/bus_details_screen.dart';
import 'features/passenger/presentation/screens/live_occupancy_screen.dart';
import 'features/passenger/presentation/screens/passenger_profile_screen.dart';
import 'features/passenger/presentation/screens/notifications_screen.dart';
import 'features/conductor/presentation/screens/conductor_login_screen.dart';
import 'features/conductor/presentation/screens/conductor_home_screen.dart';
import 'features/conductor/presentation/screens/ticket_issuance_screen.dart';
import 'features/conductor/presentation/screens/trip_history_screen.dart';
import 'features/conductor/presentation/screens/offline_sync_queue_screen.dart';
import 'features/conductor/presentation/screens/shift_management_screen.dart';
import 'features/conductor/presentation/screens/passenger_exit_screen.dart';
import 'features/conductor/presentation/screens/trip_summary_screen.dart';
import 'features/analytics_dashboard/presentation/screens/authority_dashboard_screen.dart';

class SyncRideApp extends StatelessWidget {
  const SyncRideApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'SyncRide',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.darkTheme,
      initialRoute: '/',
      routes: {
        '/': (context) => const WelcomeSplashScreen(),
        '/passenger/onboarding': (context) => const OnboardingScreen(),
        '/passenger/login': (context) => const LoginScreen(),
        '/passenger/register': (context) => const LoginScreen(initialIsLogin: false),
        '/passenger/home': (context) => const PassengerHomeScreen(),
        '/passenger/search': (context) => const LocationTrackerSearchScreen(),
        '/passenger/map': (context) => const LiveMapScreen(),
        '/passenger/recommendations': (context) => const RouteRecommendationScreen(),
        '/passenger/bus-details': (context) => const BusDetailsScreen(),
        '/passenger/occupancy': (context) => const LiveOccupancyScreen(),
        '/passenger/pass': (context) => const PassengerProfileScreen(),
        '/passenger/profile': (context) => const PassengerProfileScreen(),
        '/passenger/notifications': (context) => const NotificationsScreen(),
        '/conductor/login': (context) => const ConductorLoginScreen(),
        '/conductor/portal': (context) => const ConductorLoginScreen(),
        '/conductor/home': (context) => const ConductorHomeScreen(),
        '/conductor/issue-ticket': (context) => const TicketIssuanceScreen(),
        '/conductor/history': (context) => const TripHistoryScreen(),
        '/conductor/sync-queue': (context) => const OfflineSyncQueueScreen(),
        '/conductor/shift': (context) => const ShiftManagementScreen(),
        '/conductor/passenger-exit': (context) => const PassengerExitScreen(),
        '/conductor/exit': (context) => const PassengerExitScreen(),
        '/conductor/trip-summary': (context) => const TripSummaryScreen(),
        '/conductor/summary': (context) => const TripSummaryScreen(),
        '/admin': (context) => const AuthorityDashboardScreen(),
        '/admin/dashboard': (context) => const AuthorityDashboardScreen(),
        '/authority': (context) => const AuthorityDashboardScreen(),
      },
    );
  }
}

