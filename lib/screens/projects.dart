import 'package:flutter/material.dart';
import '../theme/colors.dart';
import 'package:url_launcher/url_launcher.dart';

class ProjectsScreen extends StatefulWidget {
  final VoidCallback onScrollDown;
  final VoidCallback onScrollNext;
  const ProjectsScreen({
    super.key,
    required this.onScrollDown,
    required this.onScrollNext,
  });

  @override
  State<ProjectsScreen> createState() => _ProjectsScreenState();
}

class _ProjectsScreenState extends State<ProjectsScreen> {
  _Project? _selected;

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
                  'Projects',
                  style: TextStyle(
                    fontFamily: 'diploma',
                    fontSize: size.width * 0.045,
                    color: kWhite,
                  ),
                ),
              ),
              const SizedBox(height: 25),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(40, 0, 40, 60),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                        child: _buildDivision(
                          'FLUTTER DIVISION',
                          _flutterProjects(),
                        ),
                      ),
                      Container(
                        width: 1,
                        color: const Color(0x33F5A623),
                        margin: const EdgeInsets.symmetric(horizontal: 24),
                      ),
                      Expanded(
                        child: _buildDivision(
                          'UNITY DIVISION',
                          _unityProjects(),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
          if (_selected != null) _buildPopup(size),
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

  Widget _buildDivision(String title, List<_Project> projects) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          width: double.infinity,
          padding: const EdgeInsets.symmetric(vertical: 6, horizontal: 10),
          color: const Color(0x22F5A623),
          child: Text(
            title,
            style: const TextStyle(
              color: kGold,
              fontSize: 13,
              letterSpacing: 2,
              fontFamily: 'bankgothic-regular',
            ),
          ),
        ),
        const SizedBox(height: 14),
        ...projects.map((p) => _dossierCard(p)),
      ],
    );
  }

  Widget _dossierCard(_Project p) {
    return StatefulBuilder(
      builder: (context, setCardState) {
        bool hovered = false;
        return MouseRegion(
          onEnter: (_) => setCardState(() => hovered = true),
          onExit: (_) => setCardState(() => hovered = false),
          child: GestureDetector(
            onTap: () => setState(() => _selected = p),
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 150),
              margin: const EdgeInsets.only(bottom: 10),
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                border: Border.all(
                  color: hovered ? kGold : const Color(0x44F5A623),
                  width: 0.5,
                ),
                color: hovered
                    ? const Color(0x15F5A623)
                    : const Color(0x0AFFFFFF),
              ),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    width: 36,
                    height: 42,
                    decoration: BoxDecoration(
                      color: hovered
                          ? const Color(0x33F5A623)
                          : const Color(0x1AF5A623),
                      border: Border.all(
                        color: const Color(0x44FFFFFF),
                        width: 0.5,
                      ),
                    ),
                    child: Center(
                      child: Text(p.icon, style: const TextStyle(fontSize: 18)),
                    ),
                  ),
                  const SizedBox(width: 10),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          p.name,
                          style: TextStyle(
                            color: hovered ? kGold : kWhite,
                            fontSize: 15,
                            fontFamily: 'bankgothic-regular',
                            letterSpacing: 2,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 3),
                        Text(
                          p.desc,
                          style: const TextStyle(
                            color: Color(0x88FFFFFF),
                            fontSize: 12,
                            fontFamily: 'fonnts.com-FuturaLT-Light',
                            height: 1.4,
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(width: 8),
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 6,
                      vertical: 2,
                    ),
                    decoration: BoxDecoration(
                      border: Border.all(color: p.stampColor, width: 0.5),
                    ),
                    child: Text(
                      p.status,
                      style: TextStyle(
                        color: p.stampColor,
                        fontSize: 9.3,
                        letterSpacing: 1,
                        fontFamily: 'fonnts.com-FuturaLT-Light',
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  Widget _buildPopup(Size size) {
    final p = _selected!;
    return GestureDetector(
      onTap: () => setState(() => _selected = null),
      child: Container(
        color: Colors.black54,
        child: Center(
          child: GestureDetector(
            onTap: () {},
            child: Container(
              width: size.width * 0.5,
              padding: const EdgeInsets.all(24),
              decoration: BoxDecoration(
                color: const Color(0xFF0D0D0D),
                border: Border.all(color: kGold, width: 0.5),
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Text(p.icon, style: const TextStyle(fontSize: 20)),
                      const SizedBox(width: 10),
                      Expanded(
                        child: Text(
                          p.name,
                          style: const TextStyle(
                            color: kWhite,
                            fontSize: 18,
                            fontFamily: 'bankgothic-regular',
                            letterSpacing: 2,
                          ),
                        ),
                      ),
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 8,
                          vertical: 2,
                        ),
                        decoration: BoxDecoration(
                          border: Border.all(color: p.stampColor, width: 0.5),
                        ),
                        child: Text(
                          p.status,
                          style: TextStyle(
                            color: p.stampColor,
                            fontSize: 9,
                            letterSpacing: 1,
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),
                  _popupRow('TECH STACK', p.techStack),
                  _popupRow('ROLE', p.role),
                  const SizedBox(height: 8),
                  const Text(
                    'KEY FEATURES',
                    style: TextStyle(
                      color: kGoldDim,
                      fontSize: 11,
                      letterSpacing: 1.5,
                      fontFamily: 'fonnts.com-FuturaLT-Light',
                    ),
                  ),
                  const SizedBox(height: 6),
                  ...p.features.map(
                    (f) => Padding(
                      padding: const EdgeInsets.only(bottom: 4),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            '— ',
                            style: TextStyle(color: kGold, fontSize: 12),
                          ),
                          Expanded(
                            child: Text(
                              f,
                              style: const TextStyle(
                                color: kWhiteDim,
                                fontSize: 12,
                                fontFamily: 'fonnts.com-FuturaLT-Light',
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  if (p.github.isNotEmpty) ...[
                    const SizedBox(height: 12),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const SizedBox(
                          width: 100,
                          child: Text(
                            'GITHUB',
                            style: TextStyle(
                              color: kGoldDim,
                              fontSize: 11,
                              letterSpacing: 1.5,
                              fontFamily: 'fonnts.com-FuturaLT-Light',
                            ),
                          ),
                        ),
                        GestureDetector(
                          onTap: () async {
                            final uri = Uri.parse(p.github);
                            if (await canLaunchUrl(uri)) {
                              await launchUrl(
                                uri,
                                mode: LaunchMode.externalApplication,
                              );
                            }
                          },
                          child: Text(
                            p.github,
                            style: const TextStyle(
                              color: kGold,
                              fontSize: 12,
                              fontFamily: 'fonnts.com-FuturaLT-Light',
                              decoration: TextDecoration.underline,
                              decorationColor: kGold,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                  if (p.liveUrl.isNotEmpty) ...[
                    const SizedBox(height: 8),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const SizedBox(
                          width: 100,
                          child: Text(
                            'LIVE',
                            style: TextStyle(
                              color: kGoldDim,
                              fontSize: 11,
                              letterSpacing: 1.5,
                              fontFamily: 'fonnts.com-FuturaLT-Light',
                            ),
                          ),
                        ),
                        GestureDetector(
                          onTap: () async {
                            final uri = Uri.parse(p.liveUrl);
                            if (await canLaunchUrl(uri)) {
                              await launchUrl(
                                uri,
                                mode: LaunchMode.externalApplication,
                              );
                            }
                          },
                          child: const Text(
                            'View Live →',
                            style: TextStyle(
                              color: kGold,
                              fontSize: 12,
                              fontFamily: 'fonnts.com-FuturaLT-Light',
                              decoration: TextDecoration.underline,
                              decorationColor: kGold,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                  if (p.videoUrl.isNotEmpty) ...[
                    const SizedBox(height: 8),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const SizedBox(
                          width: 100,
                          child: Text(
                            'GAMEPLAY',
                            style: TextStyle(
                              color: kGoldDim,
                              fontSize: 11,
                              letterSpacing: 1.5,
                              fontFamily: 'fonnts.com-FuturaLT-Light',
                            ),
                          ),
                        ),
                        GestureDetector(
                          onTap: () async {
                            final uri = Uri.parse(p.videoUrl);
                            if (await canLaunchUrl(uri)) {
                              await launchUrl(
                                uri,
                                mode: LaunchMode.externalApplication,
                              );
                            }
                          },
                          child: const Text(
                            'Watch Gameplay →',
                            style: TextStyle(
                              color: kGold,
                              fontSize: 12,
                              fontFamily: 'fonnts.com-FuturaLT-Light',
                              decoration: TextDecoration.underline,
                              decorationColor: kGold,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                  const SizedBox(height: 16),
                  GestureDetector(
                    onTap: () => setState(() => _selected = null),
                    child: const Text(
                      '[ CLOSE FILE ]',
                      style: TextStyle(
                        color: kGold,
                        fontSize: 11,
                        letterSpacing: 2,
                        fontFamily: 'fonnts.com-FuturaLT-Light',
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _popupRow(String key, String value) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 100,
            child: Text(
              key,
              style: const TextStyle(
                color: kGoldDim,
                fontSize: 11,
                letterSpacing: 1.5,
                fontFamily: 'fonnts.com-FuturaLT-Light',
              ),
            ),
          ),
          Expanded(
            child: Text(
              value,
              style: const TextStyle(
                color: kWhiteDim,
                fontSize: 12,
                fontFamily: 'fonnts.com-FuturaLT-Light',
              ),
            ),
          ),
        ],
      ),
    );
  }

  List<_Project> _flutterProjects() => [
    _Project(
      '📱',
      'WSEMS',
      'Web-based smart event management system. Firebase backend.',
      'DEPLOYED',
      const Color(0xFF4CAF50),
      techStack: 'Flutter · Dart · Firebase',
      role: 'Solo Developer',
      features: [
        'Event creation & management',
        'User authentication',
        'Real-time data sync',
      ],
      github:
          'https://github.com/AnoodShahwar/Web-based-Smart-Event-Management-System',
      liveUrl: 'https://wsems-9ef5f.web.app',
    ),
    _Project(
      '🎓',
      'UBIT Student Hub',
      '5-screen campus app. Custom UI components, navigation architecture and layout system built from scratch.',
      'UI BUILD',
      const Color(0xFF888888),
      techStack: 'Flutter · Dart',
      role: 'Solo Developer',
      features: [
        'Multi-screen navigation',
        'Custom UI components',
        'Campus information hub',
      ],
      github: 'https://github.com/AnoodShahwar/UBIT-Student-Hub',
    ),
    _Project(
      '🌐',
      'Portfolio 2026',
      'This very thing you are looking at right now.',
      'ACTIVE',
      kGold,
      techStack: 'Flutter · Dart',
      role: 'Solo Developer',
      features: [
        'GTA-themed interactive design',
        'Multi-screen page navigation',
        'Custom fonts & animations',
      ],
      github: 'https://github.com/AnoodShahwar/Portfolio',
    ),
    _Project(
      '🔁',
      'Cuedo',
      'Offline phone automation. Set rules, let your phone handle the rest.',
      'COMING SOON',
      const Color(0xFF2889C2),
      techStack: 'Flutter · Dart · Kotlin · SQLite · OpenStreetMap',
      role: 'Solo Developer',
      features: [
        '"When... then..." rule builder for phone automation',
        'Triggers: location, time of day, charger connection',
        'Runs fully offline — no account, no internet needed',
      ],
      github: '',
    ),
  ];

  List<_Project> _unityProjects() => [
    _Project(
      '⚔️',
      'The Mysterious Knight',
      'A 3D Unity game set in a medieval village at night, where you face an enemy that roars, chases and attacks.',
      'SHIPPED',
      const Color(0xFF8DBB6A),
      techStack: 'Unity 6 · C#',
      role: 'Solo Developer',
      features: [
        'Medieval night village; level designed and built from scratch',
        'Enemy AI with NavMesh: roars, chases and attacks · Health system',
        'Atmospheric night lighting · Cinemachine camera switching',
      ],
      github: '',
      videoUrl:
          'https://drive.google.com/file/d/1EUuhih-daWBhAnH6E9S3lGVgCwe3RRNm/view?usp=sharing',
    ),
    _Project(
      '👁️',
      'Static',
      'First-person horror. A cabin in a storm, a figure that only moves when you look away.',
      'IN PROGRESS',
      const Color(0xFF888888),
      techStack: 'Unity 6 · C#',
      role: 'Solo Developer',
      features: [
        'Figure AI that only moves when the player looks away, freezes on eye contact',
        'Story told entirely through props and environment, no dialogue or text',
        'Scripted scares, item puzzles and a complete ending, about 10 min playtime',
      ],
      github: '',
    ),
  ];
}

class _Project {
  final String icon,
      name,
      desc,
      status,
      techStack,
      role,
      github,
      liveUrl,
      videoUrl;
  final Color stampColor;
  final List<String> features;
  const _Project(
    this.icon,
    this.name,
    this.desc,
    this.status,
    this.stampColor, {
    required this.techStack,
    required this.role,
    required this.features,
    required this.github,
    this.liveUrl = '',
    this.videoUrl = '',
  });
}
