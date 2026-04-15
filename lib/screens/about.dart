import 'package:flutter/material.dart';
import '../theme/colors.dart';

class AboutScreen extends StatefulWidget {
  final VoidCallback onScrollDown;
  final VoidCallback onScrollNext;
  const AboutScreen({
    super.key,
    required this.onScrollDown,
    required this.onScrollNext,
  });

  @override
  State<AboutScreen> createState() => _AboutScreenState();
}

class _AboutScreenState extends State<AboutScreen> {
  String _selected = 'Player';

  final List<String> _categories = ['Player', 'Mission', 'Attributes', 'Misc'];

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Container(
      width: size.width,
      height: size.height,
      color: kBlack,
      child: Stack(
        children: [
          Positioned.fill(
            child: Opacity(
              opacity: 0.07,
              child: GridPaper(
                color: kGold,
                divisions: 1,
                subdivisions: 1,
                child: const SizedBox.expand(),
              ),
            ),
          ),

          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: size.height * 0.06),
              Padding(
                padding: const EdgeInsets.only(left: 40),
                child: Text(
                  'About Me',
                  style: TextStyle(
                    fontFamily: 'diploma',
                    fontSize: size.width * 0.045,
                    color: kWhite,
                  ),
                ),
              ),
              const SizedBox(height: 25),
              Expanded(
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      width: size.width * 0.24,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: _categories.map((cat) {
                          final isSelected = cat == _selected;
                          return GestureDetector(
                            onTap: () => setState(() => _selected = cat),
                            child: Container(
                              width: double.infinity,
                              padding: const EdgeInsets.symmetric(
                                vertical: 14,
                                horizontal: 40,
                              ),
                              decoration: BoxDecoration(
                                color: isSelected
                                    ? const Color(0x33F5A623)
                                    : Colors.transparent,
                                border: isSelected
                                    ? const Border(
                                        left: BorderSide(
                                          color: kGold,
                                          width: 3,
                                        ),
                                      )
                                    : null,
                              ),
                              child: Text(
                                cat.toUpperCase(),
                                style: TextStyle(
                                  fontFamily: 'bankgothic-regular',
                                  fontSize: size.width * 0.018,
                                  color: isSelected ? kGold : kWhite,
                                  letterSpacing: 1,
                                ),
                              ),
                            ),
                          );
                        }).toList(),
                      ),
                    ),
                    Container(
                      width: 5,
                      color: const Color(0x22F5A623),
                      margin: const EdgeInsets.only(bottom: 60),
                    ),
                    Expanded(
                      child: Padding(
                        padding: EdgeInsets.fromLTRB(
                          size.width * 0.03,
                          0,
                          0,
                          0,
                        ),
                        child: _buildContent(size),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),

          Positioned(
            bottom: 8,
            left: 0,
            right: 0,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                GestureDetector(
                  onTap: widget.onScrollDown,
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
                GestureDetector(
                  onTap: widget.onScrollNext,
                  child: const Padding(
                    padding: EdgeInsets.only(right: 40),
                    child: Text(
                      'Next',
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
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildContent(Size size) {
    switch (_selected) {
      case 'Player':
        return _buildPlayer(size);
      case 'Mission':
        return _buildMission(size);
      case 'Attributes':
        return _buildAttributes(size);
      case 'Misc':
        return _buildMisc(size);
      default:
        return _buildPlayer(size);
    }
  }

  Widget _buildPlayer(Size size) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          width: size.width * 0.2,
          height: size.height * 0.6,
          decoration: BoxDecoration(
            border: Border.all(
              color: const Color.fromARGB(255, 255, 255, 255),
              width: 2,
            ),
          ),
          child: Image.asset('assets/magnifi.jpeg', fit: BoxFit.cover),
        ),
        SizedBox(width: size.width * 0.03),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 8),
              Text(
                'Anood   Shahwar',
                style: TextStyle(
                  fontFamily: 'bankgothic-regular',
                  fontSize: size.width * 0.032,
                  color: kWhite,
                ),
              ),
              const SizedBox(height: 6),
              Text(
                'SE Student · Flutter Developer · Game Developer',
                style: TextStyle(
                  color: kGold,
                  fontSize: 17,
                  fontFamily: 'fonnts.com-FuturaLT-Light',
                  letterSpacing: 1,
                ),
              ),
              const SizedBox(height: 20),
              _infoRow('Location', 'Karachi, Pakistan'),
              _infoRow('University', 'UoK-UBIT'),
              _infoRow('Semester', '5th'),
              const SizedBox(height: 20),
              Padding(
                padding: const EdgeInsets.only(right: 40),
                child: Text(
                  'A 3rd year Software Engineering student with a thing for building fun, problem solving and creative apps. '
                  'I enjoy turning ideas into real products whether it\'s a mobile app in Flutter or a game in Unity. '
                  'I care a lot about design, details, and making things that actually feel good to use and have a purpose.',
                  textAlign: TextAlign.justify,
                  style: TextStyle(
                    color: Color(0x99FFFFFF),
                    fontSize: 17,
                    fontFamily: 'fonnts.com-FuturaLT-Light',
                    height: 1.4,
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildMission(Size size) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(height: 8),
        Text(
          'Current Objective',
          style: TextStyle(
            fontFamily: 'bankgothic-regular',
            fontSize: size.width * 0.025,
            color: kGold,
          ),
        ),
        const SizedBox(height: 35),
        _missionItem(
          size,
          icon: Icons.star,
          title: 'Land a Flutter Internship',
          desc:
              'Actively hunting for Flutter internships in Karachi. Target: June 2026.',
          status: 'ACTIVE',
        ),
        const SizedBox(height: 40),
        _missionItem(
          size,
          icon: Icons.layers,
          title: 'Master Flutter State Management',
          desc:
              'Deep diving into Riverpod and Bloc. Clean architecture or bust.',
          status: 'IN PROGRESS',
        ),
        const SizedBox(height: 40),
        _missionItem(
          size,
          icon: Icons.storage,
          title: 'Learn Backend Development',
          desc:
              'Leveling up from Firebase into Node.js and Supabase territory.',
          status: 'IN PROGRESS',
        ),
        const SizedBox(height: 40),
        _missionItem(
          size,
          icon: Icons.sports_esports,
          title: 'Publish a Game',
          desc:
              'Ship something to Play Store or itch.io. Completion is the real unlock.',
          status: 'SIDE MISSION',
        ),
      ],
    );
  }

  Widget _buildAttributes(Size size) {
    final attrs = [
      ('OBSERVANT', 0.95),
      ('LOYAL', 0.90),
      ('ANALYTICAL', 0.85),
      ('DEDICATED', 0.80),
      ('CREATIVE', 0.80),
      ('COMMUNICATIVE', 0.75),
    ];

    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 8),
          Text(
            'Skill Tree',
            style: TextStyle(
              fontFamily: 'bankgothic-regular',
              fontSize: size.width * 0.025,
              color: kGold,
            ),
          ),
          const SizedBox(height: 30),
          ...attrs.map(
            (a) => Padding(
              padding: const EdgeInsets.only(bottom: 24),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      SizedBox(
                        width: 180,
                        child: Text(
                          a.$1,
                          style: const TextStyle(
                            color: kGold,
                            fontFamily: 'fonnts.com-FuturaLT-Light',
                            fontSize: 13,
                            letterSpacing: 1.5,
                          ),
                        ),
                      ),
                      Row(
                        children: List.generate(10, (i) {
                          final filled = i < (a.$2 * 10).round();
                          return Container(
                            width: 24,
                            height: 12,
                            margin: const EdgeInsets.only(right: 3),
                            color: filled ? kWhite : const Color(0x33FFFFFF),
                          );
                        }),
                      ),
                      const SizedBox(width: 12),
                      Text(
                        '${(a.$2 * 100).round()}%',
                        style: const TextStyle(
                          color: Color(0x66FFFFFF),
                          fontSize: 12,
                          fontFamily: 'fonnts.com-FuturaLT-Light',
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildMisc(Size size) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(height: 8),
        Text(
          'Extra  Info',
          style: TextStyle(
            fontFamily: 'bankgothic-regular',
            fontSize: size.width * 0.025,
            color: kGold,
          ),
        ),
        const SizedBox(height: 20),
        _miscRow(
          size,
          'CREATIVE ASSETS',
          'I spend my idle time doing art, including traditional painting, sketching, and coloring. I also enjoy photography and video editing to keep my creative side sharp',
        ),
        _miscRow(
          size,
          'NARRATIVE INTEL',
          'Outside of coding, I spend my time reading Manga and Manhwa. I also enjoy writing original stories and watching documentaries on deep-sea mysteries.',
        ),
        _miscRow(
          size,
          'VITAL STATS',
          'Personal tastes in food include a major preference for MOTG\'s Hotpot and Momos. I am a fan of anything saucy, spicy, or soupy.',
        ),
        _miscRow(
          size,
          'PSYCH PROFILE',
          'My nature is naturally introverted and quiet at first. I become very talkative once I am comfortable with someone. I am deeply loyal to my people, my work, and my personal interests.',
        ),
      ],
    );
  }

  Widget _infoRow(String key, String value) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: Row(
        children: [
          SizedBox(
            width: 130,
            child: Text(
              key.toUpperCase(),
              style: const TextStyle(
                color: kGoldDim,
                fontFamily: 'fonnts.com-FuturaLT-Light',
                fontSize: 14,
                fontWeight: FontWeight.w900,
                letterSpacing: 1.2,
              ),
            ),
          ),
          Text(
            value,
            style: const TextStyle(
              color: kWhiteDim,
              fontSize: 16,
              fontFamily: 'fonnts.com-FuturaLT-Light',
            ),
          ),
        ],
      ),
    );
  }

  Widget _missionItem(
    Size size, {
    required IconData icon,
    required String title,
    required String desc,
    required String status,
  }) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Icon(icon, color: kGold, size: 18),
        const SizedBox(width: 13),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Text(
                    title,
                    style: const TextStyle(
                      color: kWhite,
                      fontSize: 15,
                      fontFamily: 'fonnts.com-FuturaLT-Light',
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(width: 10),
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 8,
                      vertical: 2,
                    ),
                    decoration: BoxDecoration(
                      border: Border.all(color: kGold, width: 0.5),
                      color: kGoldFaint,
                    ),
                    child: Text(
                      status,
                      style: const TextStyle(
                        color: kGold,
                        fontFamily: 'fonnts.com-FuturaLT-Light',
                        fontSize: 11,
                        letterSpacing: 1,
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 4),
              Text(
                desc,
                style: const TextStyle(
                  color: Color(0x88FFFFFF),
                  fontSize: 13,
                  fontFamily: 'fonnts.com-FuturaLT-Light',
                  height: 1.5,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _miscRow(Size size, String key, String value) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 160,
            child: Text(
              key.toUpperCase(),
              style: const TextStyle(
                color: kGoldDim,
                fontSize: 15,
                fontFamily: 'fonnts.com-FuturaLT-Light',
                fontWeight: FontWeight.w600,
                letterSpacing: 1.5,
              ),
            ),
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.only(right: 40),
              child: Text(
                value,
                textAlign: TextAlign.justify,
                style: const TextStyle(
                  color: kWhiteDim,
                  fontSize: 14,
                  letterSpacing: 1.5,
                  fontFamily: 'fonnts.com-FuturaLT-Light',
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
