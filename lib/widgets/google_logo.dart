import 'package:flutter/material.dart';

/// Logo de Google ("G" con los 4 colores) dibujado a mano.
class GoogleLogo extends StatelessWidget {
  final double size;

  const GoogleLogo({super.key, this.size = 22});

  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      size: Size(size, size),
      painter: _GoogleLogoPainter(),
    );
  }
}

class _GoogleLogoPainter extends CustomPainter {
  static const _blue = Color(0xFF4285F4);
  static const _red = Color(0xFFEA4335);
  static const _yellow = Color(0xFFFBBC05);
  static const _green = Color(0xFF34A853);

  double _rad(double deg) => deg * 3.1415926535 / 180;

  @override
  void paint(Canvas canvas, Size size) {
    final s = size.width;
    final center = Offset(s / 2, s / 2);
    final outerR = s / 2;
    final stroke = s * 0.21;
    final ringR = outerR - stroke / 2;
    final rect = Rect.fromCircle(center: center, radius: ringR);

    Paint arcPaint(Color c) => Paint()
      ..color = c
      ..style = PaintingStyle.stroke
      ..strokeWidth = stroke
      ..strokeCap = StrokeCap.butt;

    // Rojo (arriba), Amarillo (izquierda), Verde (abajo), Azul (derecha)
    canvas.drawArc(rect, _rad(-145), _rad(100), false, arcPaint(_red));
    canvas.drawArc(rect, _rad(145), _rad(70), false, arcPaint(_yellow));
    canvas.drawArc(rect, _rad(45), _rad(100), false, arcPaint(_green));
    canvas.drawArc(rect, _rad(0), _rad(45), false, arcPaint(_blue));

    // Barra horizontal azul de la "G"
    canvas.drawRect(
      Rect.fromLTRB(
        center.dx,
        center.dy - stroke / 2,
        center.dx + outerR,
        center.dy + stroke / 2,
      ),
      Paint()..color = _blue,
    );
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}