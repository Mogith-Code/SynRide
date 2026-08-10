import 'package:flutter/material.dart';

class LocationTrackerSearchScreen extends StatefulWidget {
  const LocationTrackerSearchScreen({super.key});

  @override
  State<LocationTrackerSearchScreen> createState() => _LocationTrackerSearchScreenState();
}

class _LocationTrackerSearchScreenState extends State<LocationTrackerSearchScreen> {
  int _selectedFilterIndex = 0;
  int _currentBottomNavIndex = 1; // 1 = Search tab active

  final List<String> _filters = ['All', 'Bus No', 'Route', 'Nearby', 'Express'];
  final TextEditingController _searchController = TextEditingController();

  final List<Map<String, dynamic>> _buses = [
    {
      'number': 'Bus 177',
      'route': 'City Center → Airport',
      'status': 'Approaching',
      'statusBg': const Color(0xFFDBEAFE),
      'statusText': const Color(0xFF1E40AF),
      'occupancy': 'Medium 45%',
      'occupancyBg': const Color(0xFFFEF3C7),
      'occupancyText': const Color(0xFFD97706),
      'eta': '3 min',
      'distance': '1.2 km',
      'seatsFree': '22 seats free',
    },
    {
      'number': 'Bus 203',
      'route': 'University → Downtown',
      'status': 'On Time',
      'statusBg': const Color(0xFFDCFCE7),
      'statusText': const Color(0xFF15803D),
      'occupancy': 'High 78%',
      'occupancyBg': const Color(0xFFFEE2E2),
      'occupancyText': const Color(0xFFDC2626),
      'eta': '8 min',
      'distance': '3.4 km',
      'seatsFree': '6 seats free',
    },
    {
      'number': 'Bus 101',
      'route': 'Mall → Central Station',
      'status': 'On Time',
      'statusBg': const Color(0xFFDCFCE7),
      'statusText': const Color(0xFF15803D),
      'occupancy': 'Low 22%',
      'occupancyBg': const Color(0xFFDCFCE7),
      'occupancyText': const Color(0xFF15803D),
      'eta': '12 min',
      'distance': '5.1 km',
      'seatsFree': '38 seats free',
    },
    {
      'number': 'Bus 342',
      'route': 'Station → University',
      'status': 'Delayed',
      'statusBg': const Color(0xFFFEE2E2),
      'statusText': const Color(0xFFDC2626),
      'occupancy': 'Very Crowded 91%',
      'occupancyBg': const Color(0xFFFEE2E2),
      'occupancyText': const Color(0xFFDC2626),
      'eta': '5 min',
      'distance': '2.0 km',
      'seatsFree': '2 seats free',
    },
    {
      'number': 'Bus 215',
      'route': 'Hospital → Beach Road',
      'status': 'On Time',
      'statusBg': const Color(0xFFDCFCE7),
      'statusText': const Color(0xFF15803D),
      'occupancy': 'Low 35%',
      'occupancyBg': const Color(0xFFDCFCE7),
      'occupancyText': const Color(0xFF15803D),
      'eta': '15 min',
      'distance': '6.3 km',
      'seatsFree': '32 seats free',
    },
  ];

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF8FAFC),
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_rounded, color: Color(0xFF0F172A)),
          onPressed: () => Navigator.pop(context),
        ),
        title: Container(
          height: 44,
          padding: const EdgeInsets.symmetric(horizontal: 14),
          decoration: BoxDecoration(
            color: const Color(0xFFF8FAFC),
            borderRadius: BorderRadius.circular(14),
            border: Border.all(color: const Color(0xFFE2E8F0)),
          ),
          child: Row(
            children: [
              const Icon(Icons.search_rounded, color: Color(0xFF2563EB), size: 20),
              const SizedBox(width: 10),
              Expanded(
                child: TextField(
                  controller: _searchController,
                  style: const TextStyle(fontSize: 14, color: Color(0xFF0F172A)),
                  decoration: const InputDecoration(
                    hintText: 'Search bus, route, stop...',
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
      ),
      body: SafeArea(
        child: Column(
          children: [
            const SizedBox(height: 12),

            // Filter Chips Row (All, Bus No, Route, Nearby, Express)
            SizedBox(
              height: 38,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                padding: const EdgeInsets.symmetric(horizontal: 20),
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
                        color: isSelected ? const Color(0xFF2563EB) : Colors.white,
                        borderRadius: BorderRadius.circular(20),
                        border: Border.all(
                          color: isSelected ? const Color(0xFF2563EB) : const Color(0xFFE2E8F0),
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

            // Header Text: "5 buses found near you"
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 20.0),
              child: Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  '5 buses found near you',
                  style: TextStyle(
                    fontSize: 13,
                    fontWeight: FontWeight.w500,
                    color: Color(0xFF64748B),
                  ),
                ),
              ),
            ),

            const SizedBox(height: 12),

            // Scrollable List of Buses
            Expanded(
              child: ListView.separated(
                physics: const BouncingScrollPhysics(),
                padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 4),
                itemCount: _buses.length,
                separatorBuilder: (context, index) => const SizedBox(height: 12),
                itemBuilder: (context, index) {
                  final bus = _buses[index];
                  return Container(
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(18),
                      border: Border.all(color: const Color(0xFFF1F5F9)),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.02),
                          blurRadius: 10,
                          offset: const Offset(0, 2),
                        ),
                      ],
                    ),
                    child: InkWell(
                      onTap: () {
                        Navigator.pushNamed(context, '/passenger/bus-details');
                      },
                      borderRadius: BorderRadius.circular(18),
                      child: Column(
                        children: [
                          Row(
                            children: [
                              // Bus Icon Box
                              Container(
                                width: 44,
                                height: 44,
                                decoration: BoxDecoration(
                                  color: const Color(0xFFEFF6FF),
                                  borderRadius: BorderRadius.circular(14),
                                ),
                                child: const Icon(
                                  Icons.directions_bus_rounded,
                                  color: Color(0xFF2563EB),
                                  size: 24,
                                ),
                              ),
                              const SizedBox(width: 14),

                              // Bus Title & Status
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Row(
                                      children: [
                                        Text(
                                          bus['number'],
                                          style: const TextStyle(
                                            fontSize: 15,
                                            fontWeight: FontWeight.bold,
                                            color: Color(0xFF0F172A),
                                          ),
                                        ),
                                        const SizedBox(width: 8),
                                        Container(
                                          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                                          decoration: BoxDecoration(
                                            color: bus['statusBg'],
                                            borderRadius: BorderRadius.circular(10),
                                          ),
                                          child: Text(
                                            bus['status'],
                                            style: TextStyle(
                                              fontSize: 10.5,
                                              fontWeight: FontWeight.bold,
                                              color: bus['statusText'],
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                    const SizedBox(height: 3),
                                    Text(
                                      bus['route'],
                                      style: const TextStyle(
                                        fontSize: 12,
                                        color: Color(0xFF64748B),
                                      ),
                                    ),
                                  ],
                                ),
                              ),

                              // Right Column (ETA & Distance)
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.end,
                                children: [
                                  Text(
                                    bus['eta'],
                                    style: const TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold,
                                      color: Color(0xFF16A34A),
                                    ),
                                  ),
                                  const SizedBox(height: 1),
                                  Text(
                                    bus['distance'],
                                    style: const TextStyle(
                                      fontSize: 11.5,
                                      color: Color(0xFF94A3B8),
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),

                          const SizedBox(height: 14),

                          // Occupancy & Seats Row
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Container(
                                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                                decoration: BoxDecoration(
                                  color: bus['occupancyBg'],
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                child: Text(
                                  bus['occupancy'],
                                  style: TextStyle(
                                    fontSize: 10.5,
                                    fontWeight: FontWeight.bold,
                                    color: bus['occupancyText'],
                                  ),
                                ),
                              ),
                              Row(
                                children: [
                                  const Icon(
                                    Icons.groups_outlined,
                                    size: 15,
                                    color: Color(0xFF64748B),
                                  ),
                                  const SizedBox(width: 4),
                                  Text(
                                    bus['seatsFree'],
                                    style: const TextStyle(
                                      fontSize: 11.5,
                                      color: Color(0xFF64748B),
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  );
                },
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

  Widget _buildNavItem(int index, IconData icon, String label) {
    final isSelected = _currentBottomNavIndex == index;
    return GestureDetector(
      onTap: () {
        if (index == 0) {
          Navigator.pushReplacementNamed(context, '/passenger/home');
        } else if (index == 2) {
          Navigator.pushNamed(context, '/passenger/map');
        } else if (index == 3) {
          Navigator.pushNamed(context, '/passenger/notifications');
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
