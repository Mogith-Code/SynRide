import 'package:flutter/material.dart';
import 'core/theme/app_theme.dart';
import 'features/passenger/presentation/screens/passenger_home_screen.dart';
import 'features/conductor/presentation/screens/conductor_home_screen.dart';
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
        '/': (context) => const PassengerHomeScreen(),
        '/conductor': (context) => const ConductorHomeScreen(),
        '/authority': (context) => const AuthorityDashboardScreen(),
      },
    );
  }
}
