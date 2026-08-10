import 'package:flutter/material.dart';

class LiveMapScreen extends StatefulWidget {
  const LiveMapScreen({super.key});

  @override
  State<LiveMapScreen> createState() => _LiveMapScreenState();
}

class _LiveMapScreenState extends State<LiveMapScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _animController;
  bool _isTracking = true;

  @override
  void initState() {
    super.initState();
    _animController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 4),
    )..repeat(reverse: true);
  }

  @override
  void dispose() {
    _animController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Stack(
          children: [
            // Vector Live Map Custom Painter Canvas (Full Screen)
            Positioned.fill(
              child: AnimatedBuilder(
                animation: _animController,
                builder: (context, child) {
                  return CustomPaint(
                    size: Size.infinite,
                    painter: _LiveMapPainter(
                      animValue: _animController.value,
                    ),
                  );
                },
              ),
            ),

            // Top Header Bar Overlay
            Positioned(
              top: 16,
              left: 16,
              right: 16,
              child: Row(
                children: [
                  // Circular Back Button
                  GestureDetector(
                    onTap: () => Navigator.pop(context),
                    child: Container(
                      width: 44,
                      height: 44,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        shape: BoxShape.circle,
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withValues(alpha: 0.12),
                            blurRadius: 10,
                            offset: const Offset(0, 3),
                          ),
                        ],
                      ),
                      child: const Icon(
                        Icons.arrow_back_rounded,
                        color: Color(0xFF0F172A),
                        size: 22,
                      ),
                    ),
                  ),

                  const SizedBox(width: 12),

                  // Central Bus Info Pill Bar
                  Expanded(
                    child: Container(
                      height: 46,
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(23),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withValues(alpha: 0.12),
                            blurRadius: 10,
                            offset: const Offset(0, 3),
                          ),
                        ],
                      ),
                      child: Row(
                        children: [
                          const Icon(
                            Icons.directions_bus_rounded,
                            color: Color(0xFF2563EB),
                            size: 22,
                          ),
                          const SizedBox(width: 10),
                          const Expanded(
                            child: Text.rich(
                              TextSpan(
                                style: TextStyle(fontSize: 14, color: Color(0xFF0F172A)),
                                children: [
                                  TextSpan(
                                    text: 'Bus 177 ',
                                    style: TextStyle(fontWeight: FontWeight.bold),
                                  ),
                                  TextSpan(
                                    text: '— 3 min away',
                                    style: TextStyle(fontWeight: FontWeight.w500),
                                  ),
                                ],
                              ),
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                          // Green Pulse Live Dot
                          Container(
                            width: 10,
                            height: 10,
                            decoration: const BoxDecoration(
                              color: Color(0xFF22C55E),
                              shape: BoxShape.circle,
                              boxShadow: [
                                BoxShadow(
                                  color: Color(0xFF22C55E),
                                  blurRadius: 6,
                                  spreadRadius: 1,
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),

            // Bottom Floating Sheet Panel
            Positioned(
              left: 0,
              right: 0,
              bottom: 0,
              child: Container(
                padding: const EdgeInsets.all(22),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: const BorderRadius.vertical(
                    top: Radius.circular(28),
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withValues(alpha: 0.14),
                      blurRadius: 24,
                      offset: const Offset(0, -4),
                    ),
                  ],
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    // 3 Stat Cards Row (ETA, Distance, Occupancy)
                    Row(
                      children: [
                        Expanded(
                          child: _buildMapStatCard(
                            value: '3 min',
                            valueColor: const Color(0xFF16A34A),
                            label: 'ETA',
                          ),
                        ),
                        const SizedBox(width: 12),
                        Expanded(
                          child: _buildMapStatCard(
                            value: '1.2 km',
                            valueColor: const Color(0xFF2563EB),
                            label: 'Distance',
                          ),
                        ),
                        const SizedBox(width: 12),
                        Expanded(
                          child: _buildMapStatCard(
                            value: '45%',
                            valueColor: const Color(0xFFD97706),
                            label: 'Occupancy',
                          ),
                        ),
                      ],
                    ),

                    const SizedBox(height: 18),

                    // Start Tracking Primary Button
                    SizedBox(
                      width: double.infinity,
                      height: 52,
                      child: ElevatedButton(
                        onPressed: () {
                          setState(() {
                            _isTracking = !_isTracking;
                          });
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text(
                                _isTracking
                                    ? 'Live GPS tracking active for Bus 177.'
                                    : 'Tracking paused.',
                              ),
                            ),
                          );
                        },
                        style: ElevatedButton.styleFrom(
                          padding: EdgeInsets.zero,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(26),
                          ),
                          elevation: 4,
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
                                Icon(
                                  _isTracking ? Icons.sensors_rounded : Icons.play_arrow_rounded,
                                  color: Colors.white,
                                  size: 22,
                                ),
                                const SizedBox(width: 8),
                                Text(
                                  _isTracking ? 'Start Tracking' : 'Resume Tracking',
                                  style: const TextStyle(
                                    fontSize: 16.5,
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
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildMapStatCard({
    required String value,
    required Color valueColor,
    required String label,
  }) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 14, horizontal: 8),
      decoration: BoxDecoration(
        color: const Color(0xFFF8FAFC),
        borderRadius: BorderRadius.circular(18),
        border: Border.all(color: const Color(0xFFF1F5F9)),
      ),
      child: Column(
        children: [
          Text(
            value,
            style: TextStyle(
              fontSize: 17,
              fontWeight: FontWeight.bold,
              color: valueColor,
            ),
          ),
          const SizedBox(height: 2),
          Text(
            label,
            style: const TextStyle(
              fontSize: 11.5,
              color: Color(0xFF94A3B8),
            ),
          ),
        ],
      ),
    );
  }
}

// Vector Live Map Painter
class _LiveMapPainter extends CustomPainter {
  final double animValue;

  _LiveMapPainter({required this.animValue});

  @override
  void paint(Canvas canvas, Size size) {
    // Background Fill
    final bgPaint = Paint()..color = const Color(0xFFE5EEF8);
    canvas.drawRect(Rect.fromLTWH(0, 0, size.width, size.height), bgPaint);

    // Water River Body at Bottom
    final waterPaint = Paint()..color = const Color(0xFFC7E2FE);
    final waterPath = Path()
      ..moveTo(0, size.height * 0.72)
      ..cubicTo(size.width * 0.3, size.height * 0.70, size.width * 0.7, size.height * 0.74, size.width, size.height * 0.71)
      ..lineTo(size.width, size.height)
      ..lineTo(0, size.height)
      ..close();
    canvas.drawPath(waterPath, waterPaint);

    // City Block Rectangles & Parks
    final blockPaint = Paint()..color = const Color(0xFFCBD5E1);
    final parkPaint = Paint()..color = const Color(0xFFBBF7D0);

    // Blocks
    canvas.drawRRect(RRect.fromRectAndRadius(Rect.fromLTWH(size.width * 0.12, 100, size.width * 0.2, 50), const Radius.circular(6)), blockPaint);
    canvas.drawRRect(RRect.fromRectAndRadius(Rect.fromLTWH(size.width * 0.36, 100, size.width * 0.25, 50), const Radius.circular(6)), blockPaint);
    canvas.drawRRect(RRect.fromRectAndRadius(Rect.fromLTWH(size.width * 0.65, 100, size.width * 0.2, 50), const Radius.circular(6)), blockPaint);

    canvas.drawRRect(RRect.fromRectAndRadius(Rect.fromLTWH(size.width * 0.12, 180, size.width * 0.2, 70), const Radius.circular(6)), blockPaint);
    canvas.drawRRect(RRect.fromRectAndRadius(Rect.fromLTWH(size.width * 0.36, 180, size.width * 0.25, 70), const Radius.circular(6)), blockPaint);
    canvas.drawRRect(RRect.fromRectAndRadius(Rect.fromLTWH(size.width * 0.65, 180, size.width * 0.2, 70), const Radius.circular(6)), blockPaint);

    canvas.drawRRect(RRect.fromRectAndRadius(Rect.fromLTWH(size.width * 0.12, 270, size.width * 0.2, 60), const Radius.circular(6)), blockPaint);
    canvas.drawRRect(RRect.fromRectAndRadius(Rect.fromLTWH(size.width * 0.36, 270, size.width * 0.25, 60), const Radius.circular(6)), blockPaint);

    canvas.drawRRect(RRect.fromRectAndRadius(Rect.fromLTWH(size.width * 0.65, 270, size.width * 0.15, 60), const Radius.circular(6)), parkPaint);

    // Roads Lines
    final roadPaint = Paint()
      ..color = Colors.white
      ..strokeWidth = 18
      ..style = PaintingStyle.stroke;

    final verticalX1 = size.width * 0.08;
    final verticalX2 = size.width * 0.34;
    final verticalX3 = size.width * 0.63;
    final verticalX4 = size.width * 0.88;

    canvas.drawLine(Offset(verticalX1, 0), Offset(verticalX1, size.height * 0.72), roadPaint);
    canvas.drawLine(Offset(verticalX2, 0), Offset(verticalX2, size.height * 0.72), roadPaint);
    canvas.drawLine(Offset(verticalX3, 0), Offset(verticalX3, size.height * 0.72), roadPaint);
    canvas.drawLine(Offset(verticalX4, 0), Offset(verticalX4, size.height * 0.72), roadPaint);

    canvas.drawLine(const Offset(0, 90), Offset(size.width, 90), roadPaint);
    canvas.drawLine(const Offset(0, 165), Offset(size.width, 165), roadPaint);
    canvas.drawLine(const Offset(0, 260), Offset(size.width, 260), roadPaint);

    // Street Names Text
    _drawText(canvas, '177', Offset(verticalX3 - 6, 80), fontSize: 9.5, color: Colors.white70);
    _drawText(canvas, 'Airport', Offset(verticalX3 - 25, 120), fontSize: 9.5, color: const Color(0xFF64748B));
    _drawText(canvas, 'MG Road', Offset(verticalX2 + 10, 158), fontSize: 9.5, color: const Color(0xFF64748B));
    _drawText(canvas, 'FC Road', Offset(verticalX2 + 10, 252), fontSize: 9.5, color: const Color(0xFF64748B));

    // Dotted Route Polyline (Blue)
    final routePaint = Paint()
      ..color = const Color(0xFF2563EB)
      ..strokeWidth = 5.5
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round;

    final routePath = Path()
      ..moveTo(verticalX2, 340)
      ..lineTo(verticalX2, 260)
      ..lineTo(verticalX3, 260)
      ..lineTo(verticalX3, 130);

    _drawDottedPath(canvas, routePath, routePaint);

    // Route Waypoint Rings
    _drawWaypoint(canvas, Offset(verticalX2, 340));
    _drawWaypoint(canvas, Offset(verticalX2, 260));
    _drawWaypoint(canvas, Offset(verticalX3, 260));
    _drawWaypoint(canvas, Offset(verticalX3, 165));
    _drawWaypoint(canvas, Offset(verticalX3, 130));

    // User Location Halo Dot
    final userPaint = Paint()..color = const Color(0xFF2563EB).withValues(alpha: 0.2);
    canvas.drawCircle(Offset(verticalX3, 300), 16, userPaint);
    final userInnerPaint = Paint()..color = const Color(0xFF2563EB);
    canvas.drawCircle(Offset(verticalX3, 300), 8, userInnerPaint);
    final userCenterPaint = Paint()..color = Colors.white;
    canvas.drawCircle(Offset(verticalX3, 300), 3.5, userCenterPaint);

    // Moving Live Bus Marker (Orange Circle)
    final busY = 260.0 - (animValue * 80.0);
    final busPaint = Paint()..color = const Color(0xFFF97316);
    canvas.drawCircle(Offset(verticalX3, busY), 13, busPaint);
    final busBorder = Paint()
      ..color = Colors.white
      ..strokeWidth = 3
      ..style = PaintingStyle.stroke;
    canvas.drawCircle(Offset(verticalX3, busY), 13, busBorder);

    // Destination Pin Marker at Airport
    final pinPaint = Paint()..color = const Color(0xFFEF4444);
    canvas.drawCircle(Offset(verticalX3, 122), 7, pinPaint);
  }

  void _drawWaypoint(Canvas canvas, Offset point) {
    final bgPaint = Paint()..color = Colors.white;
    canvas.drawCircle(point, 8, bgPaint);
    final borderPaint = Paint()
      ..color = const Color(0xFF2563EB)
      ..strokeWidth = 2.5
      ..style = PaintingStyle.stroke;
    canvas.drawCircle(point, 8, borderPaint);
    final innerDot = Paint()..color = const Color(0xFF2563EB);
    canvas.drawCircle(point, 3.5, innerDot);
  }

  void _drawDottedPath(Canvas canvas, Path path, Paint paint) {
    final metrics = path.computeMetrics();
    for (final metric in metrics) {
      double distance = 0.0;
      while (distance < metric.length) {
        final extractPath = metric.extractPath(distance, distance + 7);
        canvas.drawPath(extractPath, paint);
        distance += 13;
      }
    }
  }

  void _drawText(Canvas canvas, String text, Offset offset, {double fontSize = 10, Color color = Colors.black}) {
    final textSpan = TextSpan(
      text: text,
      style: TextStyle(fontSize: fontSize, color: color, fontWeight: FontWeight.w600),
    );
    final textPainter = TextPainter(
      text: textSpan,
      textDirection: TextDirection.ltr,
    );
    textPainter.layout();
    textPainter.paint(canvas, offset);
  }

  @override
  bool shouldRepaint(covariant _LiveMapPainter oldDelegate) {
    return oldDelegate.animValue != animValue;
  }
}
