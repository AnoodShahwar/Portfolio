import 'package:flutter/material.dart';
import '../theme/colors.dart';

class ContactScreen extends StatelessWidget {
  const ContactScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Container(
      width: size.width,
      height: size.height,
      color: kBlack,
      child: const Center(
        child: Text(
          'Contact — coming soon',
          style: TextStyle(color: kGoldDim, fontSize: 16, letterSpacing: 2),
        ),
      ),
    );
  }
}
