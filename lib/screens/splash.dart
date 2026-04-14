import 'package:flutter/material.dart';
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

          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'Portfolio',
                style: TextStyle(
                  fontFamily: 'Pricedown',
                  fontSize: size.width * 0.09,
                  color: kWhite,
                  fontWeight: FontWeight.bold,
                  shadows: const [
                    Shadow(
                      offset: Offset(4, 4),
                      color: Colors.black,
                      blurRadius: 0,
                    ),
                    Shadow(
                      offset: Offset(-1, -1),
                      color: Colors.black,
                      blurRadius: 0,
                    ),
                  ],
                ),
              ),
              Text(
                '2026',
                style: TextStyle(
                  fontFamily: 'Pricedown',
                  fontSize: size.width * 0.045,
                  color: kGold,
                  letterSpacing: 8,
                  shadows: const [
                    Shadow(
                      offset: Offset(2, 2),
                      color: Colors.black,
                      blurRadius: 0,
                    ),
                  ],
                ),
              ),
            ],
          ),

          Positioned(
            bottom: 32,
            child: GestureDetector(
              onTap: onScrollDown,
              child: const Column(
                children: [
                  Text(
                    'scroll down',
                    style: TextStyle(
                      color: Color(0x66F5A623),
                      fontSize: 11,
                      letterSpacing: 3,
                    ),
                  ),
                  SizedBox(height: 6),
                  Icon(
                    Icons.keyboard_arrow_down,
                    color: Color(0x66F5A623),
                    size: 20,
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
