import 'package:flutter/material.dart';
import 'dart:math';
import '../theme/colors.dart';

class _Skill {
  final String icon;
  final String label;
  final String sub;
  final double proficiency;
  final String proficiencyLabel;
  final Color barColor;
  const _Skill(
    this.icon,
    this.label,
    this.sub,
    this.proficiency,
    this.proficiencyLabel,
    this.barColor,
  );
}

class _SkillCategory {
  final String name;
  final List<_Skill> skills;
  const _SkillCategory(this.name, this.skills);
}

final List<_SkillCategory> kSkillCategories = [
  _SkillCategory('LANGUAGES', [
    _Skill(
      '◆',
      'DART',
      'Mobile · Flutter',
      0.95,
      'PROFICIENT',
      const Color(0xFF4CAF50),
    ),
    _Skill(
      'C#',
      'C#',
      'Game Dev · Unity',
      0.60,
      'LEARNING',
      const Color(0xFF5B9BD5),
    ),
    _Skill(
      'Py',
      'PYTHON',
      'Data · Scripting',
      0.55,
      'LEARNING',
      const Color(0xFF5B9BD5),
    ),
    _Skill(
      'C++',
      'C++',
      'Systems · DSA',
      0.50,
      'BEGINNER',
      const Color(0xFF888888),
    ),
  ]),
  _SkillCategory('FRAMEWORKS', [
    _Skill(
      '◈',
      'FLUTTER',
      'Mobile · Cross-platform',
      0.95,
      'PROFICIENT',
      const Color(0xFF4CAF50),
    ),
    _Skill(
      '⬡',
      'UNITY',
      'Game Engine · 3D/2D',
      0.65,
      'LEARNING',
      const Color(0xFF5B9BD5),
    ),
    _Skill(
      '⬢',
      'NODE.JS',
      'Server · Runtime',
      0.30,
      'BEGINNER',
      const Color(0xFF888888),
    ),
  ]),
  _SkillCategory('BACKEND & DATABASE', [
    _Skill(
      '🔥',
      'FIREBASE',
      'Auth · Firestore',
      0.75,
      'LEARNING',
      const Color(0xFF5B9BD5),
    ),
    _Skill(
      '▣',
      'POSTGRESQL',
      'Relational · DB',
      0.55,
      'BEGINNER',
      const Color(0xFF888888),
    ),
    _Skill(
      '↔',
      'REST APIs',
      'HTTP · Integration',
      0.30,
      'LEARNING',
      const Color(0xFF5B9BD5),
    ),
    _Skill(
      '{}',
      'JSON',
      'Data · Format',
      0.30,
      'PROFICIENT',
      const Color(0xFF4CAF50),
    ),
    _Skill(
      '◻',
      'LOCAL STORE',
      'Hive · SharedPrefs',
      0.20,
      'LEARNING',
      const Color(0xFF5B9BD5),
    ),
  ]),
  _SkillCategory('TOOLS', [
    _Skill(
      '⎇',
      'GIT & GITHUB',
      'Version · Control',
      0.85,
      'PROFICIENT',
      const Color(0xFF4CAF50),
    ),
    _Skill(
      '▷',
      'VS CODE',
      'Primary · Editor',
      0.90,
      'ADVANCED',
      const Color(0xFFF5A623),
    ),
    _Skill(
      '▣',
      'ANDROID STUDIO',
      'Android · Dev',
      0.65,
      'LEARNING',
      const Color(0xFF5B9BD5),
    ),
    _Skill(
      '◼',
      'VISUAL STUDIO',
      'C# · .NET IDE',
      0.50,
      'LEARNING',
      const Color(0xFF5B9BD5),
    ),
    _Skill(
      '◇',
      'FIGMA',
      'UI/UX · Design',
      0.75,
      'LEARNING',
      const Color(0xFF5B9BD5),
    ),
    _Skill(
      '⬡',
      'JUPYTER',
      'Python · Notebooks',
      0.55,
      'BEGINNER',
      const Color(0xFF888888),
    ),
  ]),
];

