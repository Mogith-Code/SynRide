import 'package:flutter/material.dart';
import '../../../../shared_widgets/app_logo.dart';

class AuthorityDashboardScreen extends StatefulWidget {
  const AuthorityDashboardScreen({super.key});

  @override
  State<AuthorityDashboardScreen> createState() =>
      _AuthorityDashboardScreenState();
}

class _AuthorityDashboardScreenState extends State<AuthorityDashboardScreen> {
  int _selectedNavIndex = 2; // Default to Analytics tab matching requested design image
  String _selectedFilter = 'All';
  String _searchQuery = '';
  String _selectedAnalyticsPeriod = 'Weekly';
  final TextEditingController _searchController = TextEditingController();

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

  final List<_BusModel> _buses = [
    _BusModel(
        id: 'B177',
        route: 'City Center → Airport',
        driver: 'Rahul Kumar',
        occupancyPercent: 45,
        status: 'On Time'),
    _BusModel(
        id: 'B203',
        route: 'University → Downtown',
        driver: 'Priya Singh',
        occupancyPercent: 78,
        status: 'On Time'),
    _BusModel(
        id: 'B101',
        route: 'Mall → Station',
        driver: 'Amit Sharma',
        occupancyPercent: 22,
        status: 'On Time'),
    _BusModel(
        id: 'B342',
        route: 'Station → University',
        driver: 'Neha Patel',
        occupancyPercent: 91,
        status: 'Delayed'),
    _BusModel(
        id: 'B215',
        route: 'Hospital → Beach',
        driver: 'Ravi Kumar',
        occupancyPercent: 35,
        status: 'On Time'),
    _BusModel(
        id: 'B087',
        route: 'Market → Airport',
        driver: 'Sanjay Rao',
        occupancyPercent: 65,
        status: 'On Time'),
    _BusModel(
        id: 'B412',
        route: 'Depot → Central',
        driver: 'Meera Singh',
        occupancyPercent: 88,
        status: 'Delayed'),
    _BusModel(
        id: 'B056',
        route: 'North → South',
        driver: 'Vijay Kumar',
        occupancyPercent: 12,
        status: 'Breakdown'),
  ];

