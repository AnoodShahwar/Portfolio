import 'package:flutter/material.dart';
import '../theme/colors.dart';

// ── DATA ────────────────────────────────────────────────────────────────────

class _Cert {
  final String title;
  final String issuer;
  final String date;
  final String imagePath;
  const _Cert(this.title, this.issuer, this.date, this.imagePath);
}

class _Folder {
  final String label;
  final String sub;
  final List<_Cert> certs;
  const _Folder(this.label, this.sub, this.certs);
}

const _folders = [
  _Folder('COURSERA', 'Online Courses', [
    _Cert(
      'Introduction to Git\n& GitHub',
      'Google / Coursera',
      '2025',
      'assets/git.png',
    ),
    _Cert(
      'Start Writing Prompts\nLike a Pro',
      'Coursera',
      '2025',
      'assets/ai.png',
    ),
  ]),
  _Folder('CISCO', 'Networking', [
    _Cert(
      'Getting Started with\nCisco Packet Tracer',
      'Cisco',
      '2026',
      'assets/cisco.png',
    ),
  ]),
  _Folder('COMPETITIONS', 'Events', [
    _Cert(
      'Procom \'26\nInterstellar Intelligence',
      'FAST-NUCES',
      '2026',
      'assets/procom.png',
    ),
  ]),
];

// ── SCREEN ──────────────────────────────────────────────────────────────────

class CertificationsScreen extends StatefulWidget {
  final VoidCallback onScrollDown;
  final VoidCallback onScrollNext;
  const CertificationsScreen({
    super.key,
    required this.onScrollDown,
    required this.onScrollNext,
  });

  @override
  State<CertificationsScreen> createState() => _CertificationsScreenState();
}

class _CertificationsScreenState extends State<CertificationsScreen>
    with TickerProviderStateMixin {
  int? _openFolder;
  int _hoveredFolder = -1;
  int _hoveredCard = -1;

  late final List<AnimationController> _cardControllers;
  late final List<Animation<double>> _cardAnims;

  @override
  void initState() {
    super.initState();
    // one controller per max possible cards (4 is enough)
    _cardControllers = List.generate(
      4,
      (_) => AnimationController(
        vsync: this,
        duration: const Duration(milliseconds: 420),
      ),
    );
    _cardAnims = _cardControllers
        .map((c) => CurvedAnimation(parent: c, curve: Curves.easeOutBack))
        .toList();
  }

  @override
  void dispose() {
    for (final c in _cardControllers) {
      c.dispose();
    }
    super.dispose();
  }

  void _openFolderAt(int i) async {
    // reset all card controllers
    for (final c in _cardControllers) {
      c.reset();
    }
    setState(() {
      _openFolder = i;
      _hoveredCard = -1;
    });
    // stagger each card in
    final certs = _folders[i].certs;
    for (int j = 0; j < certs.length; j++) {
      await Future.delayed(const Duration(milliseconds: 80));
      if (mounted) _cardControllers[j].forward();
    }
  }

  void _closeFolder() async {
    if (_openFolder == null) return;
    final certs = _folders[_openFolder!].certs;
    // reverse stagger out
    for (int j = certs.length - 1; j >= 0; j--) {
      await Future.delayed(const Duration(milliseconds: 60));
      if (mounted) _cardControllers[j].reverse();
    }
    await Future.delayed(const Duration(milliseconds: 300));
    if (mounted) setState(() => _openFolder = null);
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Container(
      width: size.width,
      height: size.height,
      color: kBlack,
      child: Stack(
        children: [
          // grid bg
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
          // corner accents
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
          Positioned(
            bottom: 0,
            left: 0,
            child: Container(
              width: 120,
              height: 3,
              color: kGold.withOpacity(0.15),
            ),
          ),
          Positioned(
            bottom: 0,
            left: 0,
            child: Container(
              width: 3,
              height: 120,
              color: kGold.withOpacity(0.15),
            ),
          ),

          // title
          Positioned(
            top: size.height * 0.06,
            left: 40,
            child: Text(
              'Certifications',
              style: TextStyle(
                fontFamily: 'diploma',
                fontSize: size.width * 0.042,
                color: kWhite,
              ),
            ),
          ),

          // main content
          _openFolder == null
              ? _buildFolderRow(size)
              : _buildFanView(size, _openFolder!),

          // back/next
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

  // ── FOLDER ROW ─────────────────────────────────────────────────────────────

  Widget _buildFolderRow(Size size) {
    return Center(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: List.generate(_folders.length, (i) {
          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 32),
            child: _FolderIcon(
              folder: _folders[i],
              isHovered: _hoveredFolder == i,
              onHover: (v) => setState(() => _hoveredFolder = v ? i : -1),
              onTap: () => _openFolderAt(i),
            ),
          );
        }),
      ),
    );
  }

  // ── FAN VIEW ───────────────────────────────────────────────────────────────

  Widget _buildFanView(Size size, int fi) {
    final folder = _folders[fi];
    final certs = folder.certs;
    final n = certs.length;

    // angle spread: evenly distribute between -25° and +25°
    double angleFor(int j) {
      return 0;
    }

    // horizontal offset so cards spread out
    double offsetFor(int j) {
      if (n == 1) return 0;
      final spread = size.width * 0.22;
      return -spread + (spread * 2 / (n - 1)) * j;
    }

    return Stack(
      children: [
        // dim overlay tap to close
        Positioned.fill(
          child: GestureDetector(
            onTap: _closeFolder,
            child: Container(color: Colors.transparent),
          ),
        ),

        // folder label at bottom center
        Align(
          alignment: const Alignment(0, 0.72),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                folder.label,
                style: TextStyle(
                  color: kGold,
                  fontSize: 13,
                  letterSpacing: 3,
                  fontFamily: 'bankgothic-regular',
                ),
              ),
              const SizedBox(height: 4),
              GestureDetector(
                onTap: _closeFolder,
                child: Text(
                  '[ CLOSE ]',
                  style: TextStyle(
                    color: kGold.withOpacity(0.4),
                    fontSize: 10,
                    letterSpacing: 2,
                    fontFamily: 'bankgothic-regular',
                  ),
                ),
              ),
            ],
          ),
        ),

        // fanned cards
        Align(
          alignment: const Alignment(0, -0.05),
          child: SizedBox(
            height: 380,
            child: Stack(
              alignment: Alignment.bottomCenter,
              children: List.generate(n, (j) {
                final angle = angleFor(j);
                final dx = offsetFor(j);
                return AnimatedBuilder(
                  animation: _cardAnims[j],
                  builder: (_, _) {
                    final t = _cardAnims[j].value;
                    return Transform.translate(
                      offset: Offset(dx * t, -20 * t),
                      child: Transform.rotate(
                        angle: (angle * t) * (3.14159 / 180),
                        alignment: Alignment.bottomCenter,
                        child: Opacity(
                          opacity: t.clamp(0, 1),
                          child: _CertCard(
                            cert: certs[j],
                            isHovered: _hoveredCard == j,
                            onHover: (v) =>
                                setState(() => _hoveredCard = v ? j : -1),
                          ),
                        ),
                      ),
                    );
                  },
                );
              }),
            ),
          ),
        ),
      ],
    );
  }
}

// ── FOLDER ICON WIDGET ───────────────────────────────────────────────────────

class _FolderIcon extends StatelessWidget {
  final _Folder folder;
  final bool isHovered;
  final ValueChanged<bool> onHover;
  final VoidCallback onTap;

  const _FolderIcon({
    required this.folder,
    required this.isHovered,
    required this.onHover,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) => onHover(true),
      onExit: (_) => onHover(false),
      child: GestureDetector(
        onTap: onTap,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          curve: Curves.easeOut,
          transform: Matrix4.translationValues(0, isHovered ? -12 : 0, 0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              // folder svg-style shape
              CustomPaint(
                size: const Size(140, 110),
                painter: _FolderPainter(
                  color: isHovered ? kGold : const Color(0xFF3A2800),
                  borderColor: isHovered ? kGold : kGold.withOpacity(0.35),
                ),
              ),
              const SizedBox(height: 14),
              Text(
                folder.label,
                style: TextStyle(
                  color: isHovered ? kWhite : const Color(0xFF888888),
                  fontSize: 13,
                  letterSpacing: 2.5,
                  fontFamily: 'bankgothic-regular',
                ),
              ),
              const SizedBox(height: 4),
              Text(
                '${folder.certs.length} ${folder.certs.length == 1 ? 'cert' : 'certs'}  ·  ${folder.sub}',
                style: TextStyle(
                  color: isHovered
                      ? kGold.withOpacity(0.7)
                      : const Color(0xFF444444),
                  fontSize: 12,
                  letterSpacing: 1.5,
                  fontFamily: 'fonnts.com-FuturaLT-Light',
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _FolderPainter extends CustomPainter {
  final Color color;
  final Color borderColor;
  const _FolderPainter({required this.color, required this.borderColor});

  @override
  void paint(Canvas canvas, Size size) {
    final fill = Paint()
      ..color = color
      ..style = PaintingStyle.fill;
    final border = Paint()
      ..color = borderColor
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1.5;

    // folder tab
    final tab = Path()
      ..moveTo(8, 26)
      ..lineTo(52, 26)
      ..lineTo(62, 14)
      ..lineTo(8, 14)
      ..close();

    // folder body
    final body = Path()
      ..moveTo(4, 26)
      ..lineTo(136, 26)
      ..lineTo(136, 106)
      ..lineTo(4, 106)
      ..close();

    canvas.drawPath(tab, fill);
    canvas.drawPath(tab, border);
    canvas.drawPath(body, fill);
    canvas.drawPath(body, border);

    // lines inside folder (document hint)
    final linePaint = Paint()
      ..color = borderColor.withOpacity(0.3)
      ..strokeWidth = 1;
    for (int i = 0; i < 3; i++) {
      final y = 46.0 + i * 14;
      canvas.drawLine(Offset(20, y), Offset(120, y), linePaint);
    }
  }

  @override
  bool shouldRepaint(_FolderPainter old) =>
      old.color != color || old.borderColor != borderColor;
}

// ── CERT CARD WIDGET ─────────────────────────────────────────────────────────

class _CertCard extends StatelessWidget {
  final _Cert cert;
  final bool isHovered;
  final ValueChanged<bool> onHover;

  const _CertCard({
    required this.cert,
    required this.isHovered,
    required this.onHover,
  });

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) => onHover(true),
      onExit: (_) => onHover(false),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 180),
        curve: Curves.easeOut,
        transform: Matrix4.translationValues(0, isHovered ? -18 : 0, 0),
        width: 450,

        padding: const EdgeInsets.all(10),
        decoration: BoxDecoration(
          color: isHovered ? const Color(0xFF1A1200) : const Color(0xFF111111),
          border: Border.all(
            color: isHovered ? kGold : kGold.withOpacity(0.25),
            width: isHovered ? 1 : 0.5,
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              height: 303,
              width: double.infinity,
              child: ClipRect(
                child: Image.asset(
                  cert.imagePath,
                  fit: BoxFit.cover,
                  width: double.infinity,
                  filterQuality: FilterQuality.high,
                ),
              ),
            ),
            const SizedBox(height: 8),
            Text(
              cert.title,
              style: TextStyle(
                color: isHovered ? kWhite : const Color(0xFFCCCCCC),
                fontSize: 10,
                fontFamily: 'bankgothic-regular',
                letterSpacing: 0.8,
                height: 1.4,
              ),
            ),
            const SizedBox(height: 4),
            Text(
              cert.issuer,
              style: TextStyle(
                color: kGold.withOpacity(0.7),
                fontSize: 10,
                fontFamily: 'fonnts.com-FuturaLT-Light',
              ),
            ),
          ],
        ),
      ),
    );
  }
}