class SkillsScreen extends StatefulWidget {
  final VoidCallback onScrollDown;
  final VoidCallback onScrollNext;
  const SkillsScreen({
    super.key,
    required this.onScrollDown,
    required this.onScrollNext,
  });

  @override
  State<SkillsScreen> createState() => _SkillsScreenState();
}

class _SkillsScreenState extends State<SkillsScreen> {
  int _catIndex = 0;
  int _selectedSkill = 0;
  int _hoveredSkill = -1;

  _SkillCategory get _cat => kSkillCategories[_catIndex];

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
                child: Row(
                  children: [
                    Text(
                      'Skills',
                      style: TextStyle(
                        fontFamily: 'diploma',
                        fontSize: size.width * 0.045,
                        color: kWhite,
                      ),
                    ),
                    const SizedBox(width: 16),
                  ],
                ),
              ),
              const SizedBox(height: 20),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(40, 0, 40, 60),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      _buildSidebar(size),
                      const SizedBox(width: 40),
                      Expanded(child: _buildMainArea(size)),
                    ],
                  ),
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

  Widget _buildSidebar(Size size) {
    return SizedBox(
      width: size.width * 0.22,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: double.infinity,
            padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
            decoration: BoxDecoration(
              color: const Color(0x33F5A623),
              border: const Border(
                bottom: BorderSide(color: kGold, width: 0.5),
              ),
            ),
            child: const Text(
              'CATEGORIES',
              style: TextStyle(
                color: kGold,
                fontSize: 14,
                letterSpacing: 3,
                fontFamily: 'bankgothic-regular',
              ),
            ),
          ),
          const SizedBox(height: 13),
          ...List.generate(kSkillCategories.length, (i) {
            final isActive = i == _catIndex;
            final cat = kSkillCategories[i];
            return GestureDetector(
              onTap: () => setState(() {
                _catIndex = i;
                _selectedSkill = 0;
                _hoveredSkill = -1;
              }),
              child: AnimatedContainer(
                duration: const Duration(milliseconds: 200),
                width: double.infinity,
                margin: const EdgeInsets.only(bottom: 6),
                padding: const EdgeInsets.symmetric(
                  vertical: 16,
                  horizontal: 16,
                ),
                decoration: BoxDecoration(
                  color: isActive
                      ? const Color(0x22F5A623)
                      : Colors.transparent,
                  border: Border(
                    left: BorderSide(
                      color: isActive ? kGold : Colors.transparent,
                      width: 3,
                    ),
                    bottom: const BorderSide(
                      color: Color(0x11F5A623),
                      width: 0.5,
                    ),
                  ),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          cat.name,
                          style: TextStyle(
                            color: isActive ? kWhite : const Color(0xFF555555),
                            fontSize: 16,
                            letterSpacing: 1.5,
                            fontFamily: 'bankgothic-regular',
                          ),
                        ),
                        const SizedBox(height: 3),
                        Text(
                          '${cat.skills.length} skills',
                          style: TextStyle(
                            color: isActive
                                ? kGold.withOpacity(0.7)
                                : const Color(0xFF333333),
                            fontSize: 14,
                            fontFamily: 'fonnts.com-FuturaLT-Light',
                          ),
                        ),
                      ],
                    ),
                    if (isActive)
                      Container(
                        width: 6,
                        height: 6,
                        decoration: const BoxDecoration(
                          color: kGold,
                          shape: BoxShape.circle,
                        ),
                      ),
                  ],
                ),
              ),
            );
          }),
        ],
      ),
    );
  }

  Widget _buildMainArea(Size size) {
    final wheelSize = (size.height * 0.78).clamp(200.0, 340.0);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          child: Center(
            child: SizedBox(
              width: wheelSize,
              height: wheelSize,
              child: Stack(
                alignment: Alignment.center,
                children: [
                  MouseRegion(
                    onHover: (event) {
                      final hit = _hitTest(event.localPosition, wheelSize);
                      setState(() => _hoveredSkill = hit);
                    },
                    onExit: (_) => setState(() => _hoveredSkill = -1),
                    child: GestureDetector(
                      onTapUp: (d) {
                        final hit = _hitTest(d.localPosition, wheelSize);
                        if (hit >= 0) setState(() => _selectedSkill = hit);
                      },
                      child: CustomPaint(
                        size: Size(wheelSize, wheelSize),
                        painter: _WheelPainter(
                          skills: _cat.skills,
                          selectedIndex: _selectedSkill,
                          hoveredIndex: _hoveredSkill,
                        ),
                      ),
                    ),
                  ),
                  IgnorePointer(
                    child: SizedBox(
                      width: wheelSize * 0.34,
                      child: _buildCenter(),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
        const SizedBox(height: 50),
        _buildProficiencyBars(size),
        const SizedBox(height: 8),
      ],
    );
  }

  Widget _buildCenter() {
    final idx = _hoveredSkill >= 0 ? _hoveredSkill : _selectedSkill;
    final skill = _cat.skills[idx];
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(
          skill.icon,
          style: const TextStyle(fontSize: 22),
          textAlign: TextAlign.center,
        ),
        const SizedBox(height: 8),
        Text(
          skill.label,
          style: TextStyle(
            color: kGold,
            fontSize: 13,
            letterSpacing: 1.5,
            fontFamily: 'bankgothic-regular',
            height: 1.3,
          ),
          textAlign: TextAlign.center,
        ),
        const SizedBox(height: 6),
        Text(
          skill.sub.replaceAll(' · ', '\n'),
          style: const TextStyle(
            color: Color(0xFF888888),
            fontSize: 11,
            letterSpacing: 1,
            fontFamily: 'fonnts.com-FuturaLT-Light',
            height: 1.6,
          ),
          textAlign: TextAlign.center,
        ),
      ],
    );
  }

  Widget _buildProficiencyBars(Size size) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Container(width: 20, height: 1.2, color: kGold.withOpacity(0.6)),
            const SizedBox(width: 8),
            Text(
              '${_cat.name}  ·  PROFICIENCY',
              style: TextStyle(
                color: kGold.withOpacity(0.6),
                fontSize: 13,
                letterSpacing: 2,
                fontFamily: 'fonnts.com-FuturaLT-Light',
              ),
            ),
            const SizedBox(width: 8),
            Expanded(
              child: Container(height: 1.2, color: kGold.withOpacity(0.6)),
            ),
          ],
        ),
        const SizedBox(height: 13),
        ..._cat.skills.map(
          (skill) => Padding(
            padding: const EdgeInsets.only(bottom: 3),
            child: Row(
              children: [
                SizedBox(
                  width: 120,
                  child: Text(
                    skill.label,
                    style: const TextStyle(
                      color: Color(0xFFAAAAAA),
                      fontSize: 11,
                      letterSpacing: 1.5,
                      fontFamily: 'fonnts.com-FuturaLT-Light',
                    ),
                  ),
                ),
                Expanded(
                  child: Stack(
                    children: [
                      Container(height: 2, color: const Color(0xFF222222)),
                      FractionallySizedBox(
                        widthFactor: skill.proficiency,
                        child: Container(height: 2, color: skill.barColor),
                      ),
                    ],
                  ),
                ),
                const SizedBox(width: 10),
                Text(
                  skill.proficiencyLabel,
                  style: TextStyle(
                    color: kGold.withOpacity(0.5),
                    fontSize: 8,
                    letterSpacing: 1.5,
                    fontFamily: 'fonnts.com-FuturaLT-Light',
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  int _hitTest(Offset tap, double wheelSize) {
    final cx = wheelSize / 2;
    final cy = wheelSize / 2;
    final outerR = wheelSize * 0.445;
    final innerR = wheelSize * 0.185;
    final dx = tap.dx - cx;
    final dy = tap.dy - cy;
    final dist = sqrt(dx * dx + dy * dy);
    if (dist < innerR || dist > outerR) return -1;
    double angle = atan2(dy, dx) + pi / 2;
    if (angle < 0) angle += 2 * pi;
    final sliceAngle = (2 * pi) / _cat.skills.length;
    return (angle / sliceAngle).floor() % _cat.skills.length;
  }
}

class _WheelPainter extends CustomPainter {
  final List<_Skill> skills;
  final int selectedIndex;
  final int hoveredIndex;

  const _WheelPainter({
    required this.skills,
    required this.selectedIndex,
    required this.hoveredIndex,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final cx = size.width / 2;
    final cy = size.height / 2;
    final outerR = size.width * 0.445;
    final innerR = size.width * 0.185;
    final n = skills.length;
    final sliceAngle = (2 * pi) / n;
    const gap = 0.035;
    const startOffset = -pi / 2;

    for (int i = 0; i < n; i++) {
      final a1 = startOffset + i * sliceAngle + gap;
      final a2 = startOffset + (i + 1) * sliceAngle - gap;
      final mid = (a1 + a2) / 2;
      final isSelected = i == selectedIndex;
      final isHovered = i == hoveredIndex;

      final expandedR = (isHovered && !isSelected) ? outerR + 10 : outerR;
      final fillColor = isSelected
          ? kGold
          : (isHovered ? kGold.withOpacity(0.35) : const Color(0xFF1A1A1A));

      final path = Path();
      path.moveTo(cx + innerR * cos(a1), cy + innerR * sin(a1));
      path.arcTo(
        Rect.fromCircle(center: Offset(cx, cy), radius: expandedR),
        a1,
        sliceAngle - gap * 2,
        false,
      );
      path.arcTo(
        Rect.fromCircle(center: Offset(cx, cy), radius: innerR),
        a2,
        -(sliceAngle - gap * 2),
        false,
      );
      path.close();

      canvas.drawPath(
        path,
        Paint()
          ..color = fillColor
          ..style = PaintingStyle.fill,
      );
      canvas.drawPath(
        path,
        Paint()
          ..color = isSelected
              ? kGold
              : (isHovered ? kGold.withOpacity(0.6) : const Color(0xFF2A2A2A))
          ..style = PaintingStyle.stroke
          ..strokeWidth = isSelected ? 1.5 : 0.5,
      );

      final labelR = (outerR + innerR) / 2;
      final lx = cx + labelR * cos(mid);
      final ly = cy + labelR * sin(mid);
      final textColor = isSelected
          ? Colors.black
          : (isHovered ? Colors.white : const Color(0xFF666666));

      canvas.save();
      canvas.translate(lx, ly);
      canvas.rotate(mid + pi / 2);

      final iconPainter = TextPainter(
        text: TextSpan(
          text: skills[i].icon,
          style: TextStyle(
            color: textColor,
            fontSize: 13,
            fontWeight: FontWeight.bold,
          ),
        ),
        textDirection: TextDirection.ltr,
      )..layout();
      iconPainter.paint(
        canvas,
        Offset(-iconPainter.width / 2, -iconPainter.height - 2),
      );

      final shortLabel = skills[i].label.length > 7
          ? skills[i].label.substring(0, 7)
          : skills[i].label;
      final labelPainter = TextPainter(
        text: TextSpan(
          text: shortLabel,
          style: TextStyle(color: textColor, fontSize: 7, letterSpacing: 0.8),
        ),
        textDirection: TextDirection.ltr,
      )..layout();
      labelPainter.paint(canvas, Offset(-labelPainter.width / 2, 3));
      canvas.restore();
    }

    canvas.drawCircle(
      Offset(cx, cy),
      innerR - 2,
      Paint()..color = const Color(0xFF0D0D0D),
    );
    canvas.drawCircle(
      Offset(cx, cy),
      innerR - 2,
      Paint()
        ..color = kGold
        ..style = PaintingStyle.stroke
        ..strokeWidth = 1.0,
    );
    canvas.drawCircle(
      Offset(cx, cy),
      innerR - 8,
      Paint()
        ..color = kGold.withOpacity(0.15)
        ..style = PaintingStyle.stroke
        ..strokeWidth = 0.5,
    );
  }

  @override
  bool shouldRepaint(_WheelPainter old) =>
      old.selectedIndex != selectedIndex ||
      old.hoveredIndex != hoveredIndex ||
      old.skills != skills;
}
