import 'package:flutter/material.dart';
import '../../../../core/constants/app_colors.dart';

class BusDetailsScreen extends StatelessWidget {
  const BusDetailsScreen({super.key});

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
                  Navigator.pushReplacementNamed(context, '/passenger/home');
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

                          // Top Internal Screen Header Bar
                          Container(
                            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                            color: Colors.white,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                IconButton(
                                  icon: const Icon(Icons.arrow_back_rounded, color: Color(0xFF0F172A)),
                                  onPressed: () => Navigator.pop(context),
                                ),
                                const Text(
                                  'Bus 177',
                                  style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                    color: Color(0xFF0F172A),
                                  ),
                                ),
                                TextButton(
                                  onPressed: () {
                                    ScaffoldMessenger.of(context).showSnackBar(
                                      const SnackBar(
                                        content: Text('Bus 177 tracking link copied to clipboard.'),
                                        backgroundColor: AppColors.primary,
                                      ),
                                    );
                                  },
                                  child: const Text(
                                    'Share',
                                    style: TextStyle(
                                      fontSize: 13,
                                      fontWeight: FontWeight.w600,
                                      color: Color(0xFF2563EB),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),

                          // Scrollable Main Content
                          Expanded(
                            child: SingleChildScrollView(
                              physics: const BouncingScrollPhysics(),
                              padding: const EdgeInsets.symmetric(horizontal: 18.0, vertical: 8.0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  // Top Bus Summary Hero Card
                                  Container(
                                    width: double.infinity,
                                    padding: const EdgeInsets.all(18),
                                    decoration: BoxDecoration(
                                      gradient: const LinearGradient(
                                        begin: Alignment.topLeft,
                                        end: Alignment.bottomRight,
                                        colors: [
                                          Color(0xFF2563EB),
                                          Color(0xFF0EA5E9),
                                          Color(0xFF0D9488),
                                        ],
                                      ),
                                      borderRadius: BorderRadius.circular(22),
                                      boxShadow: [
                                        BoxShadow(
                                          color: const Color(0xFF2563EB).withOpacity(0.3),
                                          blurRadius: 16,
                                          offset: const Offset(0, 6),
                                        ),
                                      ],
                                    ),
                                    child: Column(
                                      children: [
                                        // Header Row inside hero card
                                        Row(
                                          children: [
                                            Container(
                                              width: 44,
                                              height: 44,
                                              decoration: BoxDecoration(
                                                color: Colors.white.withOpacity(0.2),
                                                borderRadius: BorderRadius.circular(12),
                                              ),
                                              child: const Icon(
                                                Icons.directions_bus_rounded,
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
                                                    'Bus 177',
                                                    style: TextStyle(
                                                      fontSize: 16,
                                                      fontWeight: FontWeight.bold,
                                                      color: Colors.white,
                                                    ),
                                                  ),
                                                  SizedBox(height: 2),
                                                  Text(
                                                    'City Center → Airport',
                                                    style: TextStyle(
                                                      fontSize: 12,
                                                      color: Colors.white70,
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),

                                            // Status Badge
                                            Container(
                                              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                                              decoration: BoxDecoration(
                                                color: Colors.white.withOpacity(0.22),
                                                borderRadius: BorderRadius.circular(12),
                                              ),
                                              child: const Text(
                                                'Approaching',
                                                style: TextStyle(
                                                  fontSize: 11,
                                                  fontWeight: FontWeight.bold,
                                                  color: Colors.white,
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),

                                        const Divider(color: Colors.white24, height: 24),

                                        // 3 Stat Columns Row
                                        Row(
                                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                                          children: [
                                            _buildHeroStat('ETA', '3 min', Colors.white),
                                            Container(width: 1, height: 24, color: Colors.white24),
                                            _buildHeroStat('Speed', '32 km/h', Colors.white),
                                            Container(width: 1, height: 24, color: Colors.white24),
                                            _buildHeroStat('Delay', 'On Time', const Color(0xFF00E5FF)),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),

                                  const SizedBox(height: 16),

                                  // 2x2 Quick Info Grid Cards
                                  Row(
                                    children: [
                                      Expanded(
                                        child: _buildInfoCard(
                                          icon: Icons.person_outline_rounded,
                                          label: 'Driver',
                                          value: 'Rahul Kumar',
                                        ),
                                      ),
                                      const SizedBox(width: 12),
                                      Expanded(
                                        child: _buildInfoCard(
                                          icon: Icons.location_on_outlined,
                                          label: 'Next Stop',
                                          value: 'Main Station',
                                        ),
                                      ),
                                    ],
                                  ),

                                  const SizedBox(height: 12),

                                  Row(
                                    children: [
                                      Expanded(
                                        child: _buildInfoCard(
                                          icon: Icons.near_me_outlined,
                                          label: 'Distance',
                                          value: '1.2 km',
                                        ),
                                      ),
                                      const SizedBox(width: 12),
                                      Expanded(
                                        child: _buildInfoCard(
                                          icon: Icons.groups_outlined,
                                          label: 'Occupancy',
                                          value: '45%',
                                        ),
                                      ),
                                    ],
                                  ),

                                  const SizedBox(height: 16),

                                  // Current Occupancy Card
                                  Container(
                                    width: double.infinity,
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
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Row(
                                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                          children: [
                                            const Text(
                                              'Current Occupancy',
                                              style: TextStyle(
                                                fontSize: 13,
                                                fontWeight: FontWeight.bold,
                                                color: Color(0xFF0F172A),
                                              ),
                                            ),
                                            Container(
                                              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                                              decoration: BoxDecoration(
                                                color: const Color(0xFFFEF3C7),
                                                borderRadius: BorderRadius.circular(10),
                                              ),
                                              child: const Text(
                                                'Medium 45%',
                                                style: TextStyle(
                                                  fontSize: 10,
                                                  fontWeight: FontWeight.bold,
                                                  color: Color(0xFFD97706),
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),

                                        const SizedBox(height: 12),

                                        // Progress Bar
                                        Container(
                                          height: 10,
                                          width: double.infinity,
                                          decoration: BoxDecoration(
                                            color: const Color(0xFFF1F5F9),
                                            borderRadius: BorderRadius.circular(5),
                                          ),
                                          child: Stack(
                                            children: [
                                              FractionallySizedBox(
                                                widthFactor: 0.45,
                                                child: Container(
                                                  decoration: BoxDecoration(
                                                    gradient: const LinearGradient(
                                                      colors: [
                                                        Color(0xFFF59E0B),
                                                        Color(0xFFD97706),
                                                      ],
                                                    ),
                                                    borderRadius: BorderRadius.circular(5),
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),

                                        const SizedBox(height: 8),

                                        Row(
                                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                          children: const [
                                            Text(
                                              '0 seats',
                                              style: TextStyle(
                                                fontSize: 11,
                                                color: Color(0xFF94A3B8),
                                              ),
                                            ),
                                            Text(
                                              '50 seats',
                                              style: TextStyle(
                                                fontSize: 11,
                                                color: Color(0xFF94A3B8),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),

                                  const SizedBox(height: 20),

                                  // Primary Track Live Action Button
                                  SizedBox(
                                    width: double.infinity,
                                    height: 50,
                                    child: ElevatedButton(
                                      onPressed: () {
                                        Navigator.pushNamed(context, '/passenger/map');
                                      },
                                      style: ElevatedButton.styleFrom(
                                        padding: EdgeInsets.zero,
                                        shape: RoundedRectangleBorder(
                                          borderRadius: BorderRadius.circular(14),
                                        ),
                                        elevation: 4,
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
                                          borderRadius: BorderRadius.circular(14),
                                        ),
                                        child: Container(
                                          alignment: Alignment.center,
                                          child: Row(
                                            mainAxisAlignment: MainAxisAlignment.center,
                                            children: const [
                                              Icon(Icons.map_outlined, color: Colors.white, size: 20),
                                              SizedBox(width: 8),
                                              Text(
                                                'Track Live',
                                                style: TextStyle(
                                                  fontSize: 16,
                                                  fontWeight: FontWeight.bold,
                                                  color: Colors.white,
                                                  letterSpacing: 0.2,
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),

                                  const SizedBox(height: 12),

                                  // Secondary Dual Buttons (Occupancy & AI Suggest)
                                  Row(
                                    children: [
                                      // Occupancy Button
                                      Expanded(
                                        child: OutlinedButton(
                                          onPressed: () {
                                            ScaffoldMessenger.of(context).showSnackBar(
                                              const SnackBar(
                                                content: Text('Occupancy forecast: 22 seats available at next stop.'),
                                                backgroundColor: AppColors.accent,
                                              ),
                                            );
                                          },
                                          style: OutlinedButton.styleFrom(
                                            padding: const EdgeInsets.symmetric(vertical: 12),
                                            backgroundColor: const Color(0xFFECFDF5),
                                            side: const BorderSide(color: Color(0xFFA7F3D0)),
                                            shape: RoundedRectangleBorder(
                                              borderRadius: BorderRadius.circular(14),
                                            ),
                                          ),
                                          child: Row(
                                            mainAxisAlignment: MainAxisAlignment.center,
                                            children: const [
                                              Icon(Icons.groups_outlined, color: Color(0xFF0D9488), size: 18),
                                              SizedBox(width: 6),
                                              Text(
                                                'Occupancy',
                                                style: TextStyle(
                                                  fontSize: 13,
                                                  fontWeight: FontWeight.bold,
                                                  color: Color(0xFF0D9488),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),

                                      const SizedBox(width: 12),

                                      // AI Suggest Button
                                      Expanded(
                                        child: OutlinedButton(
                                          onPressed: () {
                                            Navigator.pushNamed(context, '/passenger/recommendations');
                                          },
                                          style: OutlinedButton.styleFrom(
                                            padding: const EdgeInsets.symmetric(vertical: 12),
                                            backgroundColor: const Color(0xFFEEF2FF),
                                            side: const BorderSide(color: Color(0xFFC7D2FE)),
                                            shape: RoundedRectangleBorder(
                                              borderRadius: BorderRadius.circular(14),
                                            ),
                                          ),
                                          child: Row(
                                            mainAxisAlignment: MainAxisAlignment.center,
                                            children: const [
                                              Icon(Icons.bolt_rounded, color: Color(0xFF2563EB), size: 18),
                                              SizedBox(width: 6),
                                              Text(
                                                'AI Suggest',
                                                style: TextStyle(
                                                  fontSize: 13,
                                                  fontWeight: FontWeight.bold,
                                                  color: Color(0xFF2563EB),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),

                                  const SizedBox(height: 20),
                                ],
                              ),
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

  Widget _buildHeroStat(String label, String value, Color valueColor) {
    return Column(
      children: [
        Text(
          label,
          style: const TextStyle(
            fontSize: 10,
            color: Colors.white70,
          ),
        ),
        const SizedBox(height: 2),
        Text(
          value,
          style: TextStyle(
            fontSize: 15,
            fontWeight: FontWeight.bold,
            color: valueColor,
          ),
        ),
      ],
    );
  }

  Widget _buildInfoCard({
    required IconData icon,
    required String label,
    required String value,
  }) {
    return Container(
      padding: const EdgeInsets.all(12),
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
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(icon, color: const Color(0xFF2563EB), size: 16),
              const SizedBox(width: 6),
              Text(
                label,
                style: const TextStyle(
                  fontSize: 11,
                  color: Color(0xFF94A3B8),
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
          const SizedBox(height: 6),
          Text(
            value,
            style: const TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.bold,
              color: Color(0xFF0F172A),
            ),
          ),
        ],
      ),
    );
  }
}
