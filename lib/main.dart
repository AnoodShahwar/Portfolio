import 'package:flutter/material.dart';
import 'screens/splash.dart';
import 'screens/about.dart';
import 'screens/projects.dart';
import 'screens/skills.dart';
import 'screens/certifications.dart';
import 'screens/contact.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final PageController _controller = PageController();

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _nextPage() {
    _controller.nextPage(
      duration: const Duration(milliseconds: 600),
      curve: Curves.easeInOut,
    );
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        backgroundColor: const Color(0xFF030303),
        body: PageView(
          controller: _controller,
          scrollDirection: Axis.vertical,
          children: [
            SplashScreen(onScrollDown: _nextPage),
            AboutScreen(onScrollDown: _nextPage),
            ProjectsScreen(onScrollDown: _nextPage),
            SkillsScreen(onScrollDown: _nextPage),
            CertificationsScreen(onScrollDown: _nextPage),
            const ContactScreen(),
          ],
        ),
      ),
    );
  }
}
