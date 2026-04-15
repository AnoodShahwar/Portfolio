import 'package:flutter/material.dart';
import '../theme/colors.dart';

class ContactScreen extends StatelessWidget {
  final VoidCallback onScrollDown;
  const ContactScreen({super.key, required this.onScrollDown});

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
              'Contact — coming soon',
              style: TextStyle(color: kGoldDim, fontSize: 16, letterSpacing: 2),
            ),
          ),
          Positioned(
            bottom: 8,
            left: 0,
            right: 0,
            child: GestureDetector(
              onTap: onScrollDown,
              child: const Padding(
                padding: EdgeInsets.only(left: 40),
                child: Text(
                  'Back',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 28,
                    fontWeight: FontWeight.w900,
                    fontFamily: 'diploma',
                    letterSpacing: 3,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
