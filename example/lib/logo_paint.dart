import 'package:flutter/material.dart';

///
class YazLogo extends StatelessWidget {
  ///
  const YazLogo({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Container(
        width: double.infinity,
        height: double.infinity,
        padding: const EdgeInsets.all(30),
        alignment: Alignment.center,
        child: AspectRatio(
          aspectRatio: _YazLogoPainter._aspect,
          child: CustomPaint(
            painter: _YazLogoPainter(),
            child: Container(
              width: double.infinity,
              height: double.infinity,
            ),
          ),
        ),
      ),
    );
  }
}

///
class _YazLogoPainter extends CustomPainter {
  static final double _aspect = 0.7619047619047619;

  @override
  void paint(Canvas canvas, Size size) {
    var h = size.height;
    var w = size.width;
    var topLeftPath = Path()
      ..moveTo(0, 0)
      ..lineTo(0, h / 3)
      ..lineTo(w / 4, h / 2)
      ..lineTo(w / 2, h / 3)
      ..close();
    var topRightPath = Path()
      ..moveTo(w, 0)
      ..lineTo(w, h / 3)
      ..lineTo(w / 4 * 3, h / 2)
      ..lineTo(w / 2, h / 3)
      ..close();

    var centerRect = Path()
      ..moveTo(w / 2, h / 3)
      ..lineTo(w / 4, h / 2)

      /// to bottom
      ..lineTo(w / 2, h * 2 / 3)
      ..lineTo(w * 3 / 4, h / 2)
      ..close();

    var bottomPath = Path()
      ..moveTo(w / 4, h / 2)
      ..lineTo(w / 4, h / 3 * 2)
      ..lineTo(w * 3 / 4, h)
      ..lineTo(w * 3 / 4, h)
      ..lineTo(w * 3 / 4, h / 2);

    var topLeftPaint = Paint()
      ..color = const Color(0xFF54c5f8)
      ..style = PaintingStyle.fill;
    var topRightPaint = Paint()
      ..color = const Color(0xFF01579b)
      ..style = PaintingStyle.fill;

    var bottomPaint = Paint()
      ..color = const Color(0xFF2596c9).withOpacity(0.8)
      ..style = PaintingStyle.fill;
    var centerRectPaint = Paint()
      ..color = const Color(0xFF29b6f6)
      ..style = PaintingStyle.fill;

    canvas
      ..drawPath(topLeftPath, topRightPaint)
      ..drawPath(topRightPath, topLeftPaint)
      ..drawPath(bottomPath, bottomPaint)
      ..drawPath(centerRect, centerRectPaint);
  }

  @override
  bool shouldRepaint(_YazLogoPainter oldDelegate) => true;

  @override
  bool shouldRebuildSemantics(_YazLogoPainter oldDelegate) => true;
}
