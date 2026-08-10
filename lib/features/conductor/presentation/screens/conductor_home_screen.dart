import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core/constants/app_colors.dart';
import '../../logic/conductor_cubit/conductor_cubit.dart';
import '../../logic/conductor_cubit/conductor_state.dart';
import '../../data/repositories/ticket_repository.dart';

class ConductorHomeScreen extends StatelessWidget {
  const ConductorHomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) =>
          ConductorCubit(repository: TicketRepository())..loadConductorData(),
      child: const _ConductorHomeScreenView(),
    );
  }
}

class _ConductorHomeScreenView extends StatelessWidget {
  const _ConductorHomeScreenView();

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ConductorCubit, ConductorState>(
      listener: (context, state) {
        if (state.message != null) {
          ScaffoldMessenger.of(context).hideCurrentSnackBar();
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(state.message!),
              duration: const Duration(seconds: 2),
              backgroundColor: state is ConductorError
                  ? AppColors.danger
                  : (state is OfflineSyncSuccess
                      ? AppColors.success
                      : AppColors.primary),
            ),
          );
        }
      },
      builder: (context, state) {
        final shift = state.shift;
        final cubit = context.read<ConductorCubit>();

        final int onBoardCount = shift.currentOccupancy;
        final int capacity = shift.totalCapacity;
        final int available = (capacity - onBoardCount).clamp(0, capacity);
        final int occupancyPercent = capacity > 0
            ? ((onBoardCount / capacity) * 100).round()
            : 0;

        return Scaffold(
          backgroundColor: const Color(0xFFF8FAFC),
          body: SafeArea(
            child: Column(
              children: [
                // Top Green Header Section
                _buildGreenHeaderSection(
                  context: context,
                  conductorName: shift.conductorName,
                  busId: shift.busId,
                  routeNumber: shift.routeNumber,
                  state: state,
                  cubit: cubit,
                ),

                // Main Scrollable Dashboard Content
                Expanded(
                  child: SingleChildScrollView(
                    physics: const BouncingScrollPhysics(),
                    padding: const EdgeInsets.symmetric(
                        horizontal: 20.0, vertical: 16.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // 2x2 Metric Cards Grid
                        _buildMetricsGrid(
                          passengersCount: onBoardCount,
                          ticketsIssuedCount:
                              shift.totalTicketsIssued,
                          tripProgressPercent: 50,
                          revenue: shift.totalRevenue,
                        ),

                        const SizedBox(height: 18),

                        // Current Occupancy Card
                        _buildOccupancyCard(
                          context,
                          onBoard: onBoardCount,
                          available: available,
                          capacity: capacity,
                          percent: occupancyPercent,
                        ),

                        const SizedBox(height: 18),

                        // Passenger Flow Today Card
                        _buildPassengerFlowCard(),

                        const SizedBox(height: 20),

                        // Conductor Operations Quick Actions
                        const Text(
                          'Quick Actions',
                          style: TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.bold,
                            color: Color(0xFF0F172A),
                          ),
                        ),
                        const SizedBox(height: 12),

                        // Quick Action Buttons
                        Row(
                          children: [
                            Expanded(
                              child: _buildActionButton(
                                context: context,
                                icon: Icons.confirmation_number_outlined,
                                label: 'Issue Ticket',
                                color: const Color(0xFF10B981),
                                onTap: () => Navigator.pushNamed(
                                    context, '/conductor/issue-ticket'),
                              ),
                            ),
                            const SizedBox(width: 12),
                            Expanded(
                              child: _buildActionButton(
                                context: context,
                                icon: Icons.people_alt_outlined,
                                label: 'Passenger Exit',
                                color: const Color(0xFFEC4899),
                                onTap: () => Navigator.pushNamed(
                                    context, '/conductor/passenger-exit'),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 10),
                        Row(
                          children: [
                            Expanded(
                              child: _buildActionButton(
                                context: context,
                                icon: Icons.directions_bus_outlined,
                                label: 'Trip Summary',
                                color: const Color(0xFF8B5CF6),
                                onTap: () => Navigator.pushNamed(
                                    context, '/conductor/trip-summary'),
                              ),
                            ),
                            const SizedBox(width: 12),
                            Expanded(
                              child: _buildActionButton(
                                context: context,
                                icon: Icons.receipt_long_rounded,
                                label: 'Trip History',
                                color: const Color(0xFF3B82F6),
                                onTap: () => Navigator.pushNamed(
                                    context, '/conductor/history'),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 10),
                        Row(
                          children: [
                            Expanded(
                              child: _buildActionButton(
                                context: context,
                                icon: Icons.badge_outlined,
                                label: 'Waybill & Shift',
                                color: const Color(0xFF8B5CF6),
                                onTap: () => Navigator.pushNamed(
                                    context, '/conductor/shift'),
                              ),
                            ),
                            const SizedBox(width: 12),
                            Expanded(
                              child: _buildActionButton(
                                context: context,
                                icon: Icons.sync_rounded,
                                label: 'Sync Queue',
                                color: const Color(0xFFF59E0B),
                                onTap: () => Navigator.pushNamed(
                                    context,
                                    '/conductor/sync-queue'),
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
        );
      },
    );
  }

  // Top Emerald Green Header Section
  Widget _buildGreenHeaderSection({
    required BuildContext context,
    required String conductorName,
    required String busId,
    required String routeNumber,
    required ConductorState state,
    required ConductorCubit cubit,
  }) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.fromLTRB(20.0, 14.0, 20.0, 20.0),
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            Color(0xFF00E676),
            Color(0xFF10B981),
            Color(0xFF059669),
          ],
        ),
        borderRadius: BorderRadius.vertical(bottom: Radius.circular(24)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Top Mobile Navigation & Status Bar Row
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              IconButton(
                icon: const Icon(Icons.arrow_back_rounded, color: Colors.white),
                onPressed: () => Navigator.pushReplacementNamed(context, '/conductor/login'),
                tooltip: 'Back to Login',
              ),
              const Text(
                'Conductor Dashboard',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Row(
                children: [
                  IconButton(
                    icon: Icon(
                      state.isOnline ? Icons.wifi_rounded : Icons.wifi_off_rounded,
                      color: Colors.white,
                      size: 22,
                    ),
                    tooltip: state.isOnline ? 'Online Mode' : 'Offline Mode',
                    onPressed: () => cubit.toggleOnlineMode(!state.isOnline),
                  ),
                ],
              ),
            ],
          ),
          const SizedBox(height: 12),
          // Greeting & Profile Avatar Row
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Good Morning',
                    style: TextStyle(
                      color: Colors.white70,
                      fontSize: 13,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  const SizedBox(height: 2),
                  Text(
                    'Conductor $conductorName',
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      letterSpacing: -0.2,
                    ),
                  ),
                ],
              ),

              // Profile Avatar Icon Button
              GestureDetector(
                onTap: () => Navigator.pushNamed(context, '/conductor/shift'),
                child: Container(
                  width: 42,
                  height: 42,
                  decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.25),
                    shape: BoxShape.circle,
                    border: Border.all(
                      color: Colors.white.withOpacity(0.3),
                      width: 1.5,
                    ),
                  ),
                  child: const Icon(
                    Icons.person_outline_rounded,
                    color: Colors.white,
                    size: 24,
                  ),
                ),
              ),
            ],
          ),

          const SizedBox(height: 16),

          // Active Bus Status Banner Card
          GestureDetector(
            onTap: () => Navigator.pushNamed(context, '/conductor/trip-summary'),
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
              decoration: BoxDecoration(
                color: Colors.white.withOpacity(0.18),
                borderRadius: BorderRadius.circular(16),
                border: Border.all(
                  color: Colors.white.withOpacity(0.25),
                ),
              ),
              child: Row(
                children: [
                  // Bus Icon Square Badge
                  Container(
                    width: 36,
                    height: 36,
                    decoration: BoxDecoration(
                      color: Colors.white.withOpacity(0.2),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: const Icon(
                      Icons.directions_bus_rounded,
                      color: Colors.white,
                      size: 20,
                    ),
                  ),
                  const SizedBox(width: 12),

                  // Bus Info
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          busId,
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 15,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 2),
                        const Text(
                          'City Center → Airport · Trip #3',
                          style: TextStyle(
                            color: Colors.white70,
                            fontSize: 11.5,
                            fontWeight: FontWeight.w400,
                          ),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ],
                    ),
                  ),

                // Right Status: On Time & 08:05 AM
                Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: const [
                    Text(
                      'On Time',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 13,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 2),
                    Text(
                      '08:05 AM',
                      style: TextStyle(
                        color: Colors.white70,
                        fontSize: 11,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ],
    ),
  );
  }

  // 2x2 Metric Cards Grid
  Widget _buildMetricsGrid({
    required int passengersCount,
    required int ticketsIssuedCount,
    required int tripProgressPercent,
    required double revenue,
  }) {
    return Column(
      children: [
        Row(
          children: [
            Expanded(
              child: _buildMetricCard(
                icon: Icons.people_alt_outlined,
                iconBgColor: const Color(0xFFEFF6FF),
                iconColor: const Color(0xFF3B82F6),
                value: '$passengersCount',
                label: 'Passengers',
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: _buildMetricCard(
                icon: Icons.local_activity_outlined,
                iconBgColor: const Color(0xFFECFDF5),
                iconColor: const Color(0xFF10B981),
                value: '$ticketsIssuedCount',
                label: 'Tickets Issued',
              ),
            ),
          ],
        ),
        const SizedBox(height: 12),
        Row(
          children: [
            Expanded(
              child: _buildMetricCard(
                icon: Icons.alt_route_rounded,
                iconBgColor: const Color(0xFFFFFBEB),
                iconColor: const Color(0xFFF59E0B),
                value: '$tripProgressPercent%',
                label: 'Trip Progress',
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: _buildMetricCard(
                icon: Icons.payments_outlined,
                iconBgColor: const Color(0xFFECFDF5),
                iconColor: const Color(0xFF10B981),
                value: '₹${revenue.toStringAsFixed(0)}',
                label: 'Revenue',
              ),
            ),
          ],
        ),
      ],
    );
  }

  // Individual Metric Card Widget
  Widget _buildMetricCard({
    required IconData icon,
    required Color iconBgColor,
    required Color iconColor,
    required String value,
    required String label,
  }) {
    return Container(
      padding: const EdgeInsets.all(16.0),
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
          Container(
            width: 36,
            height: 36,
            decoration: BoxDecoration(
              color: iconBgColor,
              shape: BoxShape.circle,
            ),
            child: Icon(icon, color: iconColor, size: 20),
          ),
          const SizedBox(height: 12),
          Text(
            value,
            style: const TextStyle(
              fontSize: 22,
              fontWeight: FontWeight.bold,
              color: Color(0xFF0F172A),
              letterSpacing: -0.5,
            ),
          ),
          const SizedBox(height: 2),
          Text(
            label,
            style: const TextStyle(
              fontSize: 12.5,
              fontWeight: FontWeight.w500,
              color: Color(0xFF94A3B8),
            ),
          ),
        ],
      ),
    );
  }

  // Current Occupancy Card Widget
  Widget _buildOccupancyCard(
    BuildContext context, {
    required int onBoard,
    required int available,
    required int capacity,
    required int percent,
  }) {
    return InkWell(
      onTap: () => Navigator.pushNamed(context, '/conductor/passenger-exit'),
      borderRadius: BorderRadius.circular(20),
      child: Container(
        padding: const EdgeInsets.all(18.0),
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
            // Header & Medium Occupancy Pill Badge
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: const [
                    Text(
                      'Current Occupancy',
                      style: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.bold,
                        color: Color(0xFF0F172A),
                      ),
                    ),
                    SizedBox(width: 6),
                    Icon(
                      Icons.touch_app_outlined,
                      size: 16,
                      color: Color(0xFF10B981),
                    ),
                  ],
                ),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                  decoration: BoxDecoration(
                    color: const Color(0xFFFEF3C7),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Text(
                    'Medium $percent%',
                    style: const TextStyle(
                      fontSize: 11.5,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFFD97706),
                    ),
                  ),
                ),
              ],
            ),

          const SizedBox(height: 16),

          // Gauge & Breakdown Row
          Row(
            children: [
              // Ring Gauge Meter
              SizedBox(
                width: 86,
                height: 86,
                child: Stack(
                  alignment: Alignment.center,
                  children: [
                    SizedBox(
                      width: 86,
                      height: 86,
                      child: CircularProgressIndicator(
                        value: (percent / 100).clamp(0.0, 1.0),
                        strokeWidth: 9,
                        backgroundColor: const Color(0xFFF1F5F9),
                        valueColor: const AlwaysStoppedAnimation<Color>(
                          Color(0xFFF59E0B),
                        ),
                        strokeCap: StrokeCap.round,
                      ),
                    ),
                    Text(
                      '$percent%',
                      style: const TextStyle(
                        fontSize: 17,
                        fontWeight: FontWeight.bold,
                        color: Color(0xFF0F172A),
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(width: 24),

              // Occupancy Breakdown List
              Expanded(
                child: Column(
                  children: [
                    _buildOccupancyDetailRow('On board', '$onBoard'),
                    const SizedBox(height: 6),
                    _buildOccupancyDetailRow('Available', '$available'),
                    const SizedBox(height: 6),
                    _buildOccupancyDetailRow('Capacity', '$capacity'),
                  ],
                ),
              ),
            ],
          ),

          const SizedBox(height: 16),

          // Bottom Bar Progress Indicator
          ClipRRect(
            borderRadius: BorderRadius.circular(6),
            child: LinearProgressIndicator(
              value: (percent / 100).clamp(0.0, 1.0),
              minHeight: 8,
              backgroundColor: const Color(0xFFF1F5F9),
              valueColor: const AlwaysStoppedAnimation<Color>(
                Color(0xFFF59E0B),
              ),
            ),
          ),
        ],
      ),
    ),
  );
}

  Widget _buildOccupancyDetailRow(String label, String value) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          label,
          style: const TextStyle(
            fontSize: 13,
            color: Color(0xFF64748B),
            fontWeight: FontWeight.w500,
          ),
        ),
        Text(
          value,
          style: const TextStyle(
            fontSize: 13.5,
            fontWeight: FontWeight.bold,
            color: Color(0xFF0F172A),
          ),
        ),
      ],
    );
  }

  // Passenger Flow Today Card Widget
  Widget _buildPassengerFlowCard() {
    return Container(
      padding: const EdgeInsets.all(18.0),
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
            'Passenger Flow Today',
            style: TextStyle(
              fontSize: 15,
              fontWeight: FontWeight.bold,
              color: Color(0xFF0F172A),
            ),
          ),

          const SizedBox(height: 16),

          // Wave Graph Painter
          SizedBox(
            height: 60,
            width: double.infinity,
            child: CustomPaint(
              painter: _PassengerFlowCurvePainter(),
            ),
          ),

          const SizedBox(height: 12),

          // Time Labels
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: const [
              Text('8AM', style: TextStyle(fontSize: 10.5, color: Color(0xFF94A3B8))),
              Text('9AM', style: TextStyle(fontSize: 10.5, color: Color(0xFF94A3B8))),
              Text('10AM', style: TextStyle(fontSize: 10.5, color: Color(0xFF94A3B8))),
              Text('11AM', style: TextStyle(fontSize: 10.5, color: Color(0xFF94A3B8))),
              Text('12PM', style: TextStyle(fontSize: 10.5, color: Color(0xFF94A3B8))),
              Text('1PM', style: TextStyle(fontSize: 10.5, color: Color(0xFF94A3B8))),
              Text('2PM', style: TextStyle(fontSize: 10.5, color: Color(0xFF94A3B8))),
            ],
          ),
        ],
      ),
    );
  }

  // Quick Operations Action Button Widget
  Widget _buildActionButton({
    required BuildContext context,
    required IconData icon,
    required String label,
    required Color color,
    required VoidCallback onTap,
  }) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(14),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(14),
          border: Border.all(color: const Color(0xFFE2E8F0)),
        ),
        child: Row(
          children: [
            Container(
              padding: const EdgeInsets.all(6),
              decoration: BoxDecoration(
                color: color.withOpacity(0.12),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Icon(icon, color: color, size: 18),
            ),
            const SizedBox(width: 8),
            Expanded(
              child: Text(
                label,
                style: const TextStyle(
                  fontSize: 12.5,
                  fontWeight: FontWeight.w600,
                  color: Color(0xFF1E293B),
                ),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// Custom Painter for Smooth Wave Chart
class _PassengerFlowCurvePainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final path = Path();
    final points = [
      Offset(0, size.height * 0.75),
      Offset(size.width * 0.16, size.height * 0.45),
      Offset(size.width * 0.33, size.height * 0.2),
      Offset(size.width * 0.5, size.height * 0.4),
      Offset(size.width * 0.66, size.height * 0.7),
      Offset(size.width * 0.83, size.height * 0.25),
      Offset(size.width, size.height * 0.4),
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
          const Color(0xFF10B981).withOpacity(0.3),
          const Color(0xFF10B981).withOpacity(0.0),
        ],
      ).createShader(Rect.fromLTWH(0, 0, size.width, size.height));

    canvas.drawPath(fillPath, fillPaint);

    // Stroke Line
    final linePaint = Paint()
      ..color = const Color(0xFF10B981)
      ..strokeWidth = 2.5
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round;

    canvas.drawPath(path, linePaint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
