import 'package:flutter/material.dart';
import '../../../../core/constants/app_colors.dart';
import '../../data/repositories/passenger_repository.dart';
import '../../data/models/bus_model.dart';
import '../widgets/occupancy_indicator_widget.dart';

class LiveMapScreen extends StatefulWidget {
  const LiveMapScreen({super.key});

  @override
  State<LiveMapScreen> createState() => _LiveMapScreenState();
}

class _LiveMapScreenState extends State<LiveMapScreen> {
  final PassengerRepository _repository = PassengerRepository();
  late List<BusModel> _buses;
  late BusModel _selectedBus;

  @override
  void initState() {
    super.initState();
    _buses = _repository.liveBuses;
    _selectedBus = _buses.first;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Live Map • ${_selectedBus.routeNumber}'),
        actions: [
          IconButton(
            icon: const Icon(Icons.my_location_rounded),
            onPressed: () {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Centered on current commuter GPS location')),
              );
            },
          ),
        ],
      ),
      body: Stack(
        children: [
          // Visual Map Simulation Canvas
          Positioned.fill(
            child: Container(
              color: const Color(0xFF0F172A),
              child: CustomPaint(
                painter: _MapCanvasPainter(
                  buses: _buses,
                  selectedBusId: _selectedBus.busId,
                ),
              ),
            ),
          ),

          // Map Control Floating Buttons (Layers / Zoom)
          Positioned(
            top: 20,
            right: 16,
            child: Column(
              children: [
                _buildMapFab(Icons.layers_outlined, () {}),
                const SizedBox(height: 10),
                _buildMapFab(Icons.add, () {}),
                const SizedBox(height: 10),
                _buildMapFab(Icons.remove, () {}),
              ],
            ),
          ),

          // Bottom Sheet Carousel for Selected Bus Info
          Positioned(
            left: 16,
            right: 16,
            bottom: 24,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                // Horizontal Bus Switcher Chips
                SizedBox(
                  height: 36,
                  child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: _buses.length,
                    itemBuilder: (context, index) {
                      final bus = _buses[index];
                      final isSelected = bus.busId == _selectedBus.busId;

                      return GestureDetector(
                        onTap: () => setState(() => _selectedBus = bus),
                        child: Container(
                          margin: const EdgeInsets.only(right: 8),
                          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                          decoration: BoxDecoration(
                            color: isSelected ? AppColors.primary : AppColors.surface,
                            borderRadius: BorderRadius.circular(12),
                            border: Border.all(
                              color: isSelected ? AppColors.primary : AppColors.surfaceLight,
                            ),
                          ),
                          child: Text(
                            '${bus.busId} (${bus.routeNumber})',
                            style: TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.bold,
                              color: isSelected ? Colors.white : AppColors.textPrimary,
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                ),
                const SizedBox(height: 12),

                // Selected Bus Details Floating Card
                Container(
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: AppColors.surface,
                    borderRadius: BorderRadius.circular(20),
                    boxShadow: const [
                      BoxShadow(
                        color: Colors.black54,
                        blurRadius: 16,
                        offset: Offset(0, 8),
                      ),
                    ],
                  ),
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                '${_selectedBus.routeNumber} • ${_selectedBus.busId}',
                                style: const TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                  color: AppColors.primary,
                                ),
                              ),
                              Text(
                                _selectedBus.routeName,
                                style: const TextStyle(fontSize: 12, color: AppColors.textSecondary),
                              ),
                            ],
                          ),
                          OccupancyIndicatorWidget(
                            status: _selectedBus.status,
                            percentage: _selectedBus.occupancyPercentage,
                          ),
                        ],
                      ),
                      const Divider(height: 20, color: AppColors.surfaceLight),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          _buildMapMetric(
                            'Next Stop',
                            _selectedBus.nextStop,
                            Icons.location_on,
                            AppColors.danger,
                          ),
                          _buildMapMetric(
                            'ETA',
                            '${_selectedBus.predictedEtaMinutes} Mins',
                            Icons.timer,
                            AppColors.success,
                          ),
                          _buildMapMetric(
                            'Speed',
                            '${_selectedBus.speedKmh} km/h',
                            Icons.speed,
                            AppColors.accent,
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildMapFab(IconData icon, VoidCallback onTap) {
    return Container(
      decoration: BoxDecoration(
        color: AppColors.surface,
        shape: BoxShape.circle,
        boxShadow: const [BoxShadow(color: Colors.black38, blurRadius: 8)],
      ),
      child: IconButton(
        icon: Icon(icon, color: Colors.white, size: 20),
        onPressed: onTap,
      ),
    );
  }

  Widget _buildMapMetric(String label, String value, IconData icon, Color color) {
    return Row(
      children: [
        Icon(icon, size: 16, color: color),
        const SizedBox(width: 6),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(label, style: const TextStyle(fontSize: 10, color: AppColors.textSecondary)),
            Text(
              value,
              style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold, color: color),
            ),
          ],
        ),
      ],
    );
  }
}

// Custom Painter for Map Simulation Canvas
class _MapCanvasPainter extends CustomPainter {
  final List<BusModel> buses;
  final String selectedBusId;

  _MapCanvasPainter({required this.buses, required this.selectedBusId});

  @override
  void paint(Canvas canvas, Size size) {
    final gridPaint = Paint()
      ..color = const Color(0xFF1E293B)
      ..strokeWidth = 1.0;

    // Draw Grid Lines
    for (double x = 0; x < size.width; x += 40) {
      canvas.drawLine(Offset(x, 0), Offset(x, size.height), gridPaint);
    }
    for (double y = 0; y < size.height; y += 40) {
      canvas.drawLine(Offset(0, y), Offset(size.width, y), gridPaint);
    }

    // Draw Route Polyline Stream
    final routePath = Path();
    routePath.moveTo(size.width * 0.1, size.height * 0.2);
    routePath.cubicTo(
      size.width * 0.4,
      size.height * 0.15,
      size.width * 0.3,
      size.height * 0.5,
      size.width * 0.85,
      size.height * 0.7,
    );

    final polylinePaint = Paint()
      ..color = AppColors.primary.withOpacity(0.6)
      ..strokeWidth = 6.0
      ..style = PaintingStyle.stroke;

    canvas.drawPath(routePath, polylinePaint);

    // Draw Bus Markers along map
    final busPositions = [
      Offset(size.width * 0.25, size.height * 0.28),
      Offset(size.width * 0.45, size.height * 0.42),
      Offset(size.width * 0.70, size.height * 0.62),
    ];

    for (int i = 0; i < buses.length && i < busPositions.length; i++) {
      final bus = buses[i];
      final pos = busPositions[i];
      final isSelected = bus.busId == selectedBusId;

      // Glow circle
      final glowPaint = Paint()
        ..color = isSelected ? AppColors.primary.withOpacity(0.4) : Colors.transparent
        ..maskFilter = const MaskFilter.blur(BlurStyle.normal, 12);
      canvas.drawCircle(pos, 22, glowPaint);

      // Marker Circle
      final markerPaint = Paint()
        ..color = isSelected ? AppColors.primary : AppColors.surfaceLight;
      canvas.drawCircle(pos, 14, markerPaint);

      // Inner Icon dot
      final innerPaint = Paint()..color = Colors.white;
      canvas.drawCircle(pos, 5, innerPaint);
    }
  }

  @override
  bool shouldRepaint(covariant _MapCanvasPainter oldDelegate) => true;
}
