import 'package:flutter/material.dart';

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
      _navigateToLogin();
    }
  }

  void _navigateToLogin() {
    Navigator.pushReplacementNamed(context, '/passenger/login');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        actions: [
          TextButton(
            onPressed: _navigateToLogin,
            child: const Text(
              'Skip',
              style: TextStyle(
                color: Color(0xFF64748B),
                fontSize: 14,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
          const SizedBox(width: 12),
        ],
      ),
      body: SafeArea(
        child: Column(
          children: [
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
                    padding: const EdgeInsets.symmetric(horizontal: 32.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Spacer(flex: 1),

                        // Soft square illustration frame
                        Container(
                          width: 150,
                          height: 150,
                          decoration: BoxDecoration(
                            color: item.outerContainerColor,
                            borderRadius: BorderRadius.circular(34),
                          ),
                          child: Center(
                            child: Container(
                              width: 86,
                              height: 86,
                              decoration: BoxDecoration(
                                color: item.iconBgColor,
                                borderRadius: BorderRadius.circular(24),
                                boxShadow: [
                                  BoxShadow(
                                    color: item.iconBgColor.withValues(alpha: 0.35),
                                    blurRadius: 18,
                                    offset: const Offset(0, 6),
                                  ),
                                ],
                              ),
                              child: Icon(
                                item.icon,
                                size: 46,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ),

                        const SizedBox(height: 36),

                        // Title
                        Text(
                          item.title,
                          textAlign: TextAlign.center,
                          style: const TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                            color: Color(0xFF0F172A),
                            letterSpacing: -0.3,
                          ),
                        ),

                        const SizedBox(height: 14),

                        // Description
                        Text(
                          item.description,
                          textAlign: TextAlign.center,
                          style: const TextStyle(
                            fontSize: 14,
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
              padding: const EdgeInsets.only(left: 32, right: 32, bottom: 32),
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
                        width: _currentPage == index ? 24 : 6,
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

                  const SizedBox(height: 28),

                  // Next / Get Started Button
                  SizedBox(
                    width: double.infinity,
                    height: 52,
                    child: ElevatedButton(
                      onPressed: _onNextPressed,
                      style: ElevatedButton.styleFrom(
                        padding: EdgeInsets.zero,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(26),
                        ),
                        elevation: 6,
                        shadowColor: const Color(0xFF0D9488).withValues(alpha: 0.35),
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
