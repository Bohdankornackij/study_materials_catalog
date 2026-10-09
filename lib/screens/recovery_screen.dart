import 'package:flutter/material.dart';

import '../core/theme.dart';
import '../core/widgets/app_widgets.dart';

class RecoveryScreen extends StatefulWidget {
  const RecoveryScreen({super.key});
  @override
  State<RecoveryScreen> createState() => _RecoveryScreenState();
}

class _RecoveryScreenState extends State<RecoveryScreen> {
  final email = TextEditingController();
  @override
  void dispose() {
    email.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) => Scaffold(
    appBar: AppBar(title: const Text('Account Recovery')),
    body: PageBody(
      children: [
        const BrandIcon(icon: Icons.history),
        const SizedBox(height: 24),
        const Text(
          'Forgot your password?',
          style: TextStyle(fontSize: 25, fontWeight: FontWeight.w800),
        ),
        const SizedBox(height: 8),
        const Text(
          "Enter your email, and we'll send you a password reset link.",
          style: TextStyle(color: muted),
        ),
        const SizedBox(height: 28),
        AppField(
          label: 'Email',
          hint: 'student@lpnu.ua',
          controller: email,
          keyboardType: TextInputType.emailAddress,
        ),
        AppButton(
          label: 'Send instructions',
          onPressed: () => notify(
            context,
            'Demo: reset instructions requested. No email was sent.',
          ),
        ),
      ],
    ),
  );
}
