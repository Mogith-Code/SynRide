import 'package:flutter/material.dart';

class WelcomeSplashScreen extends StatelessWidget {
  const WelcomeSplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF0B172A), // Dark ambient slate background
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: const BoxDecoration(
          gradient: RadialGradient(
            center: Alignment(0.5, -0.4),
            radius: 1.3,
            colors: [
              Color(0xFF152A4A), // Deep navy blue glow
              Color(0xFF0B172A), // Dark slate blue
              Color(0xFF060D19), // Deep dark space
            ],
          ),
        ),
        child: SafeArea(
          child: Column(
            children: [
              // Top Bar Header
              _buildTopHeader(),

              Expanded(
                child: SingleChildScrollView(
                  physics: const BouncingScrollPhysics(),
                  padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 20.0),
                  child: Column(
                    children: [
                      const SizedBox(height: 20),
                      // Main Icon Square
                      Container(
                        width: 104,
                        height: 104,
                        decoration: BoxDecoration(
                          gradient: const LinearGradient(
                            begin: Alignment.topLeft,
                            end: Alignment.bottomRight,
                            colors: [
                              Color(0xFF0072FF),
                              Color(0xFF00C6FF),
                            ],
                          ),
                          borderRadius: BorderRadius.circular(28),
                          border: Border.all(
                            color: const Color(0xFF00E5FF).withValues(alpha: 0.4),
                            width: 1.5,
                          ),
                          boxShadow: [
                            BoxShadow(
                              color: const Color(0xFF00C6FF).withValues(alpha: 0.35),
                              blurRadius: 24,
                              spreadRadius: 2,
                              offset: const Offset(0, 8),
                            ),
                          ],
                        ),
                        child: const Center(
                          child: Icon(
                            Icons.directions_bus_rounded,
                            size: 54,
                            color: Colors.white,
                          ),
                        ),
                      ),

                      const SizedBox(height: 24),

                      ShaderMask(
                        shaderCallback: (bounds) => const LinearGradient(
                          colors: [
                            Color(0xFF38BDF8),
                            Color(0xFF34D399),
                          ],
                        ).createShader(bounds),
                        child: const Text(
                          'Next-Gen Smart Public Transportation Platform',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 32,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                            letterSpacing: -0.8,
                          ),
                        ),
                      ),

                      const SizedBox(height: 16),

                      // Subtitle
                      ConstrainedBox(
                        constraints: const BoxConstraints(maxWidth: 680),
                        child: const Text(
                          'A production-ready AI platform for real-time bus tracking, occupancy prediction, route optimization, and transportation analytics — built for national hackathon competition.',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 14.5,
                            color: Color(0xFF94A3B8),
                            height: 1.5,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                      ),

                      const SizedBox(height: 28),

                      // Stat Metrics Row (4 Metrics)
                      _buildStatsMetricsRow(),

                      const SizedBox(height: 40),

                      // 3 Module Launch Cards Grid
                      _buildModuleCardsGrid(context),

                      const SizedBox(height: 48),

                      // Footer Text
                      const Text(
                        'SyncRide — AI-Powered Smart Public Transportation Intelligence Platform',
                        style: TextStyle(
                          fontSize: 12,
                          color: Color(0xFF64748B),
                          letterSpacing: 0.3,
                        ),
                      ),

                      const SizedBox(height: 16),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // Top Navigation Bar
  Widget _buildTopHeader() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 14.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          // Logo & Name
          Row(
            children: [
              Container(
                width: 36,
                height: 36,
                decoration: BoxDecoration(
                  color: const Color(0xFF2563EB),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: const Icon(
                  Icons.directions_bus_rounded,
                  color: Colors.white,
                  size: 22,
                ),
              ),
              const SizedBox(width: 10),
              const Text(
                'SyncRide',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                  letterSpacing: -0.3,
                ),
              ),
            ],
          ),

          // Hackathon Demo Badge
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 6),
            decoration: BoxDecoration(
              color: Colors.white.withValues(alpha: 0.06),
              borderRadius: BorderRadius.circular(20),
              border: Border.all(color: Colors.white.withValues(alpha: 0.12)),
            ),
            child: Row(
              children: const [
                Icon(Icons.circle, color: Color(0xFF10B981), size: 7),
                SizedBox(width: 6),
                Text(
                  'Hackathon Demo',
                  style: TextStyle(
                    color: Colors.white70,
                    fontSize: 12.5,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // Stats Metrics Row
  Widget _buildStatsMetricsRow() {
    return Wrap(
      alignment: WrapAlignment.center,
      spacing: 24,
      runSpacing: 12,
      children: const [
        _StatItem(icon: Icons.directions_bus_outlined, value: '1,240', label: 'Active Buses'),
        _StatItem(icon: Icons.people_outline_rounded, value: '2.4M', label: 'Daily Riders'),
        _StatItem(icon: Icons.map_outlined, value: '387', label: 'Routes Covered'),
        _StatItem(icon: Icons.memory_rounded, value: '94.2%', label: 'AI Accuracy'),
      ],
    );
  }

  // 3 Module Launch Cards Grid
  Widget _buildModuleCardsGrid(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final isMobile = constraints.maxWidth < 800;

        return isMobile
            ? Column(
                children: [
                  _buildPassengerCard(context),
                  const SizedBox(height: 20),
                  _buildConductorCard(context),
                  const SizedBox(height: 20),
                  _buildAuthorityCard(context),
                ],
              )
            : Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(child: _buildPassengerCard(context)),
                  const SizedBox(width: 20),
                  Expanded(child: _buildConductorCard(context)),
                  const SizedBox(width: 20),
                  Expanded(child: _buildAuthorityCard(context)),
                ],
              );
      },
    );
  }

  // Card 1: Passenger App
  Widget _buildPassengerCard(BuildContext context) {
    return _buildModuleCard(
      bannerGradient: const LinearGradient(
        colors: [Color(0xFF2563EB), Color(0xFF1D4ED8)],
      ),
      icon: Icons.person_outline_rounded,
      badgeText: '18+ Screens',
      title: 'Passenger App',
      subtitle: 'Mobile Experience',
      description:
          'Real-time tracking, AI route recommendations, live occupancy monitoring, and smart notifications.',
      bulletList: [
        'Live Bus Tracking',
        'AI Recommendations',
        'Occupancy Monitor',
        'Smart Alerts',
      ],
      buttonColor: const Color(0xFF2563EB),
      onTap: () => Navigator.pushNamed(context, '/passenger/onboarding'),
    );
  }

  // Card 2: Conductor App
  Widget _buildConductorCard(BuildContext context) {
    return _buildModuleCard(
      bannerGradient: const LinearGradient(
        colors: [Color(0xFF059669), Color(0xFF10B981)],
      ),
      icon: Icons.directions_bus_rounded,
      badgeText: '5 Screens',
      title: 'Conductor App',
      subtitle: 'Operations Mobile',
      description:
          'Manage tickets, track passenger counts, monitor occupancy, and record trip data in real time.',
      bulletList: [
        'Ticket Issuing',
        'Passenger Count',
        'Trip Tracking',
        'Revenue Summary',
      ],
      buttonColor: const Color(0xFF10B981),
      onTap: () => Navigator.pushNamed(context, '/conductor/login'),
    );
  }

  // Card 3: Authority Dashboard
  Widget _buildAuthorityCard(BuildContext context) {
    return _buildModuleCard(
      bannerGradient: const LinearGradient(
        colors: [Color(0xFF7C3AED), Color(0xFF8B5CF6)],
      ),
      icon: Icons.bar_chart_rounded,
      badgeText: 'Full Dashboard',
      title: 'Authority Dashboard',
      subtitle: 'Web Analytics Platform',
      description:
          'Fleet monitoring, AI predictions, analytics charts, route optimization, and full operational control.',
      bulletList: [
        'Live Fleet Map',
        'AI Predictions',
        'Analytics Suite',
        'Report Center',
      ],
      buttonColor: const Color(0xFF8B5CF6),
      onTap: () => Navigator.pushNamed(context, '/admin/dashboard'),
    );
  }

  // Generic Module Card Builder
  Widget _buildModuleCard({
    required LinearGradient bannerGradient,
    required IconData icon,
    required String badgeText,
    required String title,
    required String subtitle,
    required String description,
    required List<String> bulletList,
    required Color buttonColor,
    required VoidCallback onTap,
  }) {
    return Container(
      decoration: BoxDecoration(
        color: const Color(0xFF1E293B).withValues(alpha: 0.5),
        borderRadius: BorderRadius.circular(24),
        border: Border.all(color: Colors.white.withValues(alpha: 0.08)),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.2),
            blurRadius: 20,
            offset: const Offset(0, 8),
          ),
        ],
      ),
      clipBehavior: Clip.antiAlias,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Card Header Banner
          Container(
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(gradient: bannerGradient),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      width: 40,
                      height: 40,
                      decoration: BoxDecoration(
                        color: Colors.white.withValues(alpha: 0.2),
                        shape: BoxShape.circle,
                      ),
                      child: Icon(icon, color: Colors.white, size: 22),
                    ),
                    Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 10, vertical: 4),
                      decoration: BoxDecoration(
                        color: Colors.white.withValues(alpha: 0.2),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Text(
                        badgeText,
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 11.5,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 16),
                Text(
                  title,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 2),
                Text(
                  subtitle,
                  style: TextStyle(
                    color: Colors.white.withValues(alpha: 0.8),
                    fontSize: 12.5,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
          ),

          Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  description,
                  style: const TextStyle(
                    color: Color(0xFF94A3B8),
                    fontSize: 13.5,
                    height: 1.4,
                  ),
                ),
                const SizedBox(height: 16),
                ...bulletList.map(
                  (item) => Padding(
                    padding: const EdgeInsets.only(bottom: 6.0),
                    child: Row(
                      children: [
                        Container(
                          width: 5,
                          height: 5,
                          decoration: BoxDecoration(
                            color: buttonColor,
                            shape: BoxShape.circle,
                          ),
                        ),
                        const SizedBox(width: 8),
                        Text(
                          item,
                          style: const TextStyle(
                            color: Color(0xFFCBD5E1),
                            fontSize: 13,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 24),

                // Launch App Button
                SizedBox(
                  width: double.infinity,
                  height: 48,
                  child: ElevatedButton(
                    onPressed: onTap,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: buttonColor,
                      foregroundColor: Colors.white,
                      elevation: 4,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(14),
                      ),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: const [
                        Text(
                          'Launch App',
                          style: TextStyle(
                            fontSize: 14.5,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                        SizedBox(width: 8),
                        Icon(Icons.arrow_forward_rounded,
                            size: 16, color: Colors.white),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

// Stat Item Widget
class _StatItem extends StatelessWidget {
  final IconData icon;
  final String value;
  final String label;

  const _StatItem({
    required this.icon,
    required this.value,
    required this.label,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(icon, color: const Color(0xFF38BDF8), size: 18),
        const SizedBox(width: 8),
        Text(
          value,
          style: const TextStyle(
            color: Colors.white,
            fontSize: 15,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(width: 5),
        Text(
          label,
          style: const TextStyle(
            color: Color(0xFF94A3B8),
            fontSize: 13,
          ),
        ),
      ],
    );
  }
}
