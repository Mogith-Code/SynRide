import 'package:flutter/material.dart';

class PassengerProfileScreen extends StatefulWidget {
  const PassengerProfileScreen({super.key});

  @override
  State<PassengerProfileScreen> createState() => _PassengerProfileScreenState();
}

class _PassengerProfileScreenState extends State<PassengerProfileScreen> {
  int _currentBottomNavIndex = 4; // 4 = Profile active tab
  bool _isDarkMode = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF8FAFC),
      body: SafeArea(
        child: Column(
          children: [
            // Top Hero Profile Header Section
            Container(
              width: double.infinity,
              padding: const EdgeInsets.fromLTRB(20, 24, 20, 24),
              decoration: const BoxDecoration(
                color: Color(0xFFEBF3FC),
                borderRadius: BorderRadius.vertical(
                  bottom: Radius.circular(28),
                ),
              ),
              child: Column(
                children: [
                  // Avatar with Camera Badge
                  SizedBox(
                    width: 90,
                    height: 90,
                    child: Stack(
                      clipBehavior: Clip.none,
                      children: [
                        // Main Avatar Circle
                        Container(
                          width: 86,
                          height: 86,
                          decoration: const BoxDecoration(
                            shape: BoxShape.circle,
                            gradient: LinearGradient(
                              begin: Alignment.topLeft,
                              end: Alignment.bottomRight,
                              colors: [
                                Color(0xFF00C6FF),
                                Color(0xFF0072FF),
                              ],
                            ),
                          ),
                          child: const Center(
                            child: Icon(
                              Icons.person_rounded,
                              size: 48,
                              color: Colors.white,
                            ),
                          ),
                        ),

                        // Green Camera Badge
                        Positioned(
                          right: 0,
                          bottom: 2,
                          child: Container(
                            width: 26,
                            height: 26,
                            decoration: BoxDecoration(
                              color: const Color(0xFF22C55E),
                              shape: BoxShape.circle,
                              border: Border.all(color: Colors.white, width: 2),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.black.withOpacity(0.1),
                                  blurRadius: 4,
                                  offset: const Offset(0, 2),
                                ),
                              ],
                            ),
                            child: const Icon(
                              Icons.camera_alt_rounded,
                              size: 13,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),

                  const SizedBox(height: 14),

                  // Name
                  const Text(
                    'Arjun Sharma',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF0F172A),
                      letterSpacing: -0.2,
                    ),
                  ),

                  const SizedBox(height: 3),

                  // Email
                  const Text(
                    'arjun.sharma@email.com',
                    style: TextStyle(
                      fontSize: 13,
                      color: Color(0xFF64748B),
                    ),
                  ),

                  const SizedBox(height: 20),

                  // 3 Stat Metrics Row (Trips, km Saved, Rating)
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      _buildProfileStat('47', 'Trips'),
                      Container(width: 1, height: 28, color: const Color(0xFFCBD5E1)),
                      _buildProfileStat('428', 'km Saved'),
                      Container(width: 1, height: 28, color: const Color(0xFFCBD5E1)),
                      _buildProfileStat('4.9 ★', 'Rating'),
                    ],
                  ),
                ],
              ),
            ),

            const SizedBox(height: 14),

            // Scrollable Profile Menu List
            Expanded(
              child: ListView(
                physics: const BouncingScrollPhysics(),
                padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
                children: [
                  // 1. Saved Routes
                  _buildMenuItem(
                    icon: Icons.favorite_border_rounded,
                    iconBg: const Color(0xFFFEE2E2),
                    iconColor: const Color(0xFFEF4444),
                    title: 'Saved Routes',
                    onTap: () {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text('Saved Routes opened.')),
                      );
                    },
                  ),
                  const SizedBox(height: 10),

                  // 2. Notification Settings
                  _buildMenuItem(
                    icon: Icons.notifications_none_rounded,
                    iconBg: const Color(0xFFFEF3C7),
                    iconColor: const Color(0xFFD97706),
                    title: 'Notification Settings',
                    onTap: () {
                      Navigator.pushNamed(context, '/passenger/notifications');
                    },
                  ),
                  const SizedBox(height: 10),

                  // 3. Language
                  _buildMenuItem(
                    icon: Icons.map_outlined,
                    iconBg: const Color(0xFFDBEAFE),
                    iconColor: const Color(0xFF2563EB),
                    title: 'Language',
                    onTap: () {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text('Language selected: English')),
                      );
                    },
                  ),
                  const SizedBox(height: 10),

                  // 4. Dark Mode
                  _buildMenuItem(
                    icon: Icons.show_chart_rounded,
                    iconBg: const Color(0xFFF3E8FF),
                    iconColor: const Color(0xFF9333EA),
                    title: 'Dark Mode',
                    trailingWidget: Switch.adaptive(
                      value: _isDarkMode,
                      activeColor: const Color(0xFF2563EB),
                      onChanged: (val) {
                        setState(() {
                          _isDarkMode = val;
                        });
                      },
                    ),
                    onTap: () {
                      setState(() {
                        _isDarkMode = !_isDarkMode;
                      });
                    },
                  ),
                  const SizedBox(height: 10),

                  // 5. Help Center
                  _buildMenuItem(
                    icon: Icons.chat_bubble_outline_rounded,
                    iconBg: const Color(0xFFE0F2FE),
                    iconColor: const Color(0xFF0284C7),
                    title: 'Help Center',
                    onTap: () {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text('SyncRide Help Center & Support')),
                      );
                    },
                  ),
                  const SizedBox(height: 10),

                  // 6. Logout
                  _buildMenuItem(
                    icon: Icons.arrow_back_rounded,
                    iconBg: const Color(0xFFFEE2E2),
                    iconColor: const Color(0xFFEF4444),
                    title: 'Logout',
                    titleColor: const Color(0xFF0F172A),
                    onTap: () {
                      Navigator.pushNamedAndRemoveUntil(
                        context,
                        '/passenger/login',
                        (route) => false,
                      );
                    },
                  ),
                  const SizedBox(height: 16),
                ],
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: Container(
        height: 66,
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
    );
  }

  Widget _buildProfileStat(String value, String label) {
    return Column(
      children: [
        Text(
          value,
          style: const TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: Color(0xFF0F172A),
          ),
        ),
        const SizedBox(height: 2),
        Text(
          label,
          style: const TextStyle(
            fontSize: 11.5,
            color: Color(0xFF64748B),
          ),
        ),
      ],
    );
  }

  Widget _buildMenuItem({
    required IconData icon,
    required Color iconBg,
    required Color iconColor,
    required String title,
    Color titleColor = const Color(0xFF0F172A),
    Widget? trailingWidget,
    required VoidCallback onTap,
  }) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(18),
        border: Border.all(color: const Color(0xFFF1F5F9)),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.015),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(18),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
          child: Row(
            children: [
              // Icon Container
              Container(
                width: 40,
                height: 40,
                decoration: BoxDecoration(
                  color: iconBg,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Icon(icon, color: iconColor, size: 20),
              ),
              const SizedBox(width: 14),

              // Title
              Expanded(
                child: Text(
                  title,
                  style: TextStyle(
                    fontSize: 14.5,
                    fontWeight: FontWeight.w600,
                    color: titleColor,
                  ),
                ),
              ),

              // Trailing Widget or Chevron
              trailingWidget ??
                  const Icon(
                    Icons.chevron_right_rounded,
                    color: Color(0xFFCBD5E1),
                    size: 22,
                  ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildNavItem(int index, IconData icon, String label) {
    final isSelected = _currentBottomNavIndex == index;
    return GestureDetector(
      onTap: () {
        if (index == 0) {
          Navigator.pushReplacementNamed(context, '/passenger/home');
        } else if (index == 1) {
          Navigator.pushNamed(context, '/passenger/search');
        } else if (index == 2) {
          Navigator.pushNamed(context, '/passenger/map');
        } else if (index == 3) {
          Navigator.pushNamed(context, '/passenger/notifications');
        }
      },
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 6),
        decoration: BoxDecoration(
          color: isSelected ? const Color(0xFFE0EDFF) : Colors.transparent,
          borderRadius: BorderRadius.circular(18),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              icon,
              size: 22,
              color: isSelected ? const Color(0xFF2563EB) : const Color(0xFF94A3B8),
            ),
            const SizedBox(height: 2),
            Text(
              label,
              style: TextStyle(
                fontSize: 11,
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
