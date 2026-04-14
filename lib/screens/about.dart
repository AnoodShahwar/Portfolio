import 'package:flutter/material.dart';
import '../theme/colors.dart';

class AboutScreen extends StatelessWidget {
  final VoidCallback onScrollDown;
  const AboutScreen({super.key, required this.onScrollDown});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final isWide = size.width > 700;

    return Container(
      width: size.width,
      height: size.height,
      color: kBlack,
      child: Stack(
        children: [
          // gold vertical divider
          Positioned(
            left: size.width * 0.45,
            top: size.height * 0.08,
            bottom: size.height * 0.1,
            child: Container(width: 1, color: kGoldFaint),
          ),

          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // ── LEFT ──
              SizedBox(
                width: size.width * 0.45,
                height: size.height,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(height: size.height * 0.07),

                    Padding(
                      padding: const EdgeInsets.only(left: 28),
                      child: RichText(
                        text: TextSpan(
                          children: [
                            TextSpan(
                              text: 'About ',
                              style: TextStyle(
                                fontFamily: 'Pricedown',
                                fontSize: isWide
                                    ? size.width * 0.055
                                    : size.width * 0.07,
                                color: kGold,
                              ),
                            ),
                            TextSpan(
                              text: 'Me.',
                              style: TextStyle(
                                fontFamily: 'Pricedown',
                                fontSize: isWide
                                    ? size.width * 0.055
                                    : size.width * 0.07,
                                color: kWhite,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),

                    SizedBox(height: size.height * 0.04),

                    // photo placeholder
                    Padding(
                      padding: const EdgeInsets.only(left: 28),
                      child: Container(
                        width: size.width * 0.34,
                        height: size.height * 0.52,
                        decoration: BoxDecoration(
                          border: Border.all(color: kGoldFaint, width: 1),
                        ),
                        child: Image.network(
                          'https://images.unsplash.com/photo-1529626455594-4ff0802cfb7e?w=400&q=80',
                          fit: BoxFit.cover,
                          errorBuilder: (context, error, stackTrace) =>
                              const Center(
                                child: Icon(
                                  Icons.person,
                                  color: Color(0x44F5A623),
                                  size: 60,
                                ),
                              ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),

              // ── RIGHT ──
              Expanded(
                child: Padding(
                  padding: EdgeInsets.fromLTRB(
                    size.width * 0.05,
                    size.height * 0.07,
                    28,
                    0,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        '— PLAYER FILE —',
                        style: TextStyle(
                          color: kGoldDim,
                          fontSize: 11,
                          letterSpacing: 3,
                        ),
                      ),

                      const SizedBox(height: 12),

                      const Text(
                        'Anood Shahwar',
                        style: TextStyle(
                          fontFamily: 'Pricedown',
                          fontSize: 46,
                          color: kWhite,
                          height: 1.0,
                        ),
                      ),

                      const SizedBox(height: 6),

                      const Text(
                        'Flutter Developer · CS Student · Game Dev',
                        style: TextStyle(
                          color: kGold,
                          fontSize: 13,
                          letterSpacing: 1,
                        ),
                      ),

                      const SizedBox(height: 20),

                      Container(height: 1, width: 50, color: kGoldFaint),

                      const SizedBox(height: 20),

                      _statRow('Location', 'Karachi, Pakistan'),
                      _statRow('University', 'UBIT — 5th Semester'),
                      _statRow('Main mission', 'Flutter Internship 2025'),
                      _statRow('Side mission', 'Game Dev — Unity & C#'),
                      _statRow('GitHub', 'AnoodShahwar'),

                      const SizedBox(height: 24),

                      const Text(
                        '5th semester CS student building real things.\n'
                        'Flutter by day, Unity by night.\n'
                        'On a mission to ship apps that actually matter.',
                        style: TextStyle(
                          color: kWhiteFaint,
                          fontSize: 14,
                          height: 1.8,
                          letterSpacing: 0.3,
                        ),
                      ),

                      const SizedBox(height: 28),

                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 14,
                          vertical: 8,
                        ),
                        decoration: BoxDecoration(
                          border: Border.all(color: kGreen, width: 1),
                          color: const Color(0x114aaa6a),
                        ),
                        child: const Text(
                          'AVAILABLE FOR HIRE',
                          style: TextStyle(
                            color: kGreen,
                            fontSize: 12,
                            letterSpacing: 2,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),

          // scroll hint
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

  Widget _statRow(String key, String value) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 100,
            child: Text(
              key.toUpperCase(),
              style: const TextStyle(
                color: kGoldDim,
                fontSize: 10,
                letterSpacing: 1.5,
              ),
            ),
          ),
          Expanded(
            child: Text(
              value,
              style: const TextStyle(
                color: kWhiteDim,
                fontSize: 13,
                letterSpacing: 0.3,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
