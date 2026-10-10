import 'package:flutter/material.dart';

import '../core/theme.dart';
import '../core/widgets/app_widgets.dart';
import '../models/catalog.dart';
import 'home_screen.dart';
import 'recovery_screen.dart';
import 'register_screen.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});
  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final email = TextEditingController(text: 'student@lpnu.ua');
  final password = TextEditingController(text: 'password123');
  bool invalid = false;
  @override
  void dispose() {
    email.dispose();
    password.dispose();
    super.dispose();
  }

  void signIn() {
    // Local demonstration only; no authentication request is sent.
    if (password.text == '1234' || password.text.isEmpty) {
      setState(() => invalid = true);
      return;
    }
    final catalog = Catalog();
    if (email.text.trim().isNotEmpty) {
      catalog.email = email.text.trim();
    }
    Navigator.of(context).pushAndRemoveUntil(
      MaterialPageRoute(builder: (_) => HomeScreen(catalog: catalog)),
      (_) => false,
    );
  }

  @override
  Widget build(BuildContext context) => Scaffold(
    body: PageBody(
      children: [
        const SizedBox(height: 24),
        const BrandIcon(),
        const SizedBox(height: 28),
        const Text(
          'Sign in to your account',
          style: TextStyle(fontSize: 25, fontWeight: FontWeight.w800),
        ),
        const SizedBox(height: 8),
        const Text(
          'Enter your details to access the catalog',
          style: TextStyle(color: muted),
        ),
        const SizedBox(height: 32),
        AppField(
          label: 'Email',
          controller: email,
          keyboardType: TextInputType.emailAddress,
        ),
        AppField(
          label: 'Password',
          controller: password,
          password: true,
          error: invalid
              ? 'Incorrect password or account does not exist'
              : null,
        ),
        Align(
          alignment: Alignment.centerRight,
          child: TextButton(
            onPressed: () => Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const RecoveryScreen()),
            ),
            child: const Text(
              'Forgot password?',
              style: TextStyle(color: Color(0xFF8A6117)),
            ),
          ),
        ),
        const SizedBox(height: 20),
        AppButton(label: 'Sign in', onPressed: signIn),
        const SizedBox(height: 12),
        Center(
          child: TextButton(
            onPressed: () => Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const RegisterScreen()),
            ),
            child: const Text(
              'Create an account',
              style: TextStyle(color: ink),
            ),
          ),
        ),
      ],
    ),
  );
}
