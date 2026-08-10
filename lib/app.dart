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
      },
    );
  }
}
