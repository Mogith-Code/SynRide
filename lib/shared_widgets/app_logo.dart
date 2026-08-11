import 'package:flutter/material.dart';

class AppLogo extends StatelessWidget {
  final double size;
  final double borderRadius;
  final bool showBackground;
  final Color? backgroundColor;

  const AppLogo({
    super.key,
    this.size = 40,
    this.borderRadius = 10,
    this.showBackground = false,
    this.backgroundColor,
  });

  @override
  Widget build(BuildContext context) {
    Widget image = ClipRRect(
      borderRadius: BorderRadius.circular(borderRadius),
      child: Image.asset(
        'logo.jpg',
        width: size,
        height: size,
        fit: BoxFit.cover,
        errorBuilder: (context, error, stackTrace) {
          return Container(
            width: size,
            height: size,
            decoration: BoxDecoration(
              color: const Color(0xFF2563EB),
              borderRadius: BorderRadius.circular(borderRadius),
            ),
            child: Icon(
              Icons.directions_bus_rounded,
              color: Colors.white,
              size: size * 0.6,
            ),
          );
        },
      ),
    );

    if (showBackground) {
      return Container(
        width: size,
        height: size,
        decoration: BoxDecoration(
          color: backgroundColor ?? Colors.white,
          borderRadius: BorderRadius.circular(borderRadius),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.1),
              blurRadius: 10,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        padding: EdgeInsets.all(size * 0.08),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(borderRadius > 4 ? borderRadius - 4 : 4),
          child: Image.asset(
            'logo.jpg',
            fit: BoxFit.cover,
          ),
        ),
      );
    }

    return image;
  }
}
