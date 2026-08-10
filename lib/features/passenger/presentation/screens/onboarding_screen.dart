import 'package:flutter/material.dart';
import '../../../../core/constants/app_colors.dart';

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({super.key});

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  final PageController _pageController = PageController();
  int _currentPage = 0;

  final List<_OnboardingItem> _items = const [
    _OnboardingItem(
      title: 'Real-Time Bus Tracking',
      description:
          'Track every bus live on the map. Know exactly where your bus is and when it will arrive at your stop.',
      icon: Icons.location_on_rounded,
      iconBgColor: Color(0xFF2563EB),
      outerContainerColor: Color(0xFFE2EDFF),
    ),
    _OnboardingItem(
      title: 'AI Seat & Crowd Forecast',
      description:
          'Predict seat availability and crowd density live at each stop before you board.',
      icon: Icons.insights_rounded,
      iconBgColor: Color(0xFF0284C7),
      outerContainerColor: Color(0xFFE0F2FE),
    ),
    _OnboardingItem(
      title: 'Digital Tickets & Pass',
      description:
          'Seamless QR check-in, offline sync receipts, and instant ticket purchases on the go.',
      icon: Icons.qr_code_scanner_rounded,
      iconBgColor: Color(0xFF4F46E5),
      outerContainerColor: Color(0xFFEEF2FF),
    ),
  ];

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  void _onNextPressed() {
    if (_currentPage < _items.length - 1) {
      _pageController.nextPage(
        duration: const Duration(milliseconds: 350),
        curve: Curves.easeInOut,
      );
    } else {
      _navigateToHome();
    }
  }

  void _navigateToHome() {
    Navigator.pushReplacementNamed(context, '/passenger/login');
  }

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
                  _navigateToHome();
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
                    // Passenger App Label
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

              const SizedBox(height: 12),

              // Central Phone Frame Container
              Expanded(
                child: Center(
                  child: SingleChildScrollView(
                    physics: const BouncingScrollPhysics(),
                    child: Container(
                      width: 360,
                      height: 640,
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
                            // Mobile Top Notch & Status Bar Header
                            Container(
                              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                              color: Colors.white,
                              child: Column(
                                children: [
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      // Time
                                      const Text(
                                        '9:41 AM',
                                        style: TextStyle(
                                          fontSize: 12,
                                          fontWeight: FontWeight.w600,
                                          color: Color(0xFF1E293B),
                                        ),
                                      ),
                                      // Notch
                                      Container(
                                        width: 80,
                                        height: 18,
                                        decoration: BoxDecoration(
                                          color: const Color(0xFF0F172A),
                                          borderRadius: BorderRadius.circular(10),
                                        ),
                                      ),
                                      // Status icons
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
                                  const SizedBox(height: 8),
                                  // Skip Button Row
                                  Align(
                                    alignment: Alignment.centerRight,
                                    child: TextButton(
                                      onPressed: _navigateToHome,
                                      style: TextButton.styleFrom(
                                        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                                        minimumSize: Size.zero,
                                        tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                                      ),
                                      child: const Text(
                                        'Skip',
                                        style: TextStyle(
                                          color: Color(0xFF64748B),
                                          fontSize: 13,
                                          fontWeight: FontWeight.w500,
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),

                            // Page View (Content)
                            Expanded(
                              child: PageView.builder(
                                controller: _pageController,
                                itemCount: _items.length,
                                onPageChanged: (index) {
                                  setState(() {
                                    _currentPage = index;
                                  });
                                },
                                itemBuilder: (context, index) {
                                  final item = _items[index];
                                  return Padding(
                                    padding: const EdgeInsets.symmetric(horizontal: 28.0),
                                    child: Column(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      children: [
                                        const Spacer(flex: 1),

                                        // Soft square illustration frame
                                        Container(
                                          width: 140,
                                          height: 140,
                                          decoration: BoxDecoration(
                                            color: item.outerContainerColor,
                                            borderRadius: BorderRadius.circular(32),
                                          ),
                                          child: Center(
                                            child: Container(
                                              width: 80,
                                              height: 80,
                                              decoration: BoxDecoration(
                                                color: item.iconBgColor,
                                                borderRadius: BorderRadius.circular(22),
                                                boxShadow: [
                                                  BoxShadow(
                                                    color: item.iconBgColor.withOpacity(0.35),
                                                    blurRadius: 16,
                                                    offset: const Offset(0, 6),
                                                  ),
                                                ],
                                              ),
                                              child: Icon(
                                                item.icon,
                                                size: 42,
                                                color: Colors.white,
                                              ),
                                            ),
                                          ),
                                        ),

                                        const SizedBox(height: 32),

                                        // Title
                                        Text(
                                          item.title,
                                          textAlign: TextAlign.center,
                                          style: const TextStyle(
                                            fontSize: 22,
                                            fontWeight: FontWeight.bold,
                                            color: Color(0xFF0F172A),
                                            letterSpacing: -0.3,
                                          ),
                                        ),

                                        const SizedBox(height: 12),

                                        // Description
                                        Text(
                                          item.description,
                                          textAlign: TextAlign.center,
                                          style: const TextStyle(
                                            fontSize: 13.5,
                                            height: 1.45,
                                            color: Color(0xFF64748B),
                                            fontWeight: FontWeight.w400,
                                          ),
                                        ),

                                        const Spacer(flex: 2),
                                      ],
                                    ),
                                  );
                                },
                              ),
                            ),

                            // Bottom Controls (Dots & Button)
                            Padding(
                              padding: const EdgeInsets.only(left: 24, right: 24, bottom: 28),
                              child: Column(
                                children: [
                                  // Pagination Dots
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: List.generate(
                                      _items.length,
                                      (index) => AnimatedContainer(
                                        duration: const Duration(milliseconds: 250),
                                        margin: const EdgeInsets.symmetric(horizontal: 4),
                                        width: _currentPage == index ? 22 : 6,
                                        height: 6,
                                        decoration: BoxDecoration(
                                          color: _currentPage == index
                                              ? const Color(0xFF2563EB)
                                              : const Color(0xFFCBD5E1),
                                          borderRadius: BorderRadius.circular(3),
                                        ),
                                      ),
                                    ),
                                  ),

                                  const SizedBox(height: 24),

                                  // Next / Get Started Button
                                  SizedBox(
                                    width: double.infinity,
                                    height: 50,
                                    child: ElevatedButton(
                                      onPressed: _onNextPressed,
                                      style: ElevatedButton.styleFrom(
                                        padding: EdgeInsets.zero,
                                        shape: RoundedRectangleBorder(
                                          borderRadius: BorderRadius.circular(26),
                                        ),
                                        elevation: 6,
                                        shadowColor: const Color(0xFF0D9488).withOpacity(0.35),
                                      ),
                                      child: Ink(
                                        decoration: BoxDecoration(
                                          gradient: const LinearGradient(
                                            colors: [
                                              Color(0xFF2563EB),
                                              Color(0xFF0D9488),
                                            ],
                                          ),
                                          borderRadius: BorderRadius.circular(26),
                                        ),
                                        child: Container(
                                          alignment: Alignment.center,
                                          child: Row(
                                            mainAxisAlignment: MainAxisAlignment.center,
                                            children: [
                                              Text(
                                                _currentPage == _items.length - 1
                                                    ? 'Get Started'
                                                    : 'Next',
                                                style: const TextStyle(
                                                  fontSize: 16,
                                                  fontWeight: FontWeight.bold,
                                                  color: Colors.white,
                                                  letterSpacing: 0.2,
                                                ),
                                              ),
                                              const SizedBox(width: 6),
                                              const Icon(
                                                Icons.chevron_right_rounded,
                                                size: 22,
                                                color: Colors.white,
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
                          ],
                        ),
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
}

class _OnboardingItem {
  final String title;
  final String description;
  final IconData icon;
  final Color iconBgColor;
  final Color outerContainerColor;

  const _OnboardingItem({
    required this.title,
    required this.description,
    required this.icon,
    required this.iconBgColor,
    required this.outerContainerColor,
  });
}