  List<_BusModel> get _filteredBuses {
    return _buses.where((bus) {
      if (_selectedFilter == 'On Time' && bus.status != 'On Time') return false;
      if (_selectedFilter == 'Delayed' && bus.status != 'Delayed') return false;
      if (_selectedFilter == 'Breakdown' && bus.status != 'Breakdown') return false;

      if (_searchQuery.isNotEmpty) {
        final query = _searchQuery.toLowerCase();
        final matchesId = bus.id.toLowerCase().contains(query);
        final matchesRoute = bus.route.toLowerCase().contains(query);
        final matchesDriver = bus.driver.toLowerCase().contains(query);
        return matchesId || matchesRoute || matchesDriver;
      }
      return true;
    }).toList();
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

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
                color: Colors.white.withValues(alpha: 0.08),
                borderRadius: BorderRadius.circular(20),
                border: Border.all(color: Colors.white.withValues(alpha: 0.12)),
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
              // All Systems Operational Badge
              Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                decoration: BoxDecoration(
                  color: const Color(0xFF10B981).withValues(alpha: 0.12),
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(
                      color: const Color(0xFF10B981).withValues(alpha: 0.3)),
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

              // Admin Avatar Circle
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

          // Bottom Admin Profile User Card (Matches image: Admin / Pune Transport Auth)
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
                          'Admin',
                          style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 13.5,
                          ),
                        ),
                        Text(
                          'Pune Transport Auth',
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
                      : const Color(0xFFEF4444),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Text(
                  '$badgeCount',
                  style: const TextStyle(
                    color: Colors.white,
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
    switch (_selectedNavIndex) {
      case 1:
        return _buildLiveBusesView();
      case 2:
        return _buildAnalyticsView();
      case 3:
        return _buildReportsView();
      case 4:
        return _buildRoutesView();
      case 5:
        return _buildDriversView();
      case 6:
        return _buildAIPredictionsView();
      case 7:
        return _buildSettingsView();
      case 0:
      default:
        return _buildOperationsDashboardView();
    }
  }

  // --------------------------------------------------------------------------
  // TAB 1: OPERATIONS DASHBOARD VIEW
  // --------------------------------------------------------------------------
  Widget _buildOperationsDashboardView() {
    return SingleChildScrollView(
      physics: const BouncingScrollPhysics(),
      padding: const EdgeInsets.all(28.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
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
          _buildKPICardsGrid(),
          const SizedBox(height: 24),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                flex: 7,
                child: _buildDailyPassengersChartCard(),
              ),
              const SizedBox(width: 24),
              Expanded(
                flex: 4,
                child: _buildFleetStatusDonutCard(),
              ),
            ],
          ),
          const SizedBox(height: 24),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                flex: 7,
                child: _buildLiveFleetMapCard(),
              ),
              const SizedBox(width: 24),
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

  // --------------------------------------------------------------------------
  // TAB 2: LIVE BUSES VIEW
  // --------------------------------------------------------------------------
  Widget _buildLiveBusesView() {
    final filtered = _filteredBuses;
    final totalCount = _buses.length;
    final onTimeCount = _buses.where((b) => b.status == 'On Time').length;
    final delayedCount = _buses.where((b) => b.status == 'Delayed').length;
    final breakdownCount = _buses.where((b) => b.status == 'Breakdown').length;

    return SingleChildScrollView(
      physics: const BouncingScrollPhysics(),
      padding: const EdgeInsets.all(28.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Live Buses',
                    style: TextStyle(
                      fontSize: 26,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF0F172A),
                      letterSpacing: -0.5,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    '$totalCount buses tracked in real-time',
                    style: const TextStyle(
                      fontSize: 13.5,
                      color: Color(0xFF64748B),
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ),
              ElevatedButton.icon(
                onPressed: _showAddBusDialog,
                icon: const Icon(Icons.add, size: 18, color: Colors.white),
                label: const Text(
                  'Add Bus',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 13.5,
                    color: Colors.white,
                  ),
                ),
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF2563EB),
                  foregroundColor: Colors.white,
                  padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 14),
                  elevation: 0,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 24),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  _buildFilterPill('All ($totalCount)', 'All'),
                  const SizedBox(width: 10),
                  _buildFilterPill('On Time', 'On Time'),
                  const SizedBox(width: 10),
                  _buildFilterPill('Delayed ($delayedCount)', 'Delayed'),
                  const SizedBox(width: 10),
                  _buildFilterPill('Breakdown ($breakdownCount)', 'Breakdown'),
                ],
              ),
              Container(
                width: 250,
                height: 40,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(color: const Color(0xFFE2E8F0)),
                ),
                child: TextField(
                  controller: _searchController,
                  onChanged: (val) {
                    setState(() {
                      _searchQuery = val;
                    });
                  },
                  style: const TextStyle(fontSize: 13, color: Color(0xFF0F172A)),
                  decoration: const InputDecoration(
                    hintText: 'Search bus...',
                    hintStyle: TextStyle(fontSize: 13, color: Color(0xFF94A3B8)),
                    prefixIcon: Icon(Icons.search_rounded, color: Color(0xFF94A3B8), size: 18),
                    border: InputBorder.none,
                    contentPadding: EdgeInsets.symmetric(vertical: 9),
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 20),
          Container(
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(20),
              border: Border.all(color: const Color(0xFFF1F5F9)),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withValues(alpha: 0.02),
                  blurRadius: 12,
                  offset: const Offset(0, 4),
                ),
              ],
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(20),
              child: Column(
                children: [
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
                    color: const Color(0xFFFAFAFA),
                    child: Row(
                      children: const [
                        Expanded(
                          flex: 2,
                          child: Text(
                            'BUS ID',
                            style: TextStyle(
                              fontSize: 11.5,
                              fontWeight: FontWeight.bold,
                              color: Color(0xFF64748B),
                              letterSpacing: 0.5,
                            ),
                          ),
                        ),
                        Expanded(
                          flex: 3,
                          child: Text(
                            'ROUTE',
                            style: TextStyle(
                              fontSize: 11.5,
                              fontWeight: FontWeight.bold,
                              color: Color(0xFF64748B),
                              letterSpacing: 0.5,
                            ),
                          ),
                        ),
                        Expanded(
                          flex: 3,
                          child: Text(
                            'DRIVER',
                            style: TextStyle(
                              fontSize: 11.5,
                              fontWeight: FontWeight.bold,
                              color: Color(0xFF64748B),
                              letterSpacing: 0.5,
                            ),
                          ),
                        ),
                        Expanded(
                          flex: 3,
                          child: Text(
                            'OCCUPANCY',
                            style: TextStyle(
                              fontSize: 11.5,
                              fontWeight: FontWeight.bold,
                              color: Color(0xFF64748B),
                              letterSpacing: 0.5,
                            ),
                          ),
                        ),
                        Expanded(
                          flex: 2,
                          child: Text(
                            'STATUS',
                            style: TextStyle(
                              fontSize: 11.5,
                              fontWeight: FontWeight.bold,
                              color: Color(0xFF64748B),
                              letterSpacing: 0.5,
                            ),
                          ),
                        ),
                        SizedBox(
                          width: 110,
                          child: Text(
                            'ACTIONS',
                            style: TextStyle(
                              fontSize: 11.5,
                              fontWeight: FontWeight.bold,
                              color: Color(0xFF64748B),
                              letterSpacing: 0.5,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  const Divider(height: 1, color: Color(0xFFF1F5F9)),
                  if (filtered.isEmpty)
                    const Padding(
                      padding: EdgeInsets.all(40.0),
                      child: Center(
                        child: Text(
                          'No buses match your filter or search criteria',
                          style: TextStyle(color: Color(0xFF94A3B8), fontSize: 14),
                        ),
                      ),
                    )
                  else
                    ListView.separated(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: filtered.length,
                      separatorBuilder: (context, index) =>
                          const Divider(height: 1, color: Color(0xFFF1F5F9)),
                      itemBuilder: (context, index) {
                        final bus = filtered[index];
                        return _buildBusTableRow(bus);
                      },
                    ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildBusTableRow(_BusModel bus) {
    Color occColor;
    if (bus.occupancyPercent > 70) {
      occColor = const Color(0xFFEF4444);
    } else if (bus.occupancyPercent >= 40) {
      occColor = const Color(0xFFF59E0B);
    } else {
      occColor = const Color(0xFF10B981);
    }

    Color statusBgColor;
    Color statusTextColor;
    if (bus.status == 'Delayed') {
      statusBgColor = const Color(0xFFFEF3C7);
      statusTextColor = const Color(0xFFD97706);
    } else if (bus.status == 'Breakdown') {
      statusBgColor = const Color(0xFFFEE2E2);
      statusTextColor = const Color(0xFFDC2626);
    } else {
      statusBgColor = const Color(0xFFDCFCE7);
      statusTextColor = const Color(0xFF16A34A);
    }

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 14),
      color: Colors.white,
      child: Row(
        children: [
          Expanded(
            flex: 2,
            child: Row(
              children: [
                Container(
                  width: 32,
                  height: 32,
                  decoration: BoxDecoration(
                    color: const Color(0xFFEFF6FF),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: const Icon(
                    Icons.directions_bus_rounded,
                    color: Color(0xFF3B82F6),
                    size: 17,
                  ),
                ),
                const SizedBox(width: 10),
                Text(
                  bus.id,
                  style: const TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF0F172A),
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            flex: 3,
            child: Text(
              bus.route,
              style: const TextStyle(
                fontSize: 13.5,
                fontWeight: FontWeight.w500,
                color: Color(0xFF334155),
              ),
            ),
          ),
          Expanded(
            flex: 3,
            child: Text(
              bus.driver,
              style: const TextStyle(
                fontSize: 13.5,
                color: Color(0xFF64748B),
              ),
            ),
          ),
          Expanded(
            flex: 3,
            child: Row(
              children: [
                Container(
                  width: 60,
                  height: 6,
                  decoration: BoxDecoration(
                    color: const Color(0xFFF1F5F9),
                    borderRadius: BorderRadius.circular(3),
                  ),
                  child: FractionallySizedBox(
                    alignment: Alignment.centerLeft,
                    widthFactor: (bus.occupancyPercent / 100).clamp(0.0, 1.0),
                    child: Container(
                      decoration: BoxDecoration(
                        color: occColor,
                        borderRadius: BorderRadius.circular(3),
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 10),
                Text(
                  '${bus.occupancyPercent}%',
                  style: TextStyle(
                    fontSize: 12.5,
                    fontWeight: FontWeight.bold,
                    color: occColor,
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            flex: 2,
            child: Align(
              alignment: Alignment.centerLeft,
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                decoration: BoxDecoration(
                  color: statusBgColor,
                  borderRadius: BorderRadius.circular(14),
                ),
                child: Text(
                  bus.status,
                  style: TextStyle(
                    fontSize: 11.5,
                    fontWeight: FontWeight.bold,
                    color: statusTextColor,
                  ),
                ),
              ),
            ),
          ),
          SizedBox(
            width: 110,
            child: Row(
              children: [
                InkWell(
                  onTap: () => _showViewBusModal(bus),
                  borderRadius: BorderRadius.circular(15),
                  child: Container(
                    width: 28,
                    height: 28,
                    decoration: const BoxDecoration(
                      color: Color(0xFFEFF6FF),
                      shape: BoxShape.circle,
                    ),
                    child: const Icon(
                      Icons.remove_red_eye_outlined,
                      color: Color(0xFF3B82F6),
                      size: 15,
                    ),
                  ),
                ),
                const SizedBox(width: 6),
                InkWell(
                  onTap: () => _showEditBusDialog(bus),
                  borderRadius: BorderRadius.circular(15),
                  child: Container(
                    width: 28,
                    height: 28,
                    decoration: const BoxDecoration(
                      color: Color(0xFFECFDF5),
                      shape: BoxShape.circle,
                    ),
                    child: const Icon(
                      Icons.edit_outlined,
                      color: Color(0xFF10B981),
                      size: 15,
                    ),
                  ),
                ),
                const SizedBox(width: 6),
                InkWell(
                  onTap: () => _showDeleteBusDialog(bus),
                  borderRadius: BorderRadius.circular(15),
                  child: Container(
                    width: 28,
                    height: 28,
                    decoration: const BoxDecoration(
                      color: Color(0xFFFEE2E2),
                      shape: BoxShape.circle,
                    ),
                    child: const Icon(
                      Icons.close_rounded,
                      color: Color(0xFFEF4444),
                      size: 15,
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

  Widget _buildFilterPill(String label, String value) {
    final isSelected = _selectedFilter == value;
    return InkWell(
      onTap: () {
        setState(() {
          _selectedFilter = value;
        });
      },
      borderRadius: BorderRadius.circular(20),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        decoration: BoxDecoration(
          color: isSelected ? const Color(0xFF2563EB) : Colors.white,
          borderRadius: BorderRadius.circular(20),
          border: isSelected
              ? null
              : Border.all(color: const Color(0xFFE2E8F0)),
        ),
        child: Text(
          label,
          style: TextStyle(
            fontSize: 13,
            fontWeight: isSelected ? FontWeight.bold : FontWeight.w500,
            color: isSelected ? Colors.white : const Color(0xFF475569),
          ),
        ),
      ),
    );
  }

  void _showAddBusDialog() {
    final idController = TextEditingController(text: 'B${100 + _buses.length * 12}');
    final routeController = TextEditingController();
    final driverController = TextEditingController();
    final occController = TextEditingController(text: '45');
    String selectedStatus = 'On Time';

    showDialog(
      context: context,
      builder: (ctx) => StatefulBuilder(
        builder: (context, setDialogState) {
          return AlertDialog(
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
            title: Row(
              children: const [
                Icon(Icons.directions_bus_rounded, color: Color(0xFF2563EB)),
                SizedBox(width: 10),
                Text('Add New Bus', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
              ],
            ),
            content: SingleChildScrollView(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  TextField(
                    controller: idController,
                    decoration: const InputDecoration(labelText: 'Bus ID (e.g. B105)', border: OutlineInputBorder()),
                  ),
                  const SizedBox(height: 12),
                  TextField(
                    controller: routeController,
                    decoration: const InputDecoration(labelText: 'Route (e.g. Station → Airport)', border: OutlineInputBorder()),
                  ),
                  const SizedBox(height: 12),
                  TextField(
                    controller: driverController,
                    decoration: const InputDecoration(labelText: 'Driver Name', border: OutlineInputBorder()),
                  ),
                  const SizedBox(height: 12),
                  TextField(
                    controller: occController,
                    keyboardType: TextInputType.number,
                    decoration: const InputDecoration(labelText: 'Occupancy % (0 - 100)', border: OutlineInputBorder()),
                  ),
                  const SizedBox(height: 12),
                  DropdownButtonFormField<String>(
                    value: selectedStatus,
                    decoration: const InputDecoration(labelText: 'Status', border: OutlineInputBorder()),
                    items: const [
                      DropdownMenuItem(value: 'On Time', child: Text('On Time')),
                      DropdownMenuItem(value: 'Delayed', child: Text('Delayed')),
                      DropdownMenuItem(value: 'Breakdown', child: Text('Breakdown')),
                    ],
                    onChanged: (val) {
                      if (val != null) {
                        setDialogState(() => selectedStatus = val);
                      }
                    },
                  ),
                ],
              ),
            ),
            actions: [
              TextButton(
                onPressed: () => Navigator.pop(ctx),
                child: const Text('Cancel', style: TextStyle(color: Color(0xFF64748B))),
              ),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF2563EB),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                ),
                onPressed: () {
                  if (routeController.text.isEmpty || driverController.text.isEmpty) {
                    return;
                  }
                  final newBus = _BusModel(
                    id: idController.text.trim(),
                    route: routeController.text.trim(),
                    driver: driverController.text.trim(),
                    occupancyPercent: int.tryParse(occController.text) ?? 45,
                    status: selectedStatus,
                  );
                  setState(() {
                    _buses.add(newBus);
                  });
                  Navigator.pop(ctx);
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text('Bus ${newBus.id} added to live fleet tracking!'),
                      backgroundColor: const Color(0xFF10B981),
                    ),
                  );
                },
                child: const Text('Add Bus', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
              ),
            ],
          );
        },
      ),
    );
  }

  void _showViewBusModal(_BusModel bus) {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        title: Row(
          children: [
            Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: const Color(0xFFEFF6FF),
                borderRadius: BorderRadius.circular(10),
              ),
              child: const Icon(Icons.directions_bus_rounded, color: Color(0xFF2563EB)),
            ),
            const SizedBox(width: 12),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Bus Telemetry ${bus.id}', style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
                Text(bus.route, style: const TextStyle(fontSize: 12, color: Color(0xFF64748B))),
              ],
            ),
          ],
        ),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildTelemetryTile(Icons.person, 'Driver', bus.driver),
            _buildTelemetryTile(Icons.pie_chart_outline, 'Live Occupancy', '${bus.occupancyPercent}% capacity'),
            _buildTelemetryTile(Icons.speed, 'Current Speed', '42 km/h (GPS signal active)'),
            _buildTelemetryTile(Icons.alt_route, 'Current Status', bus.status),
            _buildTelemetryTile(Icons.local_gas_station_outlined, 'Fuel Level', '84% remaining'),
          ],
        ),
        actions: [
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFF2563EB),
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
            ),
            onPressed: () => Navigator.pop(ctx),
            child: const Text('Close', style: TextStyle(color: Colors.white)),
          ),
        ],
      ),
    );
  }

  Widget _buildTelemetryTile(IconData icon, String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6.0),
      child: Row(
        children: [
          Icon(icon, size: 18, color: const Color(0xFF64748B)),
          const SizedBox(width: 10),
          Text('$label: ', style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 13)),
          Text(value, style: const TextStyle(fontSize: 13, color: Color(0xFF334155))),
        ],
      ),
    );
  }

  void _showEditBusDialog(_BusModel bus) {
    final routeController = TextEditingController(text: bus.route);
    final driverController = TextEditingController(text: bus.driver);
    final occController = TextEditingController(text: bus.occupancyPercent.toString());
    String selectedStatus = bus.status;

    showDialog(
      context: context,
      builder: (ctx) => StatefulBuilder(
        builder: (context, setDialogState) {
          return AlertDialog(
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
            title: Text('Edit Bus ${bus.id}', style: const TextStyle(fontWeight: FontWeight.bold)),
            content: SingleChildScrollView(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  TextField(
                    controller: routeController,
                    decoration: const InputDecoration(labelText: 'Route', border: OutlineInputBorder()),
                  ),
                  const SizedBox(height: 12),
                  TextField(
                    controller: driverController,
                    decoration: const InputDecoration(labelText: 'Driver Name', border: OutlineInputBorder()),
                  ),
                  const SizedBox(height: 12),
                  TextField(
                    controller: occController,
                    keyboardType: TextInputType.number,
                    decoration: const InputDecoration(labelText: 'Occupancy %', border: OutlineInputBorder()),
                  ),
                  const SizedBox(height: 12),
                  DropdownButtonFormField<String>(
                    value: selectedStatus,
                    decoration: const InputDecoration(labelText: 'Status', border: OutlineInputBorder()),
                    items: const [
                      DropdownMenuItem(value: 'On Time', child: Text('On Time')),
                      DropdownMenuItem(value: 'Delayed', child: Text('Delayed')),
                      DropdownMenuItem(value: 'Breakdown', child: Text('Breakdown')),
                    ],
                    onChanged: (val) {
                      if (val != null) {
                        setDialogState(() => selectedStatus = val);
                      }
                    },
                  ),
                ],
              ),
            ),
            actions: [
              TextButton(
                onPressed: () => Navigator.pop(ctx),
                child: const Text('Cancel'),
              ),
              ElevatedButton(
                style: ElevatedButton.styleFrom(backgroundColor: const Color(0xFF2563EB)),
                onPressed: () {
                  setState(() {
                    bus.route = routeController.text.trim();
                    bus.driver = driverController.text.trim();
                    bus.occupancyPercent = int.tryParse(occController.text) ?? bus.occupancyPercent;
                    bus.status = selectedStatus;
                  });
                  Navigator.pop(ctx);
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text('Bus ${bus.id} details updated!'),
                      backgroundColor: const Color(0xFF2563EB),
                    ),
                  );
                },
                child: const Text('Save Changes', style: TextStyle(color: Colors.white)),
              ),
            ],
          );
        },
      ),
    );
  }

  void _showDeleteBusDialog(_BusModel bus) {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        title: Text('Remove Bus ${bus.id}?', style: const TextStyle(fontWeight: FontWeight.bold)),
        content: Text('Are you sure you want to remove Bus ${bus.id} (${bus.route}) from active tracking fleet?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(ctx),
            child: const Text('Cancel'),
          ),
          ElevatedButton(
            style: ElevatedButton.styleFrom(backgroundColor: const Color(0xFFEF4444)),
            onPressed: () {
              setState(() {
                _buses.remove(bus);
              });
              Navigator.pop(ctx);
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text('Bus ${bus.id} removed from fleet.'),
                  backgroundColor: const Color(0xFFEF4444),
                ),
              );
            },
            child: const Text('Remove Bus', style: TextStyle(color: Colors.white)),
          ),
        ],
      ),
    );
  }

  // --------------------------------------------------------------------------
  // TAB 3: ANALYTICS VIEW (EXACT IMPLEMENTATION MATCHING USER IMAGE)
  // --------------------------------------------------------------------------
  Widget _buildAnalyticsView() {
    return SingleChildScrollView(
      physics: const BouncingScrollPhysics(),
      padding: const EdgeInsets.all(28.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Header Row: Title & Subtitle + Period Toggle Pills (Daily, Weekly, Monthly)
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: const [
                  Text(
                    'Analytics',
                    style: TextStyle(
                      fontSize: 26,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF0F172A),
                      letterSpacing: -0.5,
                    ),
                  ),
                  SizedBox(height: 4),
                  Text(
                    'Transportation insights & trends',
                    style: TextStyle(
                      fontSize: 13.5,
                      color: Color(0xFF64748B),
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ),
              // Period Toggle Pills (Daily, Weekly, Monthly)
              Container(
                padding: const EdgeInsets.all(4),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(14),
                  border: Border.all(color: const Color(0xFFE2E8F0)),
                ),
                child: Row(
                  children: [
                    _buildAnalyticsPeriodPill('Daily'),
                    _buildAnalyticsPeriodPill('Weekly'),
                    _buildAnalyticsPeriodPill('Monthly'),
                  ],
                ),
              ),
            ],
          ),

          const SizedBox(height: 24),

          // Top Row: Hourly Passenger Distribution + Revenue Trend
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: _buildHourlyPassengerCard(),
              ),
              const SizedBox(width: 24),
              Expanded(
                child: _buildRevenueTrendCard(),
              ),
            ],
          ),

          const SizedBox(height: 24),

          // Middle Section: Congestion Heatmap Card
          _buildCongestionHeatmapCard(),

          const SizedBox(height: 24),

          // Bottom Section: Top Routes by Ridership Card
          _buildTopRoutesCard(),
        ],
      ),
    );
  }

  Widget _buildAnalyticsPeriodPill(String period) {
    final isSelected = _selectedAnalyticsPeriod == period;
    return InkWell(
      onTap: () {
        setState(() {
          _selectedAnalyticsPeriod = period;
        });
      },
      borderRadius: BorderRadius.circular(10),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        decoration: BoxDecoration(
          color: isSelected ? const Color(0xFF2563EB) : Colors.transparent,
          borderRadius: BorderRadius.circular(10),
        ),
        child: Text(
          period,
          style: TextStyle(
            fontSize: 13,
            fontWeight: isSelected ? FontWeight.bold : FontWeight.w500,
            color: isSelected ? Colors.white : const Color(0xFF64748B),
          ),
        ),
      ),
    );
  }

  Widget _buildHourlyPassengerCard() {
    return Container(
      padding: const EdgeInsets.all(24.0),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: const Color(0xFFF1F5F9)),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.02),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Hourly Passenger Distribution',
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: Color(0xFF0F172A),
            ),
          ),
          const SizedBox(height: 2),
          const Text(
            'Peak hours: 8AM & 5PM',
            style: TextStyle(
              fontSize: 12.5,
              color: Color(0xFF94A3B8),
            ),
          ),
          const SizedBox(height: 24),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: 160,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: const [
                    Text('10k', style: TextStyle(fontSize: 11, color: Color(0xFF94A3B8))),
                    Text('8k', style: TextStyle(fontSize: 11, color: Color(0xFF94A3B8))),
                    Text('5k', style: TextStyle(fontSize: 11, color: Color(0xFF94A3B8))),
                    Text('3k', style: TextStyle(fontSize: 11, color: Color(0xFF94A3B8))),
                    Text('0k', style: TextStyle(fontSize: 11, color: Color(0xFF94A3B8))),
                  ],
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  children: [
                    SizedBox(
                      height: 160,
                      child: CustomPaint(
                        size: Size.infinite,
                        painter: _HourlyPassengerChartPainter(),
                      ),
                    ),
                    const SizedBox(height: 10),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: const [
                        Text('6AM', style: TextStyle(fontSize: 11, color: Color(0xFF94A3B8))),
                        Text('8AM', style: TextStyle(fontSize: 11, color: Color(0xFF94A3B8))),
                        Text('10AM', style: TextStyle(fontSize: 11, color: Color(0xFF94A3B8))),
                        Text('12PM', style: TextStyle(fontSize: 11, color: Color(0xFF94A3B8))),
                        Text('2PM', style: TextStyle(fontSize: 11, color: Color(0xFF94A3B8))),
                        Text('4PM', style: TextStyle(fontSize: 11, color: Color(0xFF94A3B8))),
                        Text('6PM', style: TextStyle(fontSize: 11, color: Color(0xFF94A3B8))),
                        Text('8PM', style: TextStyle(fontSize: 11, color: Color(0xFF94A3B8))),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildRevenueTrendCard() {
    return Container(
      padding: const EdgeInsets.all(24.0),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: const Color(0xFFF1F5F9)),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.02),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Revenue Trend',
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: Color(0xFF0F172A),
            ),
          ),
          const SizedBox(height: 2),
          const Text(
            '6-month revenue growth',
            style: TextStyle(
              fontSize: 12.5,
              color: Color(0xFF94A3B8),
            ),
          ),
          const SizedBox(height: 24),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: 160,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: const [
                    Text('₹260k', style: TextStyle(fontSize: 11, color: Color(0xFF94A3B8))),
                    Text('₹195k', style: TextStyle(fontSize: 11, color: Color(0xFF94A3B8))),
                    Text('₹130k', style: TextStyle(fontSize: 11, color: Color(0xFF94A3B8))),
                    Text('₹65k', style: TextStyle(fontSize: 11, color: Color(0xFF94A3B8))),
                    Text('₹0k', style: TextStyle(fontSize: 11, color: Color(0xFF94A3B8))),
                  ],
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  children: [
                    SizedBox(
                      height: 160,
                      child: CustomPaint(
                        size: Size.infinite,
                        painter: _RevenueTrendChartPainter(),
                      ),
                    ),
                    const SizedBox(height: 10),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: const [
                        Text('Feb', style: TextStyle(fontSize: 11, color: Color(0xFF94A3B8))),
                        Text('Mar', style: TextStyle(fontSize: 11, color: Color(0xFF94A3B8))),
                        Text('Apr', style: TextStyle(fontSize: 11, color: Color(0xFF94A3B8))),
                        Text('May', style: TextStyle(fontSize: 11, color: Color(0xFF94A3B8))),
                        Text('Jun', style: TextStyle(fontSize: 11, color: Color(0xFF94A3B8))),
                        Text('Jul', style: TextStyle(fontSize: 11, color: Color(0xFF94A3B8))),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildCongestionHeatmapCard() {
    final days = ['Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat', 'Sun'];

    final List<List<int>> matrix = [
      [3, 3, 3, 3, 3, 3, 3],
      [2, 2, 2, 2, 2, 2, 2],
      [2, 2, 2, 2, 2, 2, 2],
      [3, 2, 3, 2, 3, 3, 1],
      [0, 1, 0, 1, 0, 1, 1],
      [2, 2, 2, 3, 2, 2, 2],
      [2, 2, 2, 2, 2, 2, 2],
      [1, 1, 1, 1, 1, 1, 1],
      [1, 1, 1, 1, 1, 1, 1],
      [1, 1, 1, 1, 1, 1, 1],
      [2, 3, 3, 2, 2, 3, 3],
      [2, 2, 2, 2, 2, 2, 2],
      [2, 2, 2, 2, 2, 2, 2],
    ];

    Color getShadeColor(int level) {
      switch (level) {
        case 0:
          return const Color(0xFFE0E7FF);
        case 1:
          return const Color(0xFF93C5FD);
        case 2:
          return const Color(0xFF60A5FA);
        case 3:
        default:
          return const Color(0xFF2563EB);
      }
    }

    return Container(
      padding: const EdgeInsets.all(24.0),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: const Color(0xFFF1F5F9)),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.02),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Congestion Heatmap',
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: Color(0xFF0F172A),
            ),
          ),
          const SizedBox(height: 2),
          const Text(
            'Passenger density across routes — darker = higher density',
            style: TextStyle(
              fontSize: 12.5,
              color: Color(0xFF94A3B8),
            ),
          ),
          const SizedBox(height: 24),
          Row(
            children: days.map((day) {
              return Expanded(
                child: Center(
                  child: Text(
                    day,
                    style: const TextStyle(
                      fontSize: 11.5,
                      fontWeight: FontWeight.w500,
                      color: Color(0xFF94A3B8),
                    ),
                  ),
                ),
              );
            }).toList(),
          ),
          const SizedBox(height: 10),
          Column(
            children: List.generate(matrix.length, (rowIndex) {
              return Padding(
                padding: const EdgeInsets.only(bottom: 6.0),
                child: Row(
                  children: List.generate(7, (colIndex) {
                    final shade = matrix[rowIndex][colIndex];
                    return Expanded(
                      child: Container(
                        margin: const EdgeInsets.symmetric(horizontal: 4),
                        height: 16,
                        decoration: BoxDecoration(
                          color: getShadeColor(shade),
                          borderRadius: BorderRadius.circular(4),
                        ),
                      ),
                    );
                  }),
                ),
              );
            }),
          ),
          const SizedBox(height: 16),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              const Text('Low', style: TextStyle(fontSize: 11, color: Color(0xFF94A3B8))),
              const SizedBox(width: 8),
              Container(width: 14, height: 14, decoration: BoxDecoration(color: getShadeColor(0), borderRadius: BorderRadius.circular(3))),
              const SizedBox(width: 4),
              Container(width: 14, height: 14, decoration: BoxDecoration(color: getShadeColor(1), borderRadius: BorderRadius.circular(3))),
              const SizedBox(width: 4),
              Container(width: 14, height: 14, decoration: BoxDecoration(color: getShadeColor(2), borderRadius: BorderRadius.circular(3))),
              const SizedBox(width: 4),
              Container(width: 14, height: 14, decoration: BoxDecoration(color: getShadeColor(3), borderRadius: BorderRadius.circular(3))),
              const SizedBox(width: 8),
              const Text('High', style: TextStyle(fontSize: 11, color: Color(0xFF94A3B8))),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildTopRoutesCard() {
    return Container(
      padding: const EdgeInsets.all(24.0),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: const Color(0xFFF1F5F9)),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.02),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Top Routes by Ridership',
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: Color(0xFF0F172A),
            ),
          ),
          const SizedBox(height: 24),
          _buildRouteProgressRow(
            routeName: 'City Center → Airport',
            countStr: '12,480',
            barColor: const Color(0xFF2563EB),
            factor: 0.85,
          ),
          const SizedBox(height: 16),
          _buildRouteProgressRow(
            routeName: 'University → Downtown',
            countStr: '9,240',
            barColor: const Color(0xFF14B8A6),
            factor: 0.65,
          ),
          const SizedBox(height: 16),
          _buildRouteProgressRow(
            routeName: 'Mall → Station',
            countStr: '7,820',
            barColor: const Color(0xFF10B981),
            factor: 0.50,
          ),
          const SizedBox(height: 16),
          _buildRouteProgressRow(
            routeName: 'Hospital → Beach',
            countStr: '5,430',
            barColor: const Color(0xFFF59E0B),
            factor: 0.35,
          ),
        ],
      ),
    );
  }

  Widget _buildRouteProgressRow({
    required String routeName,
    required String countStr,
    required Color barColor,
    required double factor,
  }) {
    return Row(
      children: [
        SizedBox(
          width: 180,
          child: Text(
            routeName,
            style: const TextStyle(
              fontSize: 13.5,
              fontWeight: FontWeight.w500,
              color: Color(0xFF334155),
            ),
          ),
        ),
        const SizedBox(width: 16),
        Expanded(
          child: Container(
            height: 8,
            decoration: BoxDecoration(
              color: const Color(0xFFF1F5F9),
              borderRadius: BorderRadius.circular(4),
            ),
            child: FractionallySizedBox(
              alignment: Alignment.centerLeft,
              widthFactor: factor,
              child: Container(
                decoration: BoxDecoration(
                  color: barColor,
                  borderRadius: BorderRadius.circular(4),
                ),
              ),
            ),
          ),
        ),
        const SizedBox(width: 20),
        SizedBox(
          width: 60,
          child: Text(
            countStr,
            textAlign: TextAlign.right,
            style: const TextStyle(
              fontSize: 13.5,
              fontWeight: FontWeight.bold,
              color: Color(0xFF0F172A),
            ),
          ),
        ),
      ],
    );
  }

  // --------------------------------------------------------------------------
  // OTHER DASHBOARD TABS
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

