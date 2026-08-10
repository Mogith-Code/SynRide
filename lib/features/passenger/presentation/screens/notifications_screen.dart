import 'package:flutter/material.dart';

class NotificationsScreen extends StatefulWidget {
  const NotificationsScreen({super.key});

  @override
  State<NotificationsScreen> createState() => _NotificationsScreenState();
}

class _NotificationsScreenState extends State<NotificationsScreen> {
  final int _currentBottomNavIndex = 3; // 3 = Alerts active tab
  bool _markAllRead = false;

  final List<Map<String, dynamic>> _notifications = [
    {
      'id': '1',
      'title': 'Bus 177 arriving in 3 minutes',
      'subtitle': 'Your tracked bus is approaching Main Station.',
      'time': '2 min ago',
      'icon': Icons.directions_bus_rounded,
      'iconBg': const Color(0xFFDBEAFE),
      'iconColor': const Color(0xFF2563EB),
      'isUnread': true,
      'cardBg': const Color(0xFFEFF6FF),
      'borderColor': const Color(0xFFBFDBFE),
    },
    {
      'id': '2',
      'title': 'Bus 342 delayed by 7 minutes',
      'subtitle': 'Due to heavy traffic near City Square.',
      'time': '5 min ago',
      'icon': Icons.warning_amber_rounded,
      'iconBg': const Color(0xFFFEF3C7),
      'iconColor': const Color(0xFFD97706),
      'isUnread': false,
      'cardBg': Colors.white,
      'borderColor': const Color(0xFFF1F5F9),
    },
    {
      'id': '3',
      'title': 'High congestion on MG Road',
      'subtitle': 'Consider alternate route via Ring Road.',
      'time': '12 min ago',
      'icon': Icons.error_outline_rounded,
      'iconBg': const Color(0xFFFEE2E2),
      'iconColor': const Color(0xFFEF4444),
      'isUnread': false,
      'cardBg': Colors.white,
      'borderColor': const Color(0xFFF1F5F9),
    },
    {
      'id': '4',
      'title': 'Seats available on Bus 215',
      'subtitle': 'Your preferred bus now has 32 seats available.',
      'time': '18 min ago',
      'icon': Icons.check_circle_outline_rounded,
      'iconBg': const Color(0xFFDCFCE7),
      'iconColor': const Color(0xFF16A34A),
      'isUnread': false,
      'cardBg': Colors.white,
      'borderColor': const Color(0xFFF1F5F9),
    },
    {
      'id': '5',
      'title': 'Rain expected in 2 hours',
      'subtitle': 'Plan your travel accordingly. Buses may face delays.',
      'time': '30 min ago',
      'icon': Icons.thunderstorm_outlined,
      'iconBg': const Color(0xFFF3E8FF),
      'iconColor': const Color(0xFF9333EA),
      'isUnread': false,
      'cardBg': Colors.white,
      'borderColor': const Color(0xFFF1F5F9),
    },
    {
      'id': '6',
      'title': 'AI Suggestion: Leave in 5 minutes',
      'subtitle': 'Optimal departure time to catch Bus 177 with low crowd.',
      'time': '1 hr ago',
      'icon': Icons.bolt_rounded,
      'iconBg': const Color(0xFFE0F2FE),
      'iconColor': const Color(0xFF0284C7),
      'isUnread': false,
      'cardBg': Colors.white,
      'borderColor': const Color(0xFFF1F5F9),
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF8FAFC),
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        automaticallyImplyLeading: false,
        title: const Text(
          'Notifications',
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: Color(0xFF0F172A),
          ),
        ),
        actions: [
          TextButton(
            onPressed: () {
              setState(() {
                _markAllRead = true;
                for (var item in _notifications) {
                  item['isUnread'] = false;
                  item['cardBg'] = Colors.white;
                  item['borderColor'] = const Color(0xFFF1F5F9);
                }
              });
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text('All notifications marked as read.'),
                ),
              );
            },
            child: const Text(
              'Mark all read',
              style: TextStyle(
                fontSize: 13.5,
                fontWeight: FontWeight.w600,
                color: Color(0xFF2563EB),
              ),
            ),
          ),
          const SizedBox(width: 8),
        ],
      ),
      body: SafeArea(
        child: ListView.separated(
          physics: const BouncingScrollPhysics(),
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 14),
          itemCount: _notifications.length,
          separatorBuilder: (context, index) => const SizedBox(height: 12),
          itemBuilder: (context, index) {
            final item = _notifications[index];
            final bool isUnread = item['isUnread'] && !_markAllRead;

            return Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: isUnread ? const Color(0xFFEFF6FF) : item['cardBg'],
                borderRadius: BorderRadius.circular(18),
                border: Border.all(
                  color: isUnread ? const Color(0xFFBFDBFE) : item['borderColor'],
                ),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withValues(alpha: 0.02),
                    blurRadius: 10,
                    offset: const Offset(0, 2),
                  ),
                ],
              ),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Left Icon Container Box
                  Container(
                    width: 44,
                    height: 44,
                    decoration: BoxDecoration(
                      color: item['iconBg'],
                      borderRadius: BorderRadius.circular(14),
                    ),
                    child: Icon(
                      item['icon'],
                      color: item['iconColor'],
                      size: 22,
                    ),
                  ),
                  const SizedBox(width: 14),

                  // Middle Content (Title, Subtitle, Time)
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          item['title'],
                          style: const TextStyle(
                            fontSize: 14.5,
                            fontWeight: FontWeight.bold,
                            color: Color(0xFF0F172A),
                            height: 1.3,
                          ),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          item['subtitle'],
                          style: const TextStyle(
                            fontSize: 12.5,
                            color: Color(0xFF64748B),
                            height: 1.35,
                          ),
                        ),
                        const SizedBox(height: 8),
                        Text(
                          item['time'],
                          style: const TextStyle(
                            fontSize: 11,
                            color: Color(0xFF94A3B8),
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ],
                    ),
                  ),

                  // Right Unread Indicator Dot
                  if (isUnread) ...[
                    const SizedBox(width: 8),
                    Container(
                      width: 8,
                      height: 8,
                      margin: const EdgeInsets.only(top: 4),
                      decoration: const BoxDecoration(
                        color: Color(0xFF2563EB),
                        shape: BoxShape.circle,
                      ),
                    ),
                  ],
                ],
              ),
            );
          },
        ),
      ),
      bottomNavigationBar: Container(
        height: 66,
        decoration: BoxDecoration(
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.06),
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
        } else if (index == 4) {
          Navigator.pushNamed(context, '/passenger/pass');
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
