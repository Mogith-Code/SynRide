import 'package:flutter/material.dart';
import '../../../../core/constants/app_colors.dart';

class PassengerHomeScreen extends StatefulWidget {
  const PassengerHomeScreen({super.key});

  @override
  State<PassengerHomeScreen> createState() => _PassengerHomeScreenState();
}

class _PassengerHomeScreenState extends State<PassengerHomeScreen> {
  int _selectedFilterIndex = 0;
  int _currentBottomNavIndex = 0;

  final List<String> _filters = ['Nearby', 'Express', 'No Crowd', 'Favorites'];

  void _showHubRoleSelector(BuildContext context) {
    showModalBottomSheet(
      context: context,
      backgroundColor: AppColors.surface,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
      ),
      builder: (context) {
        return Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Select Application Mode',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
              const SizedBox(height: 16),
              ListTile(
                leading: const CircleAvatar(
                  backgroundColor: AppColors.primary,
                  child: Icon(Icons.person_outline, color: Colors.white),
                ),
                title: const Text('Passenger App', style: TextStyle(color: Colors.white)),
                subtitle: const Text('Live tracking, tickets & AI recommendations',
                    style: TextStyle(color: AppColors.textSecondary, fontSize: 12)),
                trailing: const Icon(Icons.arrow_forward_ios, size: 16, color: Colors.white54),
                onTap: () {
                  Navigator.pop(context);
                },
              ),
              const Divider(color: Colors.white10),
              ListTile(
                leading: const CircleAvatar(
                  backgroundColor: AppColors.accent,
                  child: Icon(Icons.confirmation_number_outlined, color: Colors.white),
                ),
                title: const Text('Conductor Mode', style: TextStyle(color: Colors.white)),
                subtitle: const Text('Issue digital tickets & offline sync queue',
                    style: TextStyle(color: AppColors.textSecondary, fontSize: 12)),
                trailing: const Icon(Icons.arrow_forward_ios, size: 16, color: Colors.white54),
                onTap: () {
                  Navigator.pop(context);
                  Navigator.pushNamed(context, '/conductor');
                },
              ),
              const Divider(color: Colors.white10),
              ListTile(
                leading: const CircleAvatar(
                  backgroundColor: AppColors.warning,
                  child: Icon(Icons.dashboard_outlined, color: Colors.white),
                ),
                title: const Text('Authority Dashboard', style: TextStyle(color: Colors.white)),
                subtitle: const Text('Fleet analytics, occupancy & fleet health',
                    style: TextStyle(color: AppColors.textSecondary, fontSize: 12)),
                trailing: const Icon(Icons.arrow_forward_ios, size: 16, color: Colors.white54),
                onTap: () {
                  Navigator.pop(context);
                  Navigator.pushNamed(context, '/authority');
                },
              ),
            ],
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Color(0xFF091428),
              Color(0xFF070E1B),
              Color(0xFF0C192E),
            ],
          ),
        ),
        child: SafeArea(
          child: Column(
            children: [
              // Top Navigation Bar
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 12.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    // Back to Hub Pill Button
                    InkWell(
                      onTap: () => _showHubRoleSelector(context),
                      borderRadius: BorderRadius.circular(20),
                      child: Container(
                        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
                        decoration: BoxDecoration(
                          color: Colors.white.withOpacity(0.08),
                          borderRadius: BorderRadius.circular(20),
                          border: Border.all(
                            color: Colors.white.withOpacity(0.15),
                            width: 1,
                          ),
                        ),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: const [
                            Icon(Icons.arrow_back_rounded, size: 16, color: Colors.white70),
                            SizedBox(width: 6),
                            Text(
                              'Back to Hub',
                              style: TextStyle(
                                color: Colors.white70,
                                fontSize: 13,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    // Passenger App Title
                    const Text(
                      'Passenger App',
                      style: TextStyle(
                        color: Color(0xFF00E5FF),
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                        letterSpacing: 0.3,
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 8),

              // Central Phone Frame Container
              Expanded(
                child: Center(
                  child: Container(
                    width: 360,
                    height: 660,
                    margin: const EdgeInsets.symmetric(horizontal: 20),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(38),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.45),
                          blurRadius: 36,
                          spreadRadius: 4,
                          offset: const Offset(0, 12),
                        ),
                        BoxShadow(
                          color: const Color(0xFF0088FF).withOpacity(0.15),
                          blurRadius: 30,
                          spreadRadius: 1,
                        ),
                      ],
                    ),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(38),
                      child: Column(
                        children: [
                          // Status Bar Header
                          Container(
                            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                            color: Colors.white,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                const Text(
                                  '9:41 AM',
                                  style: TextStyle(
                                    fontSize: 12,
                                    fontWeight: FontWeight.w600,
                                    color: Color(0xFF1E293B),
                                  ),
                                ),
                                Container(
                                  width: 80,
                                  height: 18,
                                  decoration: BoxDecoration(
                                    color: const Color(0xFF0F172A),
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                ),
                                Row(
                                  children: const [
                                    Icon(Icons.signal_cellular_alt, size: 14, color: Color(0xFF1E293B)),
                                    SizedBox(width: 4),
                                    Icon(Icons.wifi, size: 14, color: Color(0xFF1E293B)),
                                    SizedBox(width: 4),
                                    Icon(Icons.battery_full, size: 14, color: Color(0xFF1E293B)),
                                  ],
                                ),
                              ],
                            ),
                          ),

                          // Scrollable Main Content View
                          Expanded(
                            child: SingleChildScrollView(
                              physics: const BouncingScrollPhysics(),
                              padding: const EdgeInsets.symmetric(horizontal: 18.0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  const SizedBox(height: 8),

                                  // Location & Weather / Actions Header
                                  Row(
                                    children: [
                                      const Icon(Icons.location_on_outlined, color: Color(0xFF2563EB), size: 22),
                                      const SizedBox(width: 6),
                                      Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: const [
                                          Text(
                                            'Current Location',
                                            style: TextStyle(
                                              fontSize: 11,
                                              color: Color(0xFF94A3B8),
                                              fontWeight: FontWeight.w500,
                                            ),
                                          ),
                                          SizedBox(height: 1),
                                          Text(
                                            'Pune, Maharashtra',
                                            style: TextStyle(
                                              fontSize: 15,
                                              fontWeight: FontWeight.bold,
                                              color: Color(0xFF0F172A),
                                            ),
                                          ),
                                        ],
                                      ),
                                      const Spacer(),

                                      // Weather Badge
                                      Container(
                                        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                                        decoration: BoxDecoration(
                                          color: const Color(0xFFFEF3C7),
                                          borderRadius: BorderRadius.circular(16),
                                        ),
                                        child: Row(
                                          children: const [
                                            Icon(Icons.wb_sunny_rounded, size: 14, color: Color(0xFFD97706)),
                                            SizedBox(width: 4),
                                            Text(
                                              '28°C',
                                              style: TextStyle(
                                                fontSize: 12,
                                                fontWeight: FontWeight.bold,
                                                color: Color(0xFFD97706),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                      const SizedBox(width: 10),

                                      // Notification Bell Icon with Badge
                                      Stack(
                                        clipBehavior: Clip.none,
                                        children: [
                                          Container(
                                            padding: const EdgeInsets.all(7),
                                            decoration: BoxDecoration(
                                              color: const Color(0xFFF1F5F9),
                                              shape: BoxShape.circle,
                                            ),
                                            child: const Icon(
                                              Icons.notifications_none_rounded,
                                              size: 18,
                                              color: Color(0xFF334155),
                                            ),
                                          ),
                                          Positioned(
                                            top: -2,
                                            right: -2,
                                            child: Container(
                                              padding: const EdgeInsets.all(4),
                                              decoration: const BoxDecoration(
                                                color: Color(0xFFEF4444),
                                                shape: BoxShape.circle,
                                              ),
                                              child: const Text(
                                                '3',
                                                style: TextStyle(
                                                  fontSize: 9,
                                                  fontWeight: FontWeight.bold,
                                                  color: Colors.white,
                                                ),
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                      const SizedBox(width: 8),

                                      // User Avatar
                                      GestureDetector(
                                        onTap: () => Navigator.pushNamed(context, '/passenger/pass'),
                                        child: const CircleAvatar(
                                          radius: 17,
                                          backgroundColor: Color(0xFF00C6FF),
                                          child: Icon(Icons.person, color: Colors.white, size: 20),
                                        ),
                                      ),
                                    ],
                                  ),

                                  const SizedBox(height: 16),

                                  // Search Bar
                                  Container(
                                    height: 46,
                                    padding: const EdgeInsets.symmetric(horizontal: 14),
                                    decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius: BorderRadius.circular(14),
                                      border: Border.all(color: const Color(0xFFE2E8F0)),
                                      boxShadow: [
                                        BoxShadow(
                                          color: Colors.black.withOpacity(0.03),
                                          blurRadius: 8,
                                          offset: const Offset(0, 2),
                                        ),
                                      ],
                                    ),
                                    child: Row(
                                      children: const [
                                        Icon(Icons.search_rounded, color: Color(0xFF94A3B8), size: 20),
                                        SizedBox(width: 10),
                                        Expanded(
                                          child: TextField(
                                            decoration: InputDecoration(
                                              hintText: 'Where are you going?',
                                              hintStyle: TextStyle(
                                                color: Color(0xFF94A3B8),
                                                fontSize: 14,
                                              ),
                                              border: InputBorder.none,
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),

                                  const SizedBox(height: 14),

                                  // Category Filter Chips
                                  SizedBox(
                                    height: 36,
                                    child: ListView.builder(
                                      scrollDirection: Axis.horizontal,
                                      itemCount: _filters.length,
                                      itemBuilder: (context, index) {
                                        final isSelected = _selectedFilterIndex == index;
                                        return GestureDetector(
                                          onTap: () {
                                            setState(() {
                                              _selectedFilterIndex = index;
                                            });
                                          },
                                          child: AnimatedContainer(
                                            duration: const Duration(milliseconds: 200),
                                            margin: const EdgeInsets.only(right: 8),
                                            padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 8),
                                            decoration: BoxDecoration(
                                              color: isSelected
                                                  ? const Color(0xFF2563EB)
                                                  : Colors.white,
                                              borderRadius: BorderRadius.circular(20),
                                              border: Border.all(
                                                color: isSelected
                                                    ? const Color(0xFF2563EB)
                                                    : const Color(0xFFE2E8F0),
                                              ),
                                            ),
                                            child: Text(
                                              _filters[index],
                                              style: TextStyle(
                                                fontSize: 13,
                                                fontWeight: isSelected ? FontWeight.bold : FontWeight.w500,
                                                color: isSelected ? Colors.white : const Color(0xFF475569),
                                              ),
                                            ),
                                          ),
                                        );
                                      },
                                    ),
                                  ),

                                  const SizedBox(height: 16),

                                  // AI Recommendation Card
                                  InkWell(
                                    onTap: () => Navigator.pushNamed(context, '/passenger/recommendations'),
                                    borderRadius: BorderRadius.circular(16),
                                    child: Container(
                                      padding: const EdgeInsets.all(14),
                                      decoration: BoxDecoration(
                                        color: const Color(0xFFE0F2FE),
                                        borderRadius: BorderRadius.circular(16),
                                        border: Border.all(color: const Color(0xFFBAE6FD)),
                                      ),
                                      child: Row(
                                        children: [
                                          Container(
                                            width: 38,
                                            height: 38,
                                            decoration: const BoxDecoration(
                                              color: Color(0xFF0284C7),
                                              shape: BoxShape.circle,
                                            ),
                                            child: const Icon(
                                              Icons.bolt_rounded,
                                              color: Colors.white,
                                              size: 22,
                                            ),
                                          ),
                                          const SizedBox(width: 12),
                                          Expanded(
                                            child: Column(
                                              crossAxisAlignment: CrossAxisAlignment.start,
                                              children: const [
                                                Text(
                                                  'AI Recommendation',
                                                  style: TextStyle(
                                                    fontSize: 11,
                                                    fontWeight: FontWeight.bold,
                                                    color: Color(0xFF0284C7),
                                                  ),
                                                ),
                                                SizedBox(height: 2),
                                                Text(
                                                  'Bus 177 is 45% full — perfect time to travel!',
                                                  style: TextStyle(
                                                    fontSize: 13,
                                                    fontWeight: FontWeight.bold,
                                                    color: Color(0xFF0F172A),
                                                  ),
                                                ),
                                                SizedBox(height: 2),
                                                Text(
                                                  'Saves ~8 min vs current traffic',
                                                  style: TextStyle(
                                                    fontSize: 11,
                                                    color: Color(0xFF64748B),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                          const Icon(
                                            Icons.chevron_right_rounded,
                                            color: Color(0xFF0284C7),
                                            size: 22,
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),

                                  const SizedBox(height: 12),

                                  // Crowd Alert Card
                                  Container(
                                    padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
                                    decoration: BoxDecoration(
                                      color: const Color(0xFFFEF2F2),
                                      borderRadius: BorderRadius.circular(14),
                                      border: Border.all(color: const Color(0xFFFCA5A5)),
                                    ),
                                    child: Row(
                                      children: const [
                                        Icon(Icons.warning_amber_rounded, color: Color(0xFFEF4444), size: 20),
                                        SizedBox(width: 10),
                                        Expanded(
                                          child: Text.rich(
                                            TextSpan(
                                              style: TextStyle(fontSize: 12, color: Color(0xFF991B1B)),
                                              children: [
                                                TextSpan(
                                                  text: 'Bus 342 ',
                                                  style: TextStyle(fontWeight: FontWeight.bold),
                                                ),
                                                TextSpan(text: 'is very crowded (91%) — consider '),
                                                TextSpan(
                                                  text: 'Bus 177 ',
                                                  style: TextStyle(fontWeight: FontWeight.bold),
                                                ),
                                                TextSpan(text: 'instead'),
                                              ],
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),

                                  const SizedBox(height: 20),

                                  // Nearby Buses Header
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      const Text(
                                        'Nearby Buses',
                                        style: TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.bold,
                                          color: Color(0xFF0F172A),
                                        ),
                                      ),
                                      GestureDetector(
                                        onTap: () => Navigator.pushNamed(context, '/passenger/map'),
                                        child: const Text(
                                          'See all',
                                          style: TextStyle(
                                            fontSize: 13,
                                            fontWeight: FontWeight.w600,
                                            color: Color(0xFF2563EB),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),

                                  const SizedBox(height: 12),

                                  // Nearby Bus List Items
                                  _buildBusCard(
                                    busNumber: 'Bus 177',
                                    route: 'City Center → Airport',
                                    occupancyLabel: 'Medium 45%',
                                    occupancyBg: const Color(0xFFFEF3C7),
                                    occupancyText: const Color(0xFFD97706),
                                    arrivalTime: '3 min',
                                    distance: '1.2 km',
                                    statusLabel: 'Approaching',
                                    statusBg: const Color(0xFFDBEAFE),
                                    statusText: const Color(0xFF1E40AF),
                                    onTap: () => Navigator.pushNamed(context, '/passenger/bus-details'),
                                  ),
                                  const SizedBox(height: 10),

                                  _buildBusCard(
                                    busNumber: 'Bus 203',
                                    route: 'University → Downtown',
                                    occupancyLabel: 'High 78%',
                                    occupancyBg: const Color(0xFFFEE2E2),
                                    occupancyText: const Color(0xFFDC2626),
                                    arrivalTime: '8 min',
                                    distance: '3.4 km',
                                    statusLabel: 'On Time',
                                    statusBg: const Color(0xFFDCFCE7),
                                    statusText: const Color(0xFF15803D),
                                    onTap: () => Navigator.pushNamed(context, '/passenger/bus-details'),
                                  ),
                                  const SizedBox(height: 10),

                                  _buildBusCard(
                                    busNumber: 'Bus 101',
                                    route: 'Mall → Central Station',
                                    occupancyLabel: 'Low 22%',
                                    occupancyBg: const Color(0xFFDCFCE7),
                                    occupancyText: const Color(0xFF15803D),
                                    arrivalTime: '12 min',
                                    distance: '5.1 km',
                                    statusLabel: 'On Time',
                                    statusBg: const Color(0xFFDCFCE7),
                                    statusText: const Color(0xFF15803D),
                                    onTap: () => Navigator.pushNamed(context, '/passenger/bus-details'),
                                  ),

                                  const SizedBox(height: 20),

                                  // Recent Trips Header
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: const [
                                      Text(
                                        'Recent Trips',
                                        style: TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.bold,
                                          color: Color(0xFF0F172A),
                                        ),
                                      ),
                                      Text(
                                        'View all',
                                        style: TextStyle(
                                          fontSize: 13,
                                          fontWeight: FontWeight.w600,
                                          color: Color(0xFF2563EB),
                                        ),
                                      ),
                                    ],
                                  ),

                                  const SizedBox(height: 12),

                                  // Trip 1
                                  _buildTripItem(
                                    title: 'Home → Office',
                                    subtext: 'Bus 177 · 35 min · Today',
                                    price: '₹45',
                                  ),
                                  const SizedBox(height: 8),

                                  // Trip 2
                                  _buildTripItem(
                                    title: 'Office → Mall',
                                    subtext: 'Bus 203 · 22 min · Yesterday',
                                    price: '₹28',
                                  ),

                                  const SizedBox(height: 20),

                                  // Impact Card
                                  Container(
                                    width: double.infinity,
                                    padding: const EdgeInsets.all(18),
                                    decoration: BoxDecoration(
                                      color: const Color(0xFF0F172A),
                                      borderRadius: BorderRadius.circular(20),
                                      boxShadow: [
                                        BoxShadow(
                                          color: Colors.black.withOpacity(0.15),
                                          blurRadius: 12,
                                          offset: const Offset(0, 4),
                                        ),
                                      ],
                                    ),
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        const Text(
                                          'Your Impact This Month',
                                          style: TextStyle(
                                            fontSize: 12,
                                            fontWeight: FontWeight.w500,
                                            color: Color(0xFF94A3B8),
                                          ),
                                        ),
                                        const SizedBox(height: 14),
                                        Row(
                                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                                          children: [
                                            _buildImpactStat('47', 'Trips'),
                                            Container(width: 1, height: 28, color: Colors.white10),
                                            _buildImpactStat('28kg', 'CO₂ Saved'),
                                            Container(width: 1, height: 28, color: Colors.white10),
                                            _buildImpactStat('₹840', 'Money Saved'),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),

                                  const SizedBox(height: 20),
                                ],
                              ),
                            ),
                          ),

                          // Bottom Navigation Bar Dock
                          Container(
                            height: 64,
                            decoration: BoxDecoration(
                              color: Colors.white,
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.black.withOpacity(0.06),
                                  blurRadius: 10,
                                  offset: const Offset(0, -2),
                                ),
                              ],
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                _buildNavItem(0, Icons.home_rounded, 'Home'),
                                _buildNavItem(1, Icons.search_rounded, 'Search'),
                                _buildNavItem(2, Icons.map_outlined, 'Map'),
                                _buildNavItem(3, Icons.notifications_none_rounded, 'Alerts'),
                                _buildNavItem(4, Icons.person_outline_rounded, 'Profile'),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildBusCard({
    required String busNumber,
    required String route,
    required String occupancyLabel,
    required Color occupancyBg,
    required Color occupancyText,
    required String arrivalTime,
    required String distance,
    required String statusLabel,
    required Color statusBg,
    required Color statusText,
    required VoidCallback onTap,
  }) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: const Color(0xFFF1F5F9)),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.02),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(16),
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Row(
            children: [
              // Bus Icon Box
              Container(
                width: 42,
                height: 42,
                decoration: BoxDecoration(
                  color: const Color(0xFFEFF6FF),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: const Icon(
                  Icons.directions_bus_rounded,
                  color: Color(0xFF2563EB),
                  size: 22,
                ),
              ),
              const SizedBox(width: 12),

              // Bus Details
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      busNumber,
                      style: const TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                        color: Color(0xFF0F172A),
                      ),
                    ),
                    const SizedBox(height: 2),
                    Text(
                      route,
                      style: const TextStyle(
                        fontSize: 11,
                        color: Color(0xFF64748B),
                      ),
                    ),
                    const SizedBox(height: 6),
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                      decoration: BoxDecoration(
                        color: occupancyBg,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Text(
                        occupancyLabel,
                        style: TextStyle(
                          fontSize: 10,
                          fontWeight: FontWeight.bold,
                          color: occupancyText,
                        ),
                      ),
                    ),
                  ],
                ),
              ),

              // Right arrival info
              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text(
                    arrivalTime,
                    style: const TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF16A34A),
                    ),
                  ),
                  const SizedBox(height: 1),
                  Text(
                    distance,
                    style: const TextStyle(
                      fontSize: 11,
                      color: Color(0xFF94A3B8),
                    ),
                  ),
                  const SizedBox(height: 6),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                    decoration: BoxDecoration(
                      color: statusBg,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Text(
                      statusLabel,
                      style: TextStyle(
                        fontSize: 10,
                        fontWeight: FontWeight.bold,
                        color: statusText,
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTripItem({
    required String title,
    required String subtext,
    required String price,
  }) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: const Color(0xFFF1F5F9)),
      ),
      child: Row(
        children: [
          Container(
            width: 36,
            height: 36,
            decoration: BoxDecoration(
              color: const Color(0xFFF0FDF4),
              borderRadius: BorderRadius.circular(10),
            ),
            child: const Icon(
              Icons.swap_calls_rounded,
              color: Color(0xFF0D9488),
              size: 20,
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    fontSize: 13,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF0F172A),
                  ),
                ),
                const SizedBox(height: 2),
                Text(
                  subtext,
                  style: const TextStyle(
                    fontSize: 11,
                    color: Color(0xFF64748B),
                  ),
                ),
              ],
            ),
          ),
          Text(
            price,
            style: const TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.bold,
              color: Color(0xFF16A34A),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildImpactStat(String value, String label) {
    return Column(
      children: [
        Text(
          value,
          style: const TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
        const SizedBox(height: 2),
        Text(
          label,
          style: const TextStyle(
            fontSize: 11,
            color: Color(0xFF94A3B8),
          ),
        ),
      ],
    );
  }

  Widget _buildNavItem(int index, IconData icon, String label) {
    final isSelected = _currentBottomNavIndex == index;
    return GestureDetector(
      onTap: () {
        setState(() {
          _currentBottomNavIndex = index;
        });
        if (index == 2) {
          Navigator.pushNamed(context, '/passenger/map');
        } else if (index == 4) {
          Navigator.pushNamed(context, '/passenger/pass');
        }
      },
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
        decoration: BoxDecoration(
          color: isSelected ? const Color(0xFFE0EDFF) : Colors.transparent,
          borderRadius: BorderRadius.circular(16),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              icon,
              size: 20,
              color: isSelected ? const Color(0xFF2563EB) : const Color(0xFF94A3B8),
            ),
            const SizedBox(height: 2),
            Text(
              label,
              style: TextStyle(
                fontSize: 10,
                fontWeight: isSelected ? FontWeight.bold : FontWeight.w500,
                color: isSelected ? const Color(0xFF2563EB) : const Color(0xFF94A3B8),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