// Model for Bus Fleet Items
class _BusModel {
  String id;
  String route;
  String driver;
  int occupancyPercent;
  String status;

  _BusModel({
    required this.id,
    required this.route,
    required this.driver,
    required this.occupancyPercent,
    required this.status,
  });
}

// Custom Painters for Dashboard & Analytics
class _HourlyPassengerChartPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final gridPaint = Paint()
      ..color = const Color(0xFFE2E8F0)
      ..strokeWidth = 1
      ..style = PaintingStyle.stroke;

    for (int i = 0; i <= 4; i++) {
      final y = size.height * (i / 4);
      _drawDashedLine(canvas, Offset(0, y), Offset(size.width, y), gridPaint);
    }

    final values = [
      0.10, 0.45, 0.92, 0.75, 0.42, 0.38, 0.50, 0.55, 0.42, 0.45, 0.68, 0.95, 0.76, 0.46, 0.35
    ];

    final barCount = values.length;
    final totalSpacing = size.width * 0.35;
    final barWidth = (size.width - totalSpacing) / barCount;
    final gap = totalSpacing / (barCount - 1);

    final barPaint = Paint()
      ..color = const Color(0xFF14B8A6)
      ..style = PaintingStyle.fill;

    for (int i = 0; i < barCount; i++) {
      final x = i * (barWidth + gap);
      final barHeight = size.height * values[i];
      final y = size.height - barHeight;

      final rect = RRect.fromRectAndRadius(
        Rect.fromLTWH(x, y, barWidth, barHeight),
        const Radius.circular(4),
      );

      canvas.drawRRect(rect, barPaint);
    }
  }

  void _drawDashedLine(Canvas canvas, Offset p1, Offset p2, Paint paint) {
    const dashWidth = 4.0;
    const dashSpace = 4.0;
    double startX = p1.dx;
    while (startX < p2.dx) {
      canvas.drawLine(
        Offset(startX, p1.dy),
        Offset((startX + dashWidth).clamp(p1.dx, p2.dx), p1.dy),
        paint,
      );
      startX += dashWidth + dashSpace;
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

class _RevenueTrendChartPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final gridPaint = Paint()
      ..color = const Color(0xFFE2E8F0)
      ..strokeWidth = 1
      ..style = PaintingStyle.stroke;

    for (int i = 0; i <= 4; i++) {
      final y = size.height * (i / 4);
      _drawDashedLine(canvas, Offset(0, y), Offset(size.width, y), gridPaint);
    }

    final points = [
      Offset(0, size.height * (1.0 - 180 / 260)),
      Offset(size.width * 0.2, size.height * (1.0 - 195 / 260)),
      Offset(size.width * 0.4, size.height * (1.0 - 220 / 260)),
      Offset(size.width * 0.6, size.height * (1.0 - 215 / 260)),
      Offset(size.width * 0.8, size.height * (1.0 - 250 / 260)),
      Offset(size.width, size.height * (1.0 - 245 / 260)),
    ];

    final path = Path();
    path.moveTo(points[0].dx, points[0].dy);

    for (int i = 0; i < points.length - 1; i++) {
      final p0 = points[i];
      final p1 = points[i + 1];
      final controlPoint1 = Offset(p0.dx + (p1.dx - p0.dx) / 2, p0.dy);
      final controlPoint2 = Offset(p0.dx + (p1.dx - p0.dx) / 2, p1.dy);
      path.cubicTo(controlPoint1.dx, controlPoint1.dy, controlPoint2.dx, controlPoint2.dy, p1.dx, p1.dy);
    }

    final fillPath = Path.from(path)
      ..lineTo(size.width, size.height)
      ..lineTo(0, size.height)
      ..close();

    final fillPaint = Paint()
      ..shader = LinearGradient(
        begin: Alignment.topCenter,
        end: Alignment.bottomCenter,
        colors: [
          const Color(0xFF10B981).withValues(alpha: 0.18),
          const Color(0xFF10B981).withValues(alpha: 0.0),
        ],
      ).createShader(Rect.fromLTWH(0, 0, size.width, size.height));

    canvas.drawPath(fillPath, fillPaint);

    final linePaint = Paint()
      ..color = const Color(0xFF10B981)
      ..strokeWidth = 3.5
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round;

    canvas.drawPath(path, linePaint);
  }

  void _drawDashedLine(Canvas canvas, Offset p1, Offset p2, Paint paint) {
    const dashWidth = 4.0;
    const dashSpace = 4.0;
    double startX = p1.dx;
    while (startX < p2.dx) {
      canvas.drawLine(
        Offset(startX, p1.dy),
        Offset((startX + dashWidth).clamp(p1.dx, p2.dx), p1.dy),
        paint,
      );
      startX += dashWidth + dashSpace;
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

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

    final fillPath = Path.from(path)
      ..lineTo(size.width, size.height)
      ..lineTo(0, size.height)
      ..close();

    final fillPaint = Paint()
      ..shader = LinearGradient(
        begin: Alignment.topCenter,
        end: Alignment.bottomCenter,
        colors: [
          const Color(0xFF2563EB).withValues(alpha: 0.15),
          const Color(0xFF2563EB).withValues(alpha: 0.0),
        ],
      ).createShader(Rect.fromLTWH(0, 0, size.width, size.height));

    canvas.drawPath(fillPath, fillPaint);

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

    paint.color = const Color(0xFF10B981);
    canvas.drawArc(
      Rect.fromCircle(center: center, radius: radius - strokeWidth / 2),
      -1.57,
      4.52,
      false,
      paint,
    );

    paint.color = const Color(0xFFF59E0B);
    canvas.drawArc(
      Rect.fromCircle(center: center, radius: radius - strokeWidth / 2),
      2.95,
      0.75,
      false,
      paint,
    );

    paint.color = const Color(0xFFEF4444);
    canvas.drawArc(
      Rect.fromCircle(center: center, radius: radius - strokeWidth / 2),
      3.70,
      0.31,
      false,
      paint,
    );

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

class _MapGridPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = const Color(0xFFCBD5E1).withValues(alpha: 0.6)
      ..strokeWidth = 12
      ..style = PaintingStyle.stroke;

    canvas.drawLine(Offset(0, size.height * 0.25), Offset(size.width, size.height * 0.25), paint);
    canvas.drawLine(Offset(0, size.height * 0.55), Offset(size.width, size.height * 0.55), paint);
    canvas.drawLine(Offset(0, size.height * 0.85), Offset(size.width, size.height * 0.85), paint);

    canvas.drawLine(Offset(size.width * 0.25, 0), Offset(size.width * 0.25, size.height), paint);
    canvas.drawLine(Offset(size.width * 0.55, 0), Offset(size.width * 0.55, size.height), paint);
    canvas.drawLine(Offset(size.width * 0.85, 0), Offset(size.width * 0.85, size.height), paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
