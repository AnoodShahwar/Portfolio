import 'package:flutter/material.dart';
import '../theme/colors.dart';

class CertificationsScreen extends StatelessWidget {
  final VoidCallback onScrollDown;
  const CertificationsScreen({super.key, required this.onScrollDown});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Container(
      width: size.width,
      height: size.height,
      color: kBlack,
      child: Stack(
        children: [
          const Center(
            child: Text(
              'Certifications — coming soon',
              style: TextStyle(color: kGoldDim, fontSize: 16, letterSpacing: 2),
            ),
          ),
          Positioned(
            bottom: 20,
            left: 0,
            right: 0,
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
