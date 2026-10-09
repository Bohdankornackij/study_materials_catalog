import 'package:flutter/material.dart';

import '../core/theme.dart';
import '../core/widgets/app_widgets.dart';
import 'loading_screen.dart';

class WelcomeScreen extends StatelessWidget {
  const WelcomeScreen({super.key});
  @override
  Widget build(BuildContext context) => Scaffold(
    backgroundColor: yellow,
    body: SafeArea(
      child: Center(
        child: Padding(
          padding: const EdgeInsets.all(32),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const BrandIcon(size: 80),
              const SizedBox(height: 24),
              const Text(
                'StudyHub',
                style: TextStyle(fontSize: 28, fontWeight: FontWeight.w800),
              ),
              const SizedBox(height: 8),
              const Text(
                'Your learning materials, organized.',
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 48),
              AppButton(
                label: 'Get started',
                color: Colors.white,
                onPressed: () => Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const LoadingScreen(),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    ),
  );
}
