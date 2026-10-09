import 'package:flutter/material.dart';

import '../core/widgets/app_widgets.dart';

class ChangePasswordScreen extends StatefulWidget {
  const ChangePasswordScreen({super.key});
  @override
  State<ChangePasswordScreen> createState() => _ChangePasswordScreenState();
}

class _ChangePasswordScreenState extends State<ChangePasswordScreen> {
  final current = TextEditingController();
  final password = TextEditingController();
  final confirmation = TextEditingController();
  @override
  void dispose() {
    current.dispose();
    password.dispose();
    confirmation.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) => Scaffold(
    appBar: AppBar(title: const Text('Change Password')),
    body: PageBody(
      children: [
        const BrandIcon(icon: Icons.lock_outline),
        const SizedBox(height: 28),
        AppField(
          label: 'Current password',
          controller: current,
          password: true,
        ),
        AppField(label: 'New password', controller: password, password: true),
        AppField(
          label: 'Confirm new password',
          controller: confirmation,
          password: true,
        ),
        AppButton(
          label: 'Save password',
          onPressed: () {
            notify(
              context,
              'Demo: password change requested. No account password was changed.',
            );
          },
        ),
      ],
    ),
  );
}
