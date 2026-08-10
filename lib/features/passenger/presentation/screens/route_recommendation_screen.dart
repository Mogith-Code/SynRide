import 'package:flutter/material.dart';
import '../../../../core/constants/app_colors.dart';

class RouteRecommendationScreen extends StatelessWidget {
  const RouteRecommendationScreen({super.key});

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

                          // Top Internal Screen App Bar
                          Container(
                            padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
                            color: Colors.white,
                            child: Row(
                              children: [
                                IconButton(
                                  icon: const Icon(Icons.arrow_back_rounded, color: Color(0xFF0F172A)),
                                  onPressed: () => Navigator.pop(context),
                                ),
                                const Expanded(
                                  child: Text(
                                    'AI Recommendation',
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold,
                                      color: Color(0xFF0F172A),
                                    ),
                                  ),
                                ),
                                const SizedBox(width: 40), // Balance title centering
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
                                  // Top AI Gradient Banner Card
                                  Container(
                                    width: double.infinity,
                                    padding: const EdgeInsets.all(18),
                                    decoration: BoxDecoration(
                                      gradient: const LinearGradient(
                                        begin: Alignment.topLeft,
                                        end: Alignment.bottomRight,
                                        colors: [
                                          Color(0xFF1D4ED8),
                                          Color(0xFF0EA5E9),
                                          Color(0xFF0D9488),
                                        ],
                                      ),
                                      borderRadius: BorderRadius.circular(22),
                                      boxShadow: [
                                        BoxShadow(
                                          color: const Color(0xFF0EA5E9).withOpacity(0.3),
                                          blurRadius: 16,
                                          offset: const Offset(0, 6),
                                        ),
                                      ],
                                    ),
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Row(
                                          children: [
                                            Container(
                                              padding: const EdgeInsets.all(7),
                                              decoration: BoxDecoration(
                                                color: Colors.white.withOpacity(0.2),
                                                borderRadius: BorderRadius.circular(10),
                                              ),
                                              child: const Icon(
                                                Icons.memory_rounded,
                                                color: Colors.white,
                                                size: 20,
                                              ),
                                            ),
                                            const SizedBox(width: 10),
                                            Column(
                                              crossAxisAlignment: CrossAxisAlignment.start,
                                              children: const [
                                                Text(
                                                  'AI Analysis Complete',
                                                  style: TextStyle(
                                                    fontSize: 15,
                                                    fontWeight: FontWeight.bold,
                                                    color: Colors.white,
                                                  ),
                                                ),
                                                Text(
                                                  'Based on real-time data',
                                                  style: TextStyle(
                                                    fontSize: 11,
                                                    color: Colors.white70,
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ],
                                        ),

                                        const SizedBox(height: 14),

                                        // Quote Box inside Banner
                                        Container(
                                          width: double.infinity,
                                          padding: const EdgeInsets.all(12),
                                          decoration: BoxDecoration(
                                            color: Colors.white.withOpacity(0.16),
                                            borderRadius: BorderRadius.circular(14),
                                            border: Border.all(
                                              color: Colors.white.withOpacity(0.2),
                                            ),
                                          ),
                                          child: const Text(
                                            '"Bus 177 is less crowded and will save approximately 8 minutes compared to your usual route."',
                                            style: TextStyle(
                                              fontSize: 12.5,
                                              fontStyle: FontStyle.italic,
                                              color: Colors.white,
                                              height: 1.4,
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),

                                  const SizedBox(height: 20),

                                  // BEST OPTION Section Label
                                  Row(
                                    children: const [
                                      Text(
                                        '⭐ ',
                                        style: TextStyle(fontSize: 11),
                                      ),
                                      Text(
                                        'BEST OPTION',
                                        style: TextStyle(
                                          fontSize: 11,
                                          fontWeight: FontWeight.bold,
                                          color: Color(0xFF94A3B8),
                                          letterSpacing: 0.6,
                                        ),
                                      ),
                                    ],
                                  ),

                                  const SizedBox(height: 10),

                                  // Main Best Option Card (Bus 177)
                                  Container(
                                    padding: const EdgeInsets.all(16),
                                    decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius: BorderRadius.circular(20),
                                      border: Border.all(
                                        color: const Color(0xFF2563EB),
                                        width: 1.5,
                                      ),
                                      boxShadow: [
                                        BoxShadow(
                                          color: const Color(0xFF2563EB).withOpacity(0.08),
                                          blurRadius: 14,
                                          offset: const Offset(0, 4),
                                        ),
                                      ],
                                    ),
                                    child: Column(
                                      children: [
                                        // Top Row inside Bus 177 Card
                                        Row(
                                          children: [
                                            Container(
                                              width: 44,
                                              height: 44,
                                              decoration: BoxDecoration(
                                                gradient: const LinearGradient(
                                                  colors: [
                                                    Color(0xFF0072FF),
                                                    Color(0xFF00C6FF),
                                                  ],
                                                ),
                                                borderRadius: BorderRadius.circular(14),
                                              ),
                                              child: const Icon(
                                                Icons.directions_bus_rounded,
                                                color: Colors.white,
                                                size: 24,
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
                                                      color: Color(0xFF0F172A),
                                                    ),
                                                  ),
                                                  SizedBox(height: 2),
                                                  Text(
                                                    'City Center → Airport',
                                                    style: TextStyle(
                                                      fontSize: 12,
                                                      color: Color(0xFF64748B),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),

                                            // Score display
                                            Column(
                                              crossAxisAlignment: CrossAxisAlignment.end,
                                              children: [
                                                Row(
                                                  crossAxisAlignment: CrossAxisAlignment.baseline,
                                                  textBaseline: TextBaseline.alphabetic,
                                                  children: const [
                                                    Text(
                                                      '94',
                                                      style: TextStyle(
                                                        fontSize: 22,
                                                        fontWeight: FontWeight.bold,
                                                        color: Color(0xFF16A34A),
                                                      ),
                                                    ),
                                                    Text(
                                                      ' /100',
                                                      style: TextStyle(
                                                        fontSize: 12,
                                                        color: Color(0xFF94A3B8),
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                                const SizedBox(height: 1),
                                                const Text(
                                                  'AI Score',
                                                  style: TextStyle(
                                                    fontSize: 10,
                                                    fontWeight: FontWeight.bold,
                                                    color: Color(0xFF16A34A),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ],
                                        ),

                                        const SizedBox(height: 16),

                                        // 3 Metric Pills Row
                                        Row(
                                          children: [
                                            Expanded(
                                              child: _buildMetricPill(
                                                icon: Icons.access_time_rounded,
                                                value: '3 min',
                                                label: 'ETA',
                                              ),
                                            ),
                                            const SizedBox(width: 8),
                                            Expanded(
                                              child: _buildMetricPill(
                                                icon: Icons.groups_outlined,
                                                value: '45%',
                                                label: 'Crowd',
                                              ),
                                            ),
                                            const SizedBox(width: 8),
                                            Expanded(
                                              child: _buildMetricPill(
                                                icon: Icons.trending_up_rounded,
                                                value: '8 min',
                                                label: 'Saves',
                                              ),
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),

                                  const SizedBox(height: 20),

                                  // ALTERNATIVE OPTIONS Label
                                  const Text(
                                    'ALTERNATIVE OPTIONS',
                                    style: TextStyle(
                                      fontSize: 11,
                                      fontWeight: FontWeight.bold,
                                      color: Color(0xFF94A3B8),
                                      letterSpacing: 0.6,
                                    ),
                                  ),

                                  const SizedBox(height: 10),

                                  // Alternative 1: Bus 203
                                  _buildAlternativeCard(
                                    busNumber: 'Bus 203',
                                    details: '8 min · 78% full',
                                    score: '78',
                                    onTap: () => Navigator.pushNamed(context, '/passenger/bus-details'),
                                  ),
                                  const SizedBox(height: 8),

                                  // Alternative 2: Bus 215
                                  _buildAlternativeCard(
                                    busNumber: 'Bus 215',
                                    details: '15 min · 35% full',
                                    score: '72',
                                    onTap: () => Navigator.pushNamed(context, '/passenger/bus-details'),
                                  ),

                                  const SizedBox(height: 20),

                                  // Why Bus 177? Card
                                  Container(
                                    width: double.infinity,
                                    padding: const EdgeInsets.all(18),
                                    decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius: BorderRadius.circular(20),
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
                                        const Text(
                                          'Why Bus 177?',
                                          style: TextStyle(
                                            fontSize: 15,
                                            fontWeight: FontWeight.bold,
                                            color: Color(0xFF0F172A),
                                          ),
                                        ),
                                        const SizedBox(height: 14),

                                        _buildReasonBullet(
                                          icon: Icons.groups_outlined,
                                          text: 'Lowest occupancy (45%) among all options',
                                        ),
                                        const SizedBox(height: 10),
                                        _buildReasonBullet(
                                          icon: Icons.access_time_rounded,
                                          text: 'Saves 8 minutes vs current traffic',
                                        ),
                                        const SizedBox(height: 10),
                                        _buildReasonBullet(
                                          icon: Icons.verified_outlined,
                                          text: '98% on-time record for this route',
                                        ),
                                        const SizedBox(height: 10),
                                        _buildReasonBullet(
                                          icon: Icons.eco_outlined,
                                          text: 'Saves 0.4 kg CO₂ vs driving',
                                        ),
                                      ],
                                    ),
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

  Widget _buildMetricPill({
    required IconData icon,
    required String value,
    required String label,
  }) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 8),
      decoration: BoxDecoration(
        color: const Color(0xFFF8FAFC),
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: const Color(0xFFF1F5F9)),
      ),
      child: Column(
        children: [
          Icon(icon, color: const Color(0xFF2563EB), size: 18),
          const SizedBox(height: 4),
          Text(
            value,
            style: const TextStyle(
              fontSize: 13,
              fontWeight: FontWeight.bold,
              color: Color(0xFF0F172A),
            ),
          ),
          const SizedBox(height: 1),
          Text(
            label,
            style: const TextStyle(
              fontSize: 10,
              color: Color(0xFF94A3B8),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildAlternativeCard({
    required String busNumber,
    required String details,
    required String score,
    required VoidCallback onTap,
  }) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: const Color(0xFFF1F5F9)),
      ),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(16),
        child: Row(
          children: [
            Container(
              width: 38,
              height: 38,
              decoration: BoxDecoration(
                color: const Color(0xFFE0F2FE),
                borderRadius: BorderRadius.circular(12),
              ),
              child: const Icon(
                Icons.directions_bus_rounded,
                color: Color(0xFF0284C7),
                size: 20,
              ),
            ),
            const SizedBox(width: 12),
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
                    details,
                    style: const TextStyle(
                      fontSize: 11,
                      color: Color(0xFF64748B),
                    ),
                  ),
                ],
              ),
            ),
            Row(
              crossAxisAlignment: Cross baseline,
              textBaseline: TextBaseline.alphabetic,
              children: [
                Text(
                  score,
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF475569),
                  ),
                ),
                const Text(
                  ' /100',
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
    );
  }

  Widget _buildReasonBullet({
    required IconData icon,
    required String text,
  }) {
    return Row(
      children: [
        Icon(icon, color: const Color(0xFF16A34A), size: 18),
        const SizedBox(width: 10),
        Expanded(
          child: Text(
            text,
            style: const TextStyle(
              fontSize: 12.5,
              color: Color(0xFF334155),
              fontWeight: FontWeight.w400,
            ),
          ),
        ),
      ],
    );
  }
}
