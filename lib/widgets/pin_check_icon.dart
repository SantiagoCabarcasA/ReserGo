import 'dart:math' as math;
import 'package:flutter/material.dart';
import '../theme/app_theme.dart';

/// Pin de ubicación (solo contorno) con un chulito adentro.
class PinCheckIcon extends StatelessWidget {
  final double width;
  final double height;
  final Color color;
  final double strokeWidth;

  const PinCheckIcon({
    super.key,
    this.width = 34,
    this.height = 42,
    this.color = AppColors.primary,
    this.strokeWidth = 2,
  });

  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      size: Size(width, height),
      painter: _PinCheckPainter(color, strokeWidth),
    );
  }
}

class _PinCheckPainter extends CustomPainter {
  final Color color;
  final double strokeWidth;

  _PinCheckPainter(this.color, this.strokeWidth);

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = color
      ..style = PaintingStyle.stroke
      ..strokeWidth = strokeWidth
      ..strokeCap = StrokeCap.round
      ..strokeJoin = StrokeJoin.round;

    final w = size.width - strokeWidth;
    final h = size.height - strokeWidth;
    final o = strokeWidth / 2;
    final r = w / 2;
    final cx = o + r;

    // Contorno del pin (sin punto en el centro)
    final pin = Path()
      ..moveTo(cx, o + h)
      ..cubicTo(cx - w * 0.35, o + h * 0.78, o, o + r * 1.55, o, o + r)
      ..arcTo(
        Rect.fromCircle(center: Offset(cx, o + r), radius: r),
        math.pi,
        math.pi,
        false,
      )
      ..cubicTo(o + w, o + r * 1.55, cx + w * 0.35, o + h * 0.78, cx, o + h)
      ..close();
    canvas.drawPath(pin, paint);

    // Chulito
    final center = Offset(cx, o + r);
    final check = Path()
      ..moveTo(center.dx - r * 0.42, center.dy + r * 0.02)
      ..lineTo(center.dx - r * 0.10, center.dy + r * 0.34)
      ..lineTo(center.dx + r * 0.45, center.dy - r * 0.28);
    canvas.drawPath(check, paint);
  }

  @override
  bool shouldRepaint(covariant _PinCheckPainter old) =>
      old.color != color || old.strokeWidth != strokeWidth;
}