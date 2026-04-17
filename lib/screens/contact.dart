import 'package:flutter/material.dart';
import '../theme/colors.dart';
import 'package:url_launcher/url_launcher.dart';

class ContactScreen extends StatefulWidget {
  final VoidCallback onScrollDown;
  const ContactScreen({super.key, required this.onScrollDown});

  @override
  State<ContactScreen> createState() => _ContactScreenState();
}

class _ContactScreenState extends State<ContactScreen>
    with TickerProviderStateMixin {
  bool _cardsVisible = false;
  late List<AnimationController> _controllers;
  late List<Animation<double>> _slideAnimations;
  late List<Animation<double>> _fadeAnimations;
  late AnimationController _blinkController;
  late Animation<double> _blinkAnimation;

  final List<_ContactCard> _cards = [
    _ContactCard(
      label: 'GMAIL',
      icon: Icons.email,
      color: const Color(0xFFEA4335),
      url: 'https://mail.google.com/mail/?view=cm&to=anoodshahwar@gmail.com',
    ),
    _ContactCard(
      label: 'GITHUB',
      icon: Icons.code,
      color: const Color(0xFF888888),
      url: 'https://github.com/AnoodShahwar',
    ),
    _ContactCard(
      label: 'LINKEDIN',
      icon: Icons.work,
      color: const Color(0xFF0077B5),
      url: 'https://linkedin.com/in/anoodshahwar',
    ),
    _ContactCard(
      label: 'RESUME',
      icon: Icons.description_outlined,
      color: kGold,
      url:
          'https://drive.google.com/file/d/1CNChvKes027bvhDoewnTiRjr6qsaAI-M/view?usp=sharing',
      isResume: false,
    ),
  ];

  @override
  void initState() {
    super.initState();

    _blinkController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 800),
    )..repeat(reverse: true);
    _blinkAnimation = Tween<double>(
      begin: 0.2,
      end: 1.0,
    ).animate(_blinkController);

    _controllers = List.generate(
      4,
      (i) => AnimationController(
        vsync: this,
        duration: const Duration(milliseconds: 400),
      ),
    );

    _slideAnimations = _controllers
        .map(
          (c) => Tween<double>(
            begin: -60,
            end: 0,
          ).animate(CurvedAnimation(parent: c, curve: Curves.easeOut)),
        )
        .toList();

    _fadeAnimations = _controllers
        .map(
          (c) => Tween<double>(
            begin: 0,
            end: 1,
          ).animate(CurvedAnimation(parent: c, curve: Curves.easeOut)),
        )
        .toList();
  }

  @override
  void dispose() {
    _blinkController.dispose();
    for (final c in _controllers) c.dispose();
    super.dispose();
  }

  Future<void> _triggerCards() async {
    if (_cardsVisible) return;
    setState(() => _cardsVisible = true);
    for (int i = 0; i < _controllers.length; i++) {
      await Future.delayed(const Duration(milliseconds: 120));
      _controllers[i].forward();
    }
  }

  Future<void> _launch(String url, bool isResume) async {
    if (isResume) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Resume download coming soon!')),
      );
      return;
    }
    final uri = Uri.parse(url);
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri, mode: LaunchMode.externalApplication);
    }
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
          // Grid background
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
                  'Contact',
                  style: TextStyle(
                    fontFamily: 'diploma',
                    fontSize: size.width * 0.045,
                    color: kWhite,
                  ),
                ),
              ),
              const SizedBox(height: 26),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(80, 0, 40, 60),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      // Phone booth
                      SizedBox(
                        width: size.width * 0.4,
                        height: size.height * 0.8,
                        child: Image.asset(
                          'assets/booth.jpg',
                          fit: BoxFit.contain,
                          alignment: Alignment.center,
                        ),
                      ),

                      const SizedBox(width: 10),

                      // Right side
                      Expanded(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            // Blinking sign — always blinks
                            GestureDetector(
                              onTap: _triggerCards,
                              child: AnimatedBuilder(
                                animation: _blinkAnimation,
                                builder: (_, __) => Opacity(
                                  opacity: _blinkAnimation.value,
                                  child: Container(
                                    padding: const EdgeInsets.symmetric(
                                      horizontal: 24,
                                      vertical: 12,
                                    ),
                                    decoration: BoxDecoration(
                                      border: Border.all(
                                        color: kGold,
                                        width: 1.5,
                                      ),
                                      color: kGold.withOpacity(0.08),
                                    ),
                                    child: Row(
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        Container(
                                          width: 10,
                                          height: 10,
                                          decoration: BoxDecoration(
                                            color: kGold.withOpacity(
                                              _blinkAnimation.value,
                                            ),
                                            shape: BoxShape.circle,
                                          ),
                                        ),
                                        const SizedBox(width: 12),
                                        Text(
                                          'INITIALIZE CONNECTION',
                                          style: TextStyle(
                                            fontFamily: 'bankgothic-regular',
                                            fontSize: size.width * 0.018,
                                            color: kGold,
                                            letterSpacing: 3,
                                          ),
                                        ),
                                        const SizedBox(width: 12),
                                        Container(
                                          width: 10,
                                          height: 10,
                                          decoration: BoxDecoration(
                                            color: kGold.withOpacity(
                                              _blinkAnimation.value,
                                            ),
                                            shape: BoxShape.circle,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            ),

                            const SizedBox(height: 40),

                            // 2x2 grid of cards
                            if (_cardsVisible)
                              SizedBox(
                                width: size.width * 0.45,
                                child: GridView.count(
                                  crossAxisCount: 2,
                                  shrinkWrap: true,
                                  crossAxisSpacing: 16,
                                  mainAxisSpacing: 16,
                                  childAspectRatio: 2,
                                  physics: const NeverScrollableScrollPhysics(),
                                  children: List.generate(4, (i) {
                                    return AnimatedBuilder(
                                      animation: _controllers[i],
                                      builder: (_, __) => Opacity(
                                        opacity: _fadeAnimations[i].value,
                                        child: Transform.translate(
                                          offset: Offset(
                                            _slideAnimations[i].value,
                                            0,
                                          ),
                                          child: _buildCard(_cards[i], size),
                                        ),
                                      ),
                                    );
                                  }),
                                ),
                              ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),

          // Back button only
          Positioned(
            bottom: 8,
            left: 40,
            child: GestureDetector(
              onTap: widget.onScrollDown,
              child: const Text(
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
        ],
      ),
    );
  }

  Widget _buildCard(_ContactCard card, Size size) {
    return GestureDetector(
      onTap: () => _launch(card.url, card.isResume),
      child: Container(
        decoration: BoxDecoration(
          color: card.color.withOpacity(0.1),
          border: Border.all(color: card.color.withOpacity(0.6), width: 1),
        ),
        child: Stack(
          children: [
            // Color accent top bar
            Positioned(
              top: 0,
              left: 0,
              right: 0,
              child: Container(height: 3, color: card.color),
            ),

            Center(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(card.icon, color: card.color, size: 36),
                  const SizedBox(height: 10),
                  Text(
                    card.label,
                    style: TextStyle(
                      fontFamily: 'bankgothic-regular',
                      fontSize: size.width * 0.013,
                      color: kWhite,
                      letterSpacing: 2,
                    ),
                  ),
                  const SizedBox(height: 6),
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 8,
                      vertical: 2,
                    ),
                    decoration: BoxDecoration(
                      border: Border.all(
                        color: card.color.withOpacity(0.5),
                        width: 0.5,
                      ),
                    ),
                    child: Text(
                      'TAP TO CONNECT',
                      style: TextStyle(
                        color: card.color.withOpacity(0.8),
                        fontSize: 9,
                        letterSpacing: 1.5,
                        fontFamily: 'fonnts.com-FuturaLT-Light',
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _ContactCard {
  final String label;
  final IconData icon;
  final Color color;
  final String url;
  final bool isResume;

  const _ContactCard({
    required this.label,
    required this.icon,
    required this.color,
    required this.url,
    this.isResume = false,
  });
}
