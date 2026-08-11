import 'package:flutter/material.dart';

/// A pixel-perfect implementation of the official 4-color Google 'G' Logo
class GoogleLogo extends StatelessWidget {
  final double size;

  const GoogleLogo({super.key, this.size = 22});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: size,
      height: size,
      child: CustomPaint(
        size: Size(size, size),
        painter: _GoogleLogoPainter(),
      ),
    );
  }
}

class _GoogleLogoPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final double scale = size.width / 24.0;
    canvas.scale(scale, scale);

    // 1. Red Segment (#EA4335)
    final redPaint = Paint()
      ..color = const Color(0xFFEA4335)
      ..style = PaintingStyle.fill
      ..isAntiAlias = true;
    final redPath = Path()
      ..moveTo(12.0, 5.0)
      ..cubicTo(13.93, 5.0, 15.68, 5.7, 17.05, 6.85)
      ..lineTo(20.82, 3.08)
      ..cubicTo(18.54, 1.16, 15.46, 0.0, 12.0, 0.0)
      ..cubicTo(7.42, 0.0, 3.49, 2.57, 1.5, 6.33)
      ..lineTo(5.89, 9.74)
      ..cubicTo(6.95, 7.15, 9.27, 5.0, 12.0, 5.0)
      ..close();
    canvas.drawPath(redPath, redPaint);

    // 2. Yellow Segment (#FBBC05)
    final yellowPaint = Paint()
      ..color = const Color(0xFFFBBC05)
      ..style = PaintingStyle.fill
      ..isAntiAlias = true;
    final yellowPath = Path()
      ..moveTo(5.89, 9.74)
      ..cubicTo(5.37, 10.45, 5.08, 11.21, 5.08, 12.0)
      ..cubicTo(5.08, 12.79, 5.37, 13.55, 5.89, 14.26)
      ..lineTo(1.5, 17.67)
      ..cubicTo(0.54, 15.93, 0.0, 14.01, 0.0, 12.0)
      ..cubicTo(0.0, 9.99, 0.54, 8.07, 1.5, 6.33)
      ..lineTo(5.89, 9.74)
      ..close();
    canvas.drawPath(yellowPath, yellowPaint);

    // 3. Green Segment (#34A853)
    final greenPaint = Paint()
      ..color = const Color(0xFF34A853)
      ..style = PaintingStyle.fill
      ..isAntiAlias = true;
    final greenPath = Path()
      ..moveTo(12.0, 19.0)
      ..cubicTo(9.27, 19.0, 6.95, 16.85, 5.89, 14.26)
      ..lineTo(1.5, 17.67)
      ..cubicTo(3.49, 21.43, 7.42, 24.0, 12.0, 24.0)
      ..cubicTo(15.46, 24.0, 18.54, 22.84, 20.82, 20.92)
      ..lineTo(16.08, 17.25)
      ..cubicTo(14.99, 18.39, 13.56, 19.0, 12.0, 19.0)
      ..close();
    canvas.drawPath(greenPath, greenPaint);

    // 4. Blue Segment (#4285F4)
    final bluePaint = Paint()
      ..color = const Color(0xFF4285F4)
      ..style = PaintingStyle.fill
      ..isAntiAlias = true;
    final bluePath = Path()
      ..moveTo(23.49, 12.27)
      ..cubicTo(23.49, 11.42, 23.42, 10.59, 23.27, 9.8)
      ..lineTo(12.0, 9.8)
      ..lineTo(12.0, 14.48)
      ..lineTo(18.44, 14.48)
      ..cubicTo(18.16, 15.95, 17.33, 17.19, 16.08, 18.03)
      ..lineTo(20.21, 21.23)
      ..cubicTo(22.37, 19.23, 23.49, 16.14, 23.49, 12.27)
      ..close();
    canvas.drawPath(bluePath, bluePaint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
