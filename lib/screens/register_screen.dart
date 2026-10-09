import 'package:flutter/material.dart';

import '../core/theme.dart';
import '../core/widgets/app_widgets.dart';
import '../models/catalog.dart';
import 'home_screen.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});
  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final name = TextEditingController();
  final email = TextEditingController();
  final password = TextEditingController();
  final confirmation = TextEditingController();
  @override
  void dispose() {
    for (final c in [name, email, password, confirmation]) {
      c.dispose();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) => Scaffold(
    appBar: AppBar(title: const Text('Create Account')),
    body: PageBody(
      children: [
        const BrandIcon(),
        const SizedBox(height: 24),
        const Text(
          'Start your learning journey',
          style: TextStyle(fontSize: 25, fontWeight: FontWeight.w800),
        ),
        const SizedBox(height: 8),
        const Text(
          'Keep all your study materials in one place.',
          style: TextStyle(color: muted),
        ),
        const SizedBox(height: 28),
        AppField(
          label: 'Full name',
          controller: name,
          hint: 'Bohdan Kornatskyi',
        ),
        AppField(
          label: 'Email',
          controller: email,
          hint: 'student@lpnu.ua',
          keyboardType: TextInputType.emailAddress,
        ),
        AppField(label: 'Password', controller: password, password: true),
        AppField(
          label: 'Confirm password',
          controller: confirmation,
          password: true,
        ),
        AppButton(
          label: 'Create account',
          onPressed: () {
            final catalog = Catalog();
            final parts = name.text.trim().split(RegExp(r'\s+'));
            if (name.text.trim().isNotEmpty) {
              catalog.firstName = parts.first;
              catalog.lastName = parts.skip(1).join(' ');
            }
            if (email.text.trim().isNotEmpty) {
              catalog.email = email.text.trim();
            }
            Navigator.of(context).pushAndRemoveUntil(
              MaterialPageRoute(builder: (_) => HomeScreen(catalog: catalog)),
              (_) => false,
            );
          },
        ),
      ],
    ),
  );
}
