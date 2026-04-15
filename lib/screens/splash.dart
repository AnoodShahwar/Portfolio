import 'package:flutter/material.dart';
import 'dart:math' as math;
import '../theme/colors.dart';

class SplashScreen extends StatelessWidget {
  final VoidCallback onScrollDown;
  const SplashScreen({super.key, required this.onScrollDown});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Container(
      width: size.width,
      height: size.height,
      color: kBlack,
      child: Stack(
        alignment: Alignment.center,
        children: [
          Center(
            child: Image.asset(
              'assets/triptych.png',
              width: size.width * 0.85,
              fit: BoxFit.contain,
            ),
          ),

          Positioned(
            top: 2,
            left: 0,
            right: 0,
            child: Text(
              'ANOOD SHAHWAR PRESENTS',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontFamily: 'bankgothic-regular',
                color: kWhite,
                fontSize: size.width * 0.01,
                letterSpacing: 2,
              ),
            ),
          ),

          Positioned(
            top: size.height * 0.40,
            left: 0,
            right: 0,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                OutlinedText(
                  text: 'portfolio',
                  fontFamily: 'Pricedown',
                  fontSize: size.width * 0.07,
                  textColor: kWhite,
                  outlineColor: Colors.black,
                  outlineWidth: 13,
                ),
                const SizedBox(height: 60),
                SizedBox(
                  width: size.width * 0.5,
                  height: size.width * 0.18,
                  child: CustomPaint(
                    painter: CurvedTextPainter(
                      text: '2026',
                      fontFamily: 'OldeEnglish',
                      fontSize: size.width * 0.055,
                      textColor: kWhite,
                      outlineColor: Colors.black,
                      outlineWidth: 6,
                    ),
                  ),
                ),
              ],
            ),
          ),

          Positioned(
            bottom: 40,
            child: GestureDetector(
              onTap: onScrollDown,
              child: Container(
                width: 58,
                height: 52,
                decoration: BoxDecoration(
                  color: Colors.black,
                  border: Border.all(color: Colors.white38, width: 3),
                ),
                child: const Icon(
                  Icons.play_arrow,
                  color: Colors.white54,
                  size: 36,
                ),
              ),
            ),
          ),
          Positioned(
            left: 0,
            right: 0,
            bottom: 4,
            child: Text(
              'Start',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontFamily: 'diploma',
                color: kWhite,
                fontSize: size.width * 0.02,
                letterSpacing: 2,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class OutlinedText extends StatelessWidget {
  final String text;
  final String fontFamily;
  final double fontSize;
  final Color textColor;
  final Color outlineColor;
  final double outlineWidth;

  const OutlinedText({
    super.key,
    required this.text,
    required this.fontFamily,
    required this.fontSize,
    required this.textColor,
    required this.outlineColor,
    required this.outlineWidth,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.center,
      children: [
        // outermost white outline
        Text(
          text,
          textAlign: TextAlign.center,
          style: TextStyle(
            fontFamily: fontFamily,
            fontSize: fontSize,
            fontWeight: FontWeight.bold,
            foreground: Paint()
              ..style = PaintingStyle.stroke
              ..strokeWidth = outlineWidth * 1.2
              ..strokeJoin = StrokeJoin.round
              ..color = Colors.white,
          ),
        ),
        // black outline (middle)
        Text(
          text,
          textAlign: TextAlign.center,
          style: TextStyle(
            fontFamily: fontFamily,
            fontSize: fontSize,
            fontWeight: FontWeight.bold,
            foreground: Paint()
              ..style = PaintingStyle.stroke
              ..strokeWidth = outlineWidth
              ..strokeJoin = StrokeJoin.round
              ..color = Colors.black,
          ),
        ),
        // white fill
        Text(
          text,
          textAlign: TextAlign.center,
          style: TextStyle(
            fontFamily: fontFamily,
            fontSize: fontSize,
            fontWeight: FontWeight.bold,
            color: textColor,
          ),
        ),
      ],
    );
  }
}

class CurvedTextPainter extends CustomPainter {
  final String text;
  final String fontFamily;
  final double fontSize;
  final Color textColor;
  final Color outlineColor;
  final double outlineWidth;

  CurvedTextPainter({
    required this.text,
    required this.fontFamily,
    required this.fontSize,
    required this.textColor,
    required this.outlineColor,
    required this.outlineWidth,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final radius = size.width * 0.72;
    final centerX = size.width / 2;
    final centerY = size.height + radius * 0.35;

    const totalAngle = 0.28;
    final startAngle = -math.pi / 2 - totalAngle / 2;

    // 1. white outer outline
    _drawCurvedText(
      canvas,
      size,
      centerX,
      centerY,
      radius,
      startAngle,
      totalAngle,
      Paint()
        ..color = Colors.white
        ..style = PaintingStyle.stroke
        ..strokeWidth = outlineWidth * 1.2
        ..strokeJoin = StrokeJoin.round,
      asForeground: false,
    );

    // 2. black outline
    _drawCurvedText(
      canvas,
      size,
      centerX,
      centerY,
      radius,
      startAngle,
      totalAngle,
      Paint()
        ..color = outlineColor
        ..style = PaintingStyle.stroke
        ..strokeWidth = outlineWidth
        ..strokeJoin = StrokeJoin.round,
      asForeground: false,
    );

    // 3. white fill
    _drawCurvedText(
      canvas,
      size,
      centerX,
      centerY,
      radius,
      startAngle,
      totalAngle,
      Paint()
        ..color = textColor
        ..style = PaintingStyle.fill,
      asForeground: true,
    );
  }

  void _drawCurvedText(
    Canvas canvas,
    Size size,
    double centerX,
    double centerY,
    double radius,
    double startAngle,
    double totalAngle,
    Paint paint, {
    required bool asForeground,
  }) {
    final chars = text.split('');
    final angleStep = totalAngle / (chars.length - 1);

    for (int i = 0; i < chars.length; i++) {
      final angle = startAngle + i * angleStep;
      final x = centerX + radius * math.cos(angle);
      final y = centerY + radius * math.sin(angle);

      canvas.save();
      canvas.translate(x, y);
      canvas.rotate(angle + math.pi / 2);

      final tp = TextPainter(
        text: TextSpan(
          text: chars[i],
          style: TextStyle(
            fontFamily: fontFamily,
            fontSize: fontSize,
            foreground: asForeground ? null : paint,
            color: asForeground ? textColor : null,
            fontWeight: FontWeight.bold,
          ),
        ),
        textDirection: TextDirection.ltr,
      )..layout();

      tp.paint(canvas, Offset(-tp.width / 2, -tp.height / 2));
      canvas.restore();
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
