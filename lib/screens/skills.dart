import 'package:flutter/material.dart';
import 'dart:math';
import '../theme/colors.dart';

class _Skill {
  final String icon;
  final String label;
  final String sub;
  const _Skill(this.icon, this.label, this.sub);
}

class _SkillCategory {
  final String name;
  final Color color;
  final List<_Skill> skills;
  const _SkillCategory(this.name, this.color, this.skills);
}

const List<_SkillCategory> kSkillCategories = [
  _SkillCategory('LANGUAGES', Color(0xFFF5A623), [
    _Skill('◆', 'DART', 'Mobile · Flutter'),
    _Skill('C#', 'C#', 'Game Dev · Unity'),
    _Skill('Py', 'PYTHON', 'Data · Scripting'),
    _Skill('C++', 'C++', 'Systems · DSA'),
  ]),
  _SkillCategory('FRAMEWORKS', Color(0xFFF5A623), [
    _Skill('◈', 'FLUTTER', 'Mobile · Cross-platform'),
    _Skill('⬡', 'UNITY', 'Game Engine · 2D/3D'),
    _Skill('⬢', 'NODE.JS', 'Server · Runtime'),
  ]),
  _SkillCategory('BACKEND & DATA', Color(0xFFF5A623), [
    _Skill('🔥', 'FIREBASE', 'Auth · Firestore'),
    _Skill('▣', 'POSTGRESQL', 'Relational · DB'),
    _Skill('↔', 'REST APIs', 'HTTP · Integration'),
    _Skill('{ }', 'JSON', 'Data · Format'),
    _Skill('◻', 'LOCAL STORE', 'Hive · SharedPrefs'),
  ]),
  _SkillCategory('TOOLS', Color(0xFFF5A623), [
    _Skill('⎇', 'GIT & GITHUB', 'Version · Control'),
    _Skill('▷', 'VS CODE', 'Primary · Editor'),
    _Skill('▣', 'ANDROID STUDIO', 'Android · Dev'),
    _Skill('◼', 'VISUAL STUDIO', 'C# · .NET IDE'),
    _Skill('◇', 'FIGMA', 'UI/UX · Design'),
    _Skill('⬡', 'JUPYTER', 'Python · Notebooks'),
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

  void _selectCat(int i) => setState(() {
    _catIndex = i;
    _selectedSkill = 0;
    _hoveredSkill = -1;
  });
  void _selectSkill(int i) => setState(() => _selectedSkill = i);
  void _hoverSkill(int i) => setState(() => _hoveredSkill = i);
  void _clearHover() => setState(() => _hoveredSkill = -1);

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

          // Decorative corner accents
          Positioned(
            top: 0,
            right: 0,
            child: Container(
              width: 120,
              height: 3,
              color: kGold.withOpacity(0.4),
            ),
          ),
          Positioned(
            top: 0,
            right: 0,
            child: Container(
              width: 3,
              height: 120,
              color: kGold.withOpacity(0.4),
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
                    children: [
                      _buildSidebar(size),
                      const SizedBox(width: 40),
                      Expanded(child: _buildWheelArea(size)),
                      const SizedBox(width: 24),
                      SizedBox(
                        width: size.width * 0.18,
                        child: AnimatedSwitcher(
                          duration: const Duration(milliseconds: 200),
                          child: _hoveredSkill >= 0 || _selectedSkill >= 0
                              ? Container(
                                  key: ValueKey(
                                    '$_catIndex-${_hoveredSkill >= 0 ? _hoveredSkill : _selectedSkill}',
                                  ),
                                  padding: const EdgeInsets.all(16),
                                  decoration: BoxDecoration(
                                    border: Border.all(
                                      color: kGold.withOpacity(0.3),
                                      width: 0.5,
                                    ),
                                    color: kGold.withOpacity(0.04),
                                  ),
                                  child: Builder(
                                    builder: (_) {
                                      final idx = _hoveredSkill >= 0
                                          ? _hoveredSkill
                                          : _selectedSkill;
                                      final skill = _cat.skills[idx];
                                      return Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            'SELECTED',
                                            style: TextStyle(
                                              color: kGold.withOpacity(0.5),
                                              fontSize: 9,
                                              letterSpacing: 2,
                                              fontFamily: 'bankgothic-regular',
                                            ),
                                          ),
                                          const SizedBox(height: 8),
                                          Text(
                                            skill.label,
                                            style: const TextStyle(
                                              color: kWhite,
                                              fontSize: 18,
                                              fontFamily: 'bankgothic-regular',
                                              letterSpacing: 1,
                                            ),
                                          ),
                                          const SizedBox(height: 6),
                                          Text(
                                            skill.sub.replaceAll(' · ', '\n'),
                                            style: TextStyle(
                                              color: kGold.withOpacity(0.7),
                                              fontSize: 11,
                                              fontFamily:
                                                  'fonnts.com-FuturaLT-Light',
                                              height: 1.6,
                                            ),
                                          ),
                                        ],
                                      );
                                    },
                                  ),
                                )
                              : const SizedBox.shrink(),
                        ),
                      ),
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
      child: SingleChildScrollView(
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
                  fontSize: 13,
                  letterSpacing: 3,
                  fontFamily: 'bankgothic-regular',
                ),
              ),
            ),
            const SizedBox(height: 27),
            ...List.generate(kSkillCategories.length, (i) {
              final isActive = i == _catIndex;
              final cat = kSkillCategories[i];
              return GestureDetector(
                onTap: () => _selectCat(i),
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
                      bottom: BorderSide(
                        color: const Color(0x11F5A623),
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
                              color: isActive
                                  ? kWhite
                                  : const Color(0xFF555555),
                              fontSize: 18,
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
                              fontSize: 15,
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

            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }

  Widget _buildWheelArea(Size size) {
    final wheelSize = (size.height * 0.94).clamp(270.0, 440.0);
    return Column(
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
                      final local = event.localPosition;
                      final hit = _hitTestSlice(
                        local,
                        wheelSize,
                        _cat.skills.length,
                      );
                      _hoverSkill(hit);
                    },
                    onExit: (_) => _clearHover(),
                    child: GestureDetector(
                      onTapUp: (details) {
                        final local = details.localPosition;
                        final hit = _hitTestSlice(
                          local,
                          wheelSize,
                          _cat.skills.length,
                        );
                        if (hit >= 0) _selectSkill(hit);
                      },
                      child: CustomPaint(
                        size: Size(wheelSize, wheelSize),
                        painter: _WheelPainter(
                          skills: _cat.skills,
                          catColor: _cat.color,
                          selectedIndex: _selectedSkill,
                          hoveredIndex: _hoveredSkill,
                        ),
                      ),
                    ),
                  ),
                  IgnorePointer(
                    child: SizedBox(
                      width: wheelSize * 0.34,
                      child: _buildCenterDetail(
                        _cat.skills[_hoveredSkill >= 0
                            ? _hoveredSkill
                            : _selectedSkill],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
        _buildThumbStrip(),
        const SizedBox(height: 8),
      ],
    );
  }

  Widget _buildCenterDetail(_Skill skill) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(
          skill.icon,
          style: const TextStyle(fontSize: 26),
          textAlign: TextAlign.center,
        ),
        const SizedBox(height: 8),
        Text(
          skill.label,
          style: TextStyle(
            color: _cat.color,
            fontSize: 17,
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

  Widget _buildThumbStrip() {
    final skills = _cat.skills;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(bottom: 10),
          child: Row(
            children: [
              Container(width: 30, height: 2, color: kGold.withOpacity(0.5)),
              const SizedBox(width: 8),
              Text(
                '${_cat.name}  ·  ${skills.length} ITEMS',
                style: TextStyle(
                  color: kGold.withOpacity(0.4),
                  fontSize: 12,
                  letterSpacing: 2,
                  fontFamily: 'bankgothic-regular',
                ),
              ),
              const SizedBox(width: 8),
              Expanded(
                child: Container(height: 2, color: kGold.withOpacity(0.5)),
              ),
            ],
          ),
        ),
        Wrap(
          spacing: 8,
          runSpacing: 8,
          children: List.generate(skills.length, (i) {
            final isActive = i == _selectedSkill;
            return GestureDetector(
              onTap: () => _selectSkill(i),
              child: AnimatedContainer(
                duration: const Duration(milliseconds: 150),
                width: 48,
                height: 48,
                decoration: BoxDecoration(
                  color: isActive
                      ? _cat.color.withOpacity(0.15)
                      : const Color.fromARGB(255, 59, 59, 59),
                  border: Border.all(
                    color: isActive ? _cat.color : const Color(0xFF2A2A2A),
                    width: isActive ? 1 : 0.5,
                  ),
                ),
                child: Stack(
                  children: [
                    Center(
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text(
                            skills[i].icon,
                            style: const TextStyle(fontSize: 16),
                          ),
                          const SizedBox(height: 3),
                          Text(
                            skills[i].label.length > 6
                                ? skills[i].label.substring(0, 6)
                                : skills[i].label,
                            style: TextStyle(
                              color: isActive
                                  ? _cat.color
                                  : const Color(0xFF666666),
                              fontSize: 10,
                              letterSpacing: 0.5,
                              fontFamily: 'fonnts.com-FuturaLT-Light',
                            ),
                          ),
                        ],
                      ),
                    ),
                    if (isActive)
                      Positioned(
                        top: 2,
                        right: 2,
                        child: Container(
                          width: 10,
                          height: 10,
                          color: _cat.color,
                          child: const Center(
                            child: Text(
                              '★',
                              style: TextStyle(
                                fontSize: 10,
                                color: Colors.black,
                              ),
                            ),
                          ),
                        ),
                      ),
                  ],
                ),
              ),
            );
          }),
        ),
      ],
    );
  }

  int _hitTestSlice(Offset tap, double wheelSize, int n) {
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
    final sliceAngle = (2 * pi) / n;
    return (angle / sliceAngle).floor() % n;
  }
}

