import 'package:flutter/material.dart';
import '../../../../shared_widgets/app_logo.dart';

class AuthorityDashboardScreen extends StatefulWidget {
  const AuthorityDashboardScreen({super.key});

  @override
  State<AuthorityDashboardScreen> createState() =>
      _AuthorityDashboardScreenState();
}

class _AuthorityDashboardScreenState extends State<AuthorityDashboardScreen> {
  int _selectedNavIndex = 0;

  final List<String> _navTitles = [
    'Dashboard',
    'Live Buses',
    'Analytics',
    'Reports',
    'Routes',
    'Drivers',
    'AI Predictions',
    'Settings',
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF0F172A), // Dark ambient outer theme
      body: Column(
        children: [
          // Top Navigation Bar
          _buildTopBar(context),

          // Main Web Container (Sidebar + Content)
          Expanded(
            child: Row(
              children: [
                // Left Dark Sidebar Navigation
                _buildSidebar(context),

                // Main Content View based on active navigation tab
                Expanded(
                  child: Container(
                    color: const Color(0xFFF8FAFC), // Light dashboard content background
                    child: _buildMainContentBody(),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // Top Navigation Bar (Dark Header)
  Widget _buildTopBar(BuildContext context) {
    return Container(
      height: 60,
      padding: const EdgeInsets.symmetric(horizontal: 20),
      decoration: const BoxDecoration(
        color: Color(0xFF0F172A),
        border: Border(
          bottom: BorderSide(color: Color(0xFF1E293B), width: 1),
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          // Back to Hub Button
          InkWell(
            onTap: () => Navigator.pushReplacementNamed(context, '/'),
            borderRadius: BorderRadius.circular(20),
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 7),
              decoration: BoxDecoration(
                color: Colors.white.withOpacity(0.08),
                borderRadius: BorderRadius.circular(20),
                border: Border.all(color: Colors.white.withOpacity(0.12)),
              ),
              child: Row(
                children: const [
                  Icon(Icons.arrow_back_rounded, color: Colors.white, size: 15),
                  SizedBox(width: 6),
                  Text(
                    'Back to Hub',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 13,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ),
            ),
          ),

          // System Operational Tag & Profile Actions
          Row(
            children: [
              // Web Browser Access Badge
              Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                decoration: BoxDecoration(
                  color: const Color(0xFF8B5CF6).withOpacity(0.15),
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(
                      color: const Color(0xFF8B5CF6).withOpacity(0.35)),
                ),
                child: Row(
                  children: const [
                    Icon(Icons.language_rounded, color: Color(0xFFA78BFA), size: 14),
                    SizedBox(width: 6),
                    Text(
                      'Web Browser Portal',
                      style: TextStyle(
                        color: Color(0xFFA78BFA),
                        fontSize: 12.5,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(width: 12),

              // All Systems Operational Badge
              Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                decoration: BoxDecoration(
                  color: const Color(0xFF10B981).withOpacity(0.12),
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(
                      color: const Color(0xFF10B981).withOpacity(0.3)),
                ),
                child: Row(
                  children: const [
                    Icon(Icons.circle, color: Color(0xFF10B981), size: 8),
                    SizedBox(width: 8),
                    Text(
                      'All systems operational',
                      style: TextStyle(
                        color: Color(0xFF10B981),
                        fontSize: 12.5,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(width: 16),

              // Bell Notification Icon
              IconButton(
                icon: const Icon(Icons.notifications_none_rounded,
                    color: Color(0xFF94A3B8), size: 22),
                onPressed: () {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text('5 active alert notifications.'),
                      backgroundColor: Color(0xFF3B82F6),
                    ),
                  );
                },
              ),

              const SizedBox(width: 8),

              // Admin Avatar
              Container(
                width: 34,
                height: 34,
                decoration: const BoxDecoration(
                  color: Color(0xFF2563EB),
                  shape: BoxShape.circle,
                ),
                child: const Center(
                  child: Icon(Icons.person_outline_rounded,
                      color: Colors.white, size: 20),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  // Left Dark Navigation Sidebar
  Widget _buildSidebar(BuildContext context) {
    return Container(
      width: 240,
      color: const Color(0xFF0B132B), // Deep navy sidebar
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 20),

          // Header Logo & Branding
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0),
            child: Row(
              children: [
                const AppLogo(
                  size: 38,
                  borderRadius: 10,
                ),
                const SizedBox(width: 12),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: const [
                    Text(
                      'SyncRide',
                      style: TextStyle(
                        fontSize: 17,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                        letterSpacing: -0.3,
                      ),
                    ),
                    Text(
                      'Authority Dashboard',
                      style: TextStyle(
                        fontSize: 11,
                        color: Color(0xFF94A3B8),
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),

          const SizedBox(height: 28),

          // Navigation Links List
          Expanded(
            child: ListView(
              padding: const EdgeInsets.symmetric(horizontal: 12.0),
              children: [
                _buildNavItem(0, Icons.grid_view_rounded, 'Dashboard'),
                _buildNavItem(1, Icons.directions_bus_outlined, 'Live Buses',
                    badgeCount: 12),
                _buildNavItem(2, Icons.show_chart_rounded, 'Analytics'),
                _buildNavItem(3, Icons.insert_drive_file_outlined, 'Reports',
                    badgeCount: 5),
                _buildNavItem(4, Icons.alt_route_rounded, 'Routes'),
                _buildNavItem(5, Icons.badge_outlined, 'Drivers'),
                _buildNavItem(6, Icons.psychology_outlined, 'AI Predictions'),
                _buildNavItem(7, Icons.settings_outlined, 'Settings'),
              ],
            ),
          ),

          // Bottom Admin Profile User Card
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: Colors.white.withValues(alpha: 0.06),
                borderRadius: BorderRadius.circular(16),
                border: Border.all(color: Colors.white.withValues(alpha: 0.08)),
              ),
              child: Row(
                children: [
                  Container(
                    width: 36,
                    height: 36,
                    decoration: const BoxDecoration(
                      color: Color(0xFF2563EB),
                      shape: BoxShape.circle,
                    ),
                    child: const Center(
                      child: Icon(Icons.person_outline_rounded,
                          color: Colors.white, size: 20),
                    ),
                  ),
                  const SizedBox(width: 10),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: const [
                        Text(
                          'Admin Officer',
                          style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 13,
                          ),
                        ),
                        Text(
                          'Transit Authority',
                          style: TextStyle(
                            color: Color(0xFF94A3B8),
                            fontSize: 11,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildNavItem(int index, IconData icon, String title, {int? badgeCount}) {
    final isSelected = _selectedNavIndex == index;
    return Container(
      margin: const EdgeInsets.only(bottom: 4),
      decoration: BoxDecoration(
        color: isSelected ? const Color(0xFF2563EB) : Colors.transparent,
        borderRadius: BorderRadius.circular(12),
      ),
      child: ListTile(
        onTap: () {
          setState(() {
            _selectedNavIndex = index;
          });
        },
        leading: Icon(
          icon,
          color: isSelected ? Colors.white : const Color(0xFF94A3B8),
          size: 20,
        ),
        title: Text(
          title,
          style: TextStyle(
            color: isSelected ? Colors.white : const Color(0xFF94A3B8),
            fontWeight: isSelected ? FontWeight.w600 : FontWeight.normal,
            fontSize: 13.5,
          ),
        ),
        trailing: badgeCount != null
            ? Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                decoration: BoxDecoration(
                  color: isSelected
                      ? Colors.white.withValues(alpha: 0.2)
                      : const Color(0xFF1E293B),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Text(
                  '$badgeCount',
                  style: TextStyle(
                    color: isSelected ? Colors.white : const Color(0xFF94A3B8),
                    fontSize: 11,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              )
            : null,
      ),
    );
  }

  Widget _buildMainContentBody() {
    return SingleChildScrollView(
      physics: const BouncingScrollPhysics(),
      padding: const EdgeInsets.all(28.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Header title & action buttons
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: const [
                  Text(
                    'Operations Dashboard',
                    style: TextStyle(
                      fontSize: 26,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF0F172A),
                      letterSpacing: -0.5,
                    ),
                  ),
                  SizedBox(height: 4),
                  Text(
                    'Wed, July 9, 2026 · Live data',
                    style: TextStyle(
                      fontSize: 13.5,
                      color: Color(0xFF64748B),
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ),
              Row(
                children: [
                  OutlinedButton.icon(
                    onPressed: () {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text('Dashboard report exported to CSV/PDF.'),
                          backgroundColor: Color(0xFF10B981),
                        ),
                      );
                    },
                    style: OutlinedButton.styleFrom(
                      backgroundColor: Colors.white,
                      side: const BorderSide(color: Color(0xFFE2E8F0)),
                      padding: const EdgeInsets.symmetric(
                          horizontal: 16, vertical: 14),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                    icon: const Icon(Icons.file_download_outlined,
                        color: Color(0xFF475569), size: 18),
                    label: const Text(
                      'Export',
                      style: TextStyle(
                        color: Color(0xFF334155),
                        fontWeight: FontWeight.w600,
                        fontSize: 13.5,
                      ),
                    ),
                  ),
                  const SizedBox(width: 12),
                  ElevatedButton.icon(
                    onPressed: () {
                      setState(() {});
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text('Refreshed live transit data!'),
                          backgroundColor: Color(0xFF2563EB),
                        ),
                      );
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF2563EB),
                      foregroundColor: Colors.white,
                      padding: const EdgeInsets.symmetric(
                          horizontal: 18, vertical: 14),
                      elevation: 2,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                    icon: const Icon(Icons.refresh_rounded, size: 18),
                    label: const Text(
                      'Refresh',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 13.5,
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),

          const SizedBox(height: 28),

          // Top 6 KPI Metric Cards (2 rows of 3)
          _buildKPICardsGrid(),

          const SizedBox(height: 24),

          // Middle Charts Section: Daily Passengers Line Chart + Fleet Status Donut
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Left Column: Daily Passengers Line Chart Card
              Expanded(
                flex: 7,
                child: _buildDailyPassengersChartCard(),
              ),

              const SizedBox(width: 24),

              // Right Column: Fleet Status Donut Chart Card
              Expanded(
                flex: 4,
                child: _buildFleetStatusDonutCard(),
              ),
            ],
          ),

          const SizedBox(height: 24),

          // Bottom Section: Live Fleet Map + Active Alerts
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Left Column: Live Fleet Map Card
              Expanded(
                flex: 7,
                child: _buildLiveFleetMapCard(),
              ),

              const SizedBox(width: 24),

              // Right Column: Active Alerts Card
              Expanded(
                flex: 4,
                child: _buildActiveAlertsCard(),
              ),
            ],
          ),
        ],
      ),
    );
  }

  // Top 6 KPI Cards Grid
  Widget _buildKPICardsGrid() {
    return Column(
      children: [
        // Row 1 (3 Cards)
        Row(
          children: [
            Expanded(
              child: _buildKPICard(
                icon: Icons.directions_bus_outlined,
                iconBgColor: const Color(0xFFEFF6FF),
                iconColor: const Color(0xFF3B82F6),
                badgeText: '+2',
                badgeBgColor: const Color(0xFFDCFCE7),
                badgeTextColor: const Color(0xFF16A34A),
                value: '124',
                label: 'Total Buses',
              ),
            ),
            const SizedBox(width: 20),
            Expanded(
              child: _buildKPICard(
                icon: Icons.show_chart_rounded,
                iconBgColor: const Color(0xFFECFDF5),
                iconColor: const Color(0xFF10B981),
                badgeText: '79%',
                badgeBgColor: const Color(0xFFDCFCE7),
                badgeTextColor: const Color(0xFF16A34A),
                value: '98',
                label: 'Active Buses',
              ),
            ),
            const SizedBox(width: 20),
            Expanded(
              child: _buildKPICard(
                icon: Icons.people_outline_rounded,
                iconBgColor: const Color(0xFFECFDF5),
                iconColor: const Color(0xFF06B6D4),
                badgeText: '+8.4%',
                badgeBgColor: const Color(0xFFDCFCE7),
                badgeTextColor: const Color(0xFF16A34A),
                value: '47,823',
                label: 'Passengers Today',
              ),
            ),
          ],
        ),

        const SizedBox(height: 20),

        // Row 2 (3 Cards)
        Row(
          children: [
            Expanded(
              child: _buildKPICard(
                icon: Icons.warning_amber_rounded,
                iconBgColor: const Color(0xFFFFFBEB),
                iconColor: const Color(0xFFF59E0B),
                badgeText: '-3',
                badgeBgColor: const Color(0xFFFEE2E2),
                badgeTextColor: const Color(0xFFDC2626),
                value: '12',
                label: 'Delayed Buses',
              ),
            ),
            const SizedBox(width: 20),
            Expanded(
              child: _buildKPICard(
                icon: Icons.bar_chart_rounded,
                iconBgColor: const Color(0xFFF3E8FF),
                iconColor: const Color(0xFF8B5CF6),
                badgeText: '+4%',
                badgeBgColor: const Color(0xFFDCFCE7),
                badgeTextColor: const Color(0xFF16A34A),
                value: '67%',
                label: 'Avg Occupancy',
              ),
            ),
            const SizedBox(width: 20),
            Expanded(
              child: _buildKPICard(
                icon: Icons.payments_outlined,
                iconBgColor: const Color(0xFFECFDF5),
                iconColor: const Color(0xFF10B981),
                badgeText: '+12%',
                badgeBgColor: const Color(0xFFDCFCE7),
                badgeTextColor: const Color(0xFF16A34A),
                value: 'LKR 240K',
                label: 'Daily Revenue',
              ),
            ),
          ],
        ),
      ],
    );
  }

  // Individual KPI Card Widget
  Widget _buildKPICard({
    required IconData icon,
    required Color iconBgColor,
    required Color iconColor,
    required String badgeText,
    required Color badgeBgColor,
    required Color badgeTextColor,
    required String value,
    required String label,
  }) {
    return Container(
      padding: const EdgeInsets.all(20.0),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: const Color(0xFFF1F5F9)),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.03),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
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
                  color: iconBgColor,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Icon(icon, color: iconColor, size: 22),
              ),
              Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                decoration: BoxDecoration(
                  color: badgeBgColor,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Text(
                  badgeText,
                  style: TextStyle(
                    fontSize: 11.5,
                    fontWeight: FontWeight.bold,
                    color: badgeTextColor,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 18),
          Text(
            value,
            style: const TextStyle(
              fontSize: 28,
              fontWeight: FontWeight.bold,
              color: Color(0xFF0F172A),
              letterSpacing: -0.6,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            label,
            style: const TextStyle(
              fontSize: 13,
              fontWeight: FontWeight.w500,
              color: Color(0xFF94A3B8),
            ),
          ),
        ],
      ),
    );
  }

  // Daily Passengers Line Chart Card
  Widget _buildDailyPassengersChartCard() {
    return Container(
      padding: const EdgeInsets.all(24.0),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: const Color(0xFFF1F5F9)),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.03),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: const [
                  Text(
                    'Daily Passengers',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF0F172A),
                    ),
                  ),
                  SizedBox(height: 2),
                  Text(
                    'This week',
                    style: TextStyle(
                      fontSize: 12.5,
                      color: Color(0xFF94A3B8),
                    ),
                  ),
                ],
              ),
              const Text(
                '+8.4% vs last week',
                style: TextStyle(
                  fontSize: 13,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF10B981),
                ),
              ),
            ],
          ),

          const SizedBox(height: 24),

          // Custom Line Chart Painter
          SizedBox(
            height: 180,
            width: double.infinity,
            child: CustomPaint(
              painter: _DailyPassengersChartPainter(),
            ),
          ),

          const SizedBox(height: 12),

          // X-Axis Days Labels
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: const [
              Text('Mon', style: TextStyle(fontSize: 12, color: Color(0xFF94A3B8))),
              Text('Tue', style: TextStyle(fontSize: 12, color: Color(0xFF94A3B8))),
              Text('Wed', style: TextStyle(fontSize: 12, color: Color(0xFF94A3B8))),
              Text('Thu', style: TextStyle(fontSize: 12, color: Color(0xFF94A3B8))),
              Text('Fri', style: TextStyle(fontSize: 12, color: Color(0xFF94A3B8))),
              Text('Sat', style: TextStyle(fontSize: 12, color: Color(0xFF94A3B8))),
              Text('Sun', style: TextStyle(fontSize: 12, color: Color(0xFF94A3B8))),
            ],
          ),
        ],
      ),
    );
  }

  // Fleet Status Donut Chart Card
  Widget _buildFleetStatusDonutCard() {
    return Container(
      padding: const EdgeInsets.all(24.0),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: const Color(0xFFF1F5F9)),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.03),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Fleet Status',
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: Color(0xFF0F172A),
            ),
          ),
          const SizedBox(height: 2),
          const Text(
            '124 total buses',
            style: TextStyle(
              fontSize: 12.5,
              color: Color(0xFF94A3B8),
            ),
          ),

          const SizedBox(height: 24),

          // Donut Chart Graphic
          Center(
            child: SizedBox(
              width: 140,
              height: 140,
              child: CustomPaint(
                painter: _FleetStatusDonutPainter(),
              ),
            ),
          ),

          const SizedBox(height: 24),

          // Legend Metrics List
          _buildDonutLegendRow(
              color: const Color(0xFF10B981), label: 'On Time', percent: '72%'),
          const SizedBox(height: 8),
          _buildDonutLegendRow(
              color: const Color(0xFFF59E0B), label: 'Delayed', percent: '12%'),
          const SizedBox(height: 8),
          _buildDonutLegendRow(
              color: const Color(0xFFEF4444), label: 'Breakdown', percent: '5%'),
          const SizedBox(height: 8),
          _buildDonutLegendRow(
              color: const Color(0xFF94A3B8), label: 'Idle', percent: '11%'),
        ],
      ),
    );
  }

  Widget _buildDonutLegendRow(
      {required Color color, required String label, required String percent}) {
    return Row(
      children: [
        Container(
          width: 8,
          height: 8,
          decoration: BoxDecoration(color: color, shape: BoxShape.circle),
        ),
        const SizedBox(width: 10),
        Expanded(
          child: Text(
            label,
            style: const TextStyle(
              fontSize: 13,
              fontWeight: FontWeight.w500,
              color: Color(0xFF64748B),
            ),
          ),
        ),
        Text(
          percent,
          style: const TextStyle(
            fontSize: 13,
            fontWeight: FontWeight.bold,
            color: Color(0xFF0F172A),
          ),
        ),
      ],
    );
  }

  // Live Fleet Map Card
  Widget _buildLiveFleetMapCard() {
    return Container(
      padding: const EdgeInsets.all(24.0),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: const Color(0xFFF1F5F9)),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.03),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                'Live Fleet Map',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF0F172A),
                ),
              ),
              Row(
                children: const [
                  Icon(Icons.circle, color: Color(0xFF10B981), size: 8),
                  SizedBox(width: 6),
                  Text(
                    'Live',
                    style: TextStyle(
                      fontSize: 12.5,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF10B981),
                    ),
                  ),
                ],
              ),
            ],
          ),

          const SizedBox(height: 16),

          // Interactive Map Simulation Box
          Container(
            height: 220,
            width: double.infinity,
            decoration: BoxDecoration(
              color: const Color(0xFFE2E8F0).withOpacity(0.4),
              borderRadius: BorderRadius.circular(16),
            ),
            child: Stack(
              children: [
                // Street Grid Layout
                CustomPaint(
                  size: const Size(double.infinity, 220),
                  painter: _MapGridPainter(),
                ),

                // Bus Pins on Map
                _buildMapBusPin(top: 40, left: 120, busId: 'B 412', statusColor: const Color(0xFFF59E0B)),
                _buildMapBusPin(top: 85, left: 240, busId: 'B 056', statusColor: const Color(0xFFEF4444)),
                _buildMapBusPin(top: 45, left: 360, busId: 'B 342', statusColor: const Color(0xFFF59E0B)),
                _buildMapBusPin(top: 110, left: 160, busId: 'B 177', statusColor: const Color(0xFF10B981)),
                _buildMapBusPin(top: 135, left: 400, busId: 'B 215', statusColor: const Color(0xFF10B981)),
                _buildMapBusPin(top: 140, left: 320, busId: 'B 203', statusColor: const Color(0xFF10B981)),
                _buildMapBusPin(top: 175, left: 120, busId: 'B 101', statusColor: const Color(0xFF10B981)),
                _buildMapBusPin(top: 185, left: 260, busId: 'B 087', statusColor: const Color(0xFF10B981)),

                // Legend Pill Box at Bottom Right
                Positioned(
                  bottom: 12,
                  right: 12,
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 12, vertical: 6),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(20),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.08),
                          blurRadius: 8,
                        ),
                      ],
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: const [
                        Icon(Icons.circle, color: Color(0xFF10B981), size: 7),
                        SizedBox(width: 4),
                        Text('On Time', style: TextStyle(fontSize: 10, fontWeight: FontWeight.w600)),
                        SizedBox(width: 8),
                        Icon(Icons.circle, color: Color(0xFFF59E0B), size: 7),
                        SizedBox(width: 4),
                        Text('Delayed', style: TextStyle(fontSize: 10, fontWeight: FontWeight.w600)),
                        SizedBox(width: 8),
                        Icon(Icons.circle, color: Color(0xFFEF4444), size: 7),
                        SizedBox(width: 4),
                        Text('Breakdown', style: TextStyle(fontSize: 10, fontWeight: FontWeight.w600)),
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

  Widget _buildMapBusPin(
      {required double top,
      required double left,
      required String busId,
      required Color statusColor}) {
    return Positioned(
      top: top,
      left: left,
      child: Column(
        children: [
          Container(
            padding: const EdgeInsets.all(4),
            decoration: BoxDecoration(
              color: statusColor,
              shape: BoxShape.circle,
              boxShadow: [
                BoxShadow(
                  color: statusColor.withOpacity(0.4),
                  blurRadius: 6,
                  spreadRadius: 1,
                ),
              ],
            ),
            child: const Icon(
              Icons.directions_bus_rounded,
              color: Colors.white,
              size: 11,
            ),
          ),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 1),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(4),
            ),
            child: Text(
              busId,
              style: const TextStyle(
                fontSize: 8.5,
                fontWeight: FontWeight.bold,
                color: Color(0xFF0F172A),
              ),
            ),
          ),
        ],
      ),
    );
  }

  // Active Alerts Card
  Widget _buildActiveAlertsCard() {
    return Container(
      padding: const EdgeInsets.all(24.0),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: const Color(0xFFF1F5F9)),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.03),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Active Alerts',
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: Color(0xFF0F172A),
            ),
          ),

          const SizedBox(height: 16),

          // Alert Items List
          _buildAlertItem(
            icon: Icons.warning_amber_rounded,
            color: const Color(0xFFF59E0B),
            text: 'Bus B342 delayed 7 min — MG Road congestion',
          ),
          const SizedBox(height: 10),
          _buildAlertItem(
            icon: Icons.close_rounded,
            color: const Color(0xFFEF4444),
            text: 'Bus B056 breakdown reported — Ring Road',
          ),
          const SizedBox(height: 10),
          _buildAlertItem(
            icon: Icons.grid_view_rounded,
            color: const Color(0xFF3B82F6),
            text: 'Peak demand predicted 5PM — deploy reserves',
          ),
          const SizedBox(height: 10),
          _buildAlertItem(
            icon: Icons.groups_outlined,
            color: const Color(0xFF06B6D4),
            text: 'Route 203 showing 91% avg occupancy',
          ),
          const SizedBox(height: 10),
          _buildAlertItem(
            icon: Icons.thunderstorm_outlined,
            color: const Color(0xFF8B5CF6),
            text: 'Weather: Rain expected — ETA impacts likely',
          ),
        ],
      ),
    );
  }

  Widget _buildAlertItem(
      {required IconData icon, required Color color, required String text}) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: color.withOpacity(0.06),
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: color.withOpacity(0.15)),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(icon, color: color, size: 18),
          const SizedBox(width: 10),
          Expanded(
            child: Text(
              text,
              style: const TextStyle(
                fontSize: 12.5,
                fontWeight: FontWeight.w500,
                color: Color(0xFF334155),
              ),
            ),
          ),
        ],
      ),
    );
  }

  // --------------------------------------------------------------------------
  // TAB 2: LIVE BUSES VIEW
  // --------------------------------------------------------------------------
  Widget _buildLiveBusesView() {
    return Padding(
      padding: const EdgeInsets.all(28.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Live Bus Fleet Tracking',
            style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: Color(0xFF0F172A)),
          ),
          const SizedBox(height: 4),
          const Text('12 Active Buses with live telemetry', style: TextStyle(color: Color(0xFF64748B))),
          const SizedBox(height: 20),
          Expanded(
            child: Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(20),
                border: Border.all(color: const Color(0xFFE2E8F0)),
              ),
              child: ListView(
                padding: const EdgeInsets.all(16),
                children: [
                  _buildBusRow('Bus 177', 'City Center → Airport', 'Rahul Kumar', 'On Time', '46% (23/50)', const Color(0xFF10B981)),
                  const Divider(),
                  _buildBusRow('Bus 204', 'Express Route 4', 'Amit Sharma', 'On Time', '84% (42/50)', const Color(0xFF10B981)),
                  const Divider(),
                  _buildBusRow('Bus 342', 'MG Road Link', 'Priya Patel', 'Delayed (7m)', '92% (46/50)', const Color(0xFFF59E0B)),
                  const Divider(),
                  _buildBusRow('Bus 056', 'Ring Road Outer', 'Vikram Singh', 'Breakdown', '0% (0/50)', const Color(0xFFEF4444)),
                  const Divider(),
                  _buildBusRow('Bus 102', 'Metro Link North', 'Suresh Roy', 'On Time', '50% (25/50)', const Color(0xFF10B981)),
                  const Divider(),
                  _buildBusRow('Bus 305', 'University Express', 'Kavita Das', 'On Time', '68% (34/50)', const Color(0xFF10B981)),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildBusRow(String busId, String route, String driver, String status, String occupancy, Color statusColor) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10.0),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(color: statusColor.withOpacity(0.12), borderRadius: BorderRadius.circular(12)),
            child: Icon(Icons.directions_bus, color: statusColor, size: 22),
          ),
          const SizedBox(width: 14),
          Expanded(
            flex: 2,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(busId, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 15)),
                Text(route, style: const TextStyle(color: Color(0xFF64748B), fontSize: 12)),
              ],
            ),
          ),
          Expanded(
            flex: 2,
            child: Text('Driver: $driver', style: const TextStyle(fontSize: 13, color: Color(0xFF334155))),
          ),
          Expanded(
            flex: 2,
            child: Text('Occupancy: $occupancy', style: const TextStyle(fontSize: 13, fontWeight: FontWeight.w600)),
          ),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
            decoration: BoxDecoration(color: statusColor.withOpacity(0.15), borderRadius: BorderRadius.circular(10)),
            child: Text(status, style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold, color: statusColor)),
          ),
        ],
      ),
    );
  }

  // --------------------------------------------------------------------------
  // TAB 3: ANALYTICS VIEW
  // --------------------------------------------------------------------------
  Widget _buildAnalyticsView() {
    return Padding(
      padding: const EdgeInsets.all(28.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text('Transit Analytics & Insights', style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: Color(0xFF0F172A))),
          const SizedBox(height: 4),
          const Text('Ridership trends and peak congestion patterns', style: TextStyle(color: Color(0xFF64748B))),
          const SizedBox(height: 20),
          Expanded(
            child: Container(
              padding: const EdgeInsets.all(24),
              decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(20), border: Border.all(color: const Color(0xFFE2E8F0))),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: const [
                  Text('Hourly Passenger Volume vs Capacity', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                  Spacer(),
                  Center(child: Text('Analytics Chart Visualizer (47,823 Passengers Today · Peak 8AM & 5PM)', style: TextStyle(color: Color(0xFF64748B)))),
                  Spacer(),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  // --------------------------------------------------------------------------
  // TAB 4: REPORTS VIEW
  // --------------------------------------------------------------------------
  Widget _buildReportsView() {
    return Padding(
      padding: const EdgeInsets.all(28.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text('Official Waybills & Reports', style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: Color(0xFF0F172A))),
          const SizedBox(height: 4),
          const Text('Daily conductor summaries & delay logs', style: TextStyle(color: Color(0xFF64748B))),
          const SizedBox(height: 20),
          Expanded(
            child: Container(
              padding: const EdgeInsets.all(24),
              decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(20), border: Border.all(color: const Color(0xFFE2E8F0))),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: const [
                  Text('5 Generated Shift Waybill Reports Available for Download', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                  Spacer(),
                  Center(child: Text('Reports Exporter & Waybill Archiver', style: TextStyle(color: Color(0xFF64748B)))),
                  Spacer(),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  // --------------------------------------------------------------------------
  // TAB 5: ROUTES VIEW
  // --------------------------------------------------------------------------
  Widget _buildRoutesView() {
    return Padding(
      padding: const EdgeInsets.all(28.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text('Route Management', style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: Color(0xFF0F172A))),
          const SizedBox(height: 4),
          const Text('City routes and stop sequence configurations', style: TextStyle(color: Color(0xFF64748B))),
          const SizedBox(height: 20),
          Expanded(
            child: Container(
              padding: const EdgeInsets.all(24),
              decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(20), border: Border.all(color: const Color(0xFFE2E8F0))),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: const [
                  Text('Active City Routes (Route 177, 204, 342, 102, 305)', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                  Spacer(),
                  Center(child: Text('Route Editor & Stop Frequency Stepper Visualizer', style: TextStyle(color: Color(0xFF64748B)))),
                  Spacer(),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  // --------------------------------------------------------------------------
  // TAB 6: DRIVERS VIEW
  // --------------------------------------------------------------------------
  Widget _buildDriversView() {
    return Padding(
      padding: const EdgeInsets.all(28.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text('Driver & Conductor Roster', style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: Color(0xFF0F172A))),
          const SizedBox(height: 4),
          const Text('Duty allocation and shift statuses', style: TextStyle(color: Color(0xFF64748B))),
          const SizedBox(height: 20),
          Expanded(
            child: Container(
              padding: const EdgeInsets.all(24),
              decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(20), border: Border.all(color: const Color(0xFFE2E8F0))),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: const [
                  Text('Conductor Rahul Kumar · Active Shift (Bus 177)', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                  Spacer(),
                  Center(child: Text('Personnel & Shift Allocation Roster Table', style: TextStyle(color: Color(0xFF64748B)))),
                  Spacer(),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  // --------------------------------------------------------------------------
  // TAB 7: AI PREDICTIONS VIEW
  // --------------------------------------------------------------------------
  Widget _buildAIPredictionsView() {
    return Padding(
      padding: const EdgeInsets.all(28.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text('AI Predictive Dispatch', style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: Color(0xFF0F172A))),
          const SizedBox(height: 4),
          const Text('Machine learning overcrowding forecasts', style: TextStyle(color: Color(0xFF64748B))),
          const SizedBox(height: 20),
          Expanded(
            child: Container(
              padding: const EdgeInsets.all(24),
              decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(20), border: Border.all(color: const Color(0xFFE2E8F0))),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: const [
                  Text('Predicted High Demand Alert: Deploy 3 Reserve Buses on Route 177 at 5:00 PM', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Color(0xFF2563EB))),
                  Spacer(),
                  Center(child: Text('SyncRide ML Engine Forecasting Engine', style: TextStyle(color: Color(0xFF64748B)))),
                  Spacer(),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  // --------------------------------------------------------------------------
  // TAB 8: SETTINGS VIEW
  // --------------------------------------------------------------------------
  Widget _buildSettingsView() {
    return Padding(
      padding: const EdgeInsets.all(28.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text('Authority Settings', style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: Color(0xFF0F172A))),
          const SizedBox(height: 4),
          const Text('System parameters and notification controls', style: TextStyle(color: Color(0xFF64748B))),
          const SizedBox(height: 20),
          Expanded(
            child: Container(
              padding: const EdgeInsets.all(24),
              decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(20), border: Border.all(color: const Color(0xFFE2E8F0))),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: const [
                  Text('System API & Fleet GPS Sync Configuration', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                  Spacer(),
                  Center(child: Text('Settings Panel', style: TextStyle(color: Color(0xFF64748B)))),
                  Spacer(),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// Custom Painter for Daily Passengers Line Chart
class _DailyPassengersChartPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final path = Path();
    final points = [
      Offset(0, size.height * 0.4),
      Offset(size.width * 0.16, size.height * 0.5),
      Offset(size.width * 0.33, size.height * 0.2),
      Offset(size.width * 0.5, size.height * 0.3),
      Offset(size.width * 0.66, size.height * 0.1),
      Offset(size.width * 0.83, size.height * 0.6),
      Offset(size.width, size.height * 0.7),
    ];

    path.moveTo(points[0].dx, points[0].dy);

    for (int i = 0; i < points.length - 1; i++) {
      final p0 = points[i];
      final p1 = points[i + 1];
      final controlPoint1 = Offset(p0.dx + (p1.dx - p0.dx) / 2, p0.dy);
      final controlPoint2 = Offset(p0.dx + (p1.dx - p0.dx) / 2, p1.dy);
      path.cubicTo(controlPoint1.dx, controlPoint1.dy, controlPoint2.dx,
          controlPoint2.dy, p1.dx, p1.dy);
    }

    // Gradient Fill
    final fillPath = Path.from(path)
      ..lineTo(size.width, size.height)
      ..lineTo(0, size.height)
      ..close();

    final fillPaint = Paint()
      ..shader = LinearGradient(
        begin: Alignment.topCenter,
        end: Alignment.bottomCenter,
        colors: [
          const Color(0xFF2563EB).withOpacity(0.15),
          const Color(0xFF2563EB).withOpacity(0.0),
        ],
      ).createShader(Rect.fromLTWH(0, 0, size.width, size.height));

    canvas.drawPath(fillPath, fillPaint);

    // Blue Line Stroke
    final linePaint = Paint()
      ..color = const Color(0xFF2563EB)
      ..strokeWidth = 3
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round;

    canvas.drawPath(path, linePaint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

// Custom Painter for Fleet Status Donut Chart
class _FleetStatusDonutPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final center = Offset(size.width / 2, size.height / 2);
    final radius = size.width / 2;
    const strokeWidth = 22.0;

    final paint = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = strokeWidth
      ..strokeCap = StrokeCap.butt;

    // Segment 1: On Time (72%)
    paint.color = const Color(0xFF10B981);
    canvas.drawArc(
      Rect.fromCircle(center: center, radius: radius - strokeWidth / 2),
      -1.57,
      4.52,
      false,
      paint,
    );

    // Segment 2: Delayed (12%)
    paint.color = const Color(0xFFF59E0B);
    canvas.drawArc(
      Rect.fromCircle(center: center, radius: radius - strokeWidth / 2),
      2.95,
      0.75,
      false,
      paint,
    );

    // Segment 3: Breakdown (5%)
    paint.color = const Color(0xFFEF4444);
    canvas.drawArc(
      Rect.fromCircle(center: center, radius: radius - strokeWidth / 2),
      3.70,
      0.31,
      false,
      paint,
    );

    // Segment 4: Idle (11%)
    paint.color = const Color(0xFF94A3B8);
    canvas.drawArc(
      Rect.fromCircle(center: center, radius: radius - strokeWidth / 2),
      4.01,
      0.69,
      false,
      paint,
    );
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

// Custom Painter for Live Map Grid Simulation
class _MapGridPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = const Color(0xFFCBD5E1).withOpacity(0.6)
      ..strokeWidth = 12
      ..style = PaintingStyle.stroke;

    // Horizontal Streets
    canvas.drawLine(Offset(0, size.height * 0.25), Offset(size.width, size.height * 0.25), paint);
    canvas.drawLine(Offset(0, size.height * 0.55), Offset(size.width, size.height * 0.55), paint);
    canvas.drawLine(Offset(0, size.height * 0.85), Offset(size.width, size.height * 0.85), paint);

    // Vertical Avenues
    canvas.drawLine(Offset(size.width * 0.25, 0), Offset(size.width * 0.25, size.height), paint);
    canvas.drawLine(Offset(size.width * 0.55, 0), Offset(size.width * 0.55, size.height), paint);
    canvas.drawLine(Offset(size.width * 0.85, 0), Offset(size.width * 0.85, size.height), paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
