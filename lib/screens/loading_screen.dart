import 'dart:async';

import 'package:flutter/material.dart';

import '../core/theme.dart';
import '../core/widgets/app_widgets.dart';
import 'login_screen.dart';

class LoadingScreen extends StatefulWidget {
  const LoadingScreen({super.key});
  @override
  State<LoadingScreen> createState() => _LoadingScreenState();
}

class _LoadingScreenState extends State<LoadingScreen> {
  Timer? timer;
  @override
  void initState() {
    super.initState();
    timer = Timer(const Duration(milliseconds: 1200), () {
      if (mounted) {
        Navigator.of(context).pushReplacement(
          MaterialPageRoute(builder: (_) => const LoginScreen()),
        );
      }
    });
  }

  @override
  void dispose() {
    timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) => const Scaffold(
    body: Center(
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 100),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            BrandIcon(icon: Icons.sync),
            SizedBox(height: 24),
            Text(
              'Loading...',
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.w700,
                color: Color(0xFF8A6117),
              ),
            ),
            SizedBox(height: 20),
            LinearProgressIndicator(
              color: yellow,
              backgroundColor: Color(0xFFFFF8C7),
            ),
          ],
        ),
      ),
    ),
  );
}