class _WheelPainter extends CustomPainter {
  final List<_Skill> skills;
  final Color catColor;
  final int selectedIndex;
  final int hoveredIndex;

  const _WheelPainter({
    required this.skills,
    required this.catColor,
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

      Color fillColor;
      if (isSelected) {
        fillColor = catColor;
      } else if (isHovered) {
        fillColor = catColor.withOpacity(0.35);
      } else {
        fillColor = const Color(0xFF1A1A1A);
      }

      final expandedOuterR = (isHovered && !isSelected) ? outerR + 10 : outerR;

      final fillPaint = Paint()
        ..color = fillColor
        ..style = PaintingStyle.fill;
      final path = Path();
      path.moveTo(cx + innerR * cos(a1), cy + innerR * sin(a1));
      path.arcTo(
        Rect.fromCircle(center: Offset(cx, cy), radius: expandedOuterR),
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

      canvas.drawPath(path, fillPaint);

      final borderPaint = Paint()
        ..color = isSelected
            ? catColor
            : (isHovered ? catColor.withOpacity(0.6) : const Color(0xFF2A2A2A))
        ..style = PaintingStyle.stroke
        ..strokeWidth = isSelected ? 1.5 : (isHovered ? 1.0 : 0.5);
      canvas.drawPath(path, borderPaint);

      final labelR = (outerR + innerR) / 2;
      final lx = cx + labelR * cos(mid);
      final ly = cy + labelR * sin(mid);
      final iconColor = (isSelected || isHovered)
          ? (isSelected ? Colors.black : Colors.white)
          : const Color(0xFF666666);

      canvas.save();
      canvas.translate(lx, ly);
      canvas.rotate(mid + pi / 2);

      final iconPainter = TextPainter(
        text: TextSpan(
          text: skills[i].icon,
          style: TextStyle(
            color: iconColor,
            fontSize: 17,
            fontWeight: FontWeight.bold,
          ),
        ),
        textDirection: TextDirection.ltr,
      )..layout();
      iconPainter.paint(
        canvas,
        Offset(-iconPainter.width / 2, -iconPainter.height - 2),
      );

      final shortLabel = skills[i].label.length > 6
          ? skills[i].label.substring(0, 6)
          : skills[i].label;
      final labelPainter = TextPainter(
        text: TextSpan(
          text: shortLabel,
          style: TextStyle(color: iconColor, fontSize: 12, letterSpacing: 0.8),
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
        ..color = catColor
        ..style = PaintingStyle.stroke
        ..strokeWidth = 1.0,
    );

    // Inner decorative ring
    canvas.drawCircle(
      Offset(cx, cy),
      innerR - 8,
      Paint()
        ..color = catColor.withOpacity(0.15)
        ..style = PaintingStyle.stroke
        ..strokeWidth = 0.5,
    );
  }

  @override
  bool shouldRepaint(_WheelPainter old) =>
      old.selectedIndex != selectedIndex ||
      old.hoveredIndex != hoveredIndex ||
      old.catColor != catColor ||
      old.skills != skills;
}
