import 'package:flutter/material.dart';

import '../theme.dart';

class AppButton extends StatelessWidget {
  const AppButton({
    super.key,
    required this.label,
    required this.onPressed,
    this.color = yellow,
    this.outlined = false,
  });
  final String label;
  final VoidCallback? onPressed;
  final Color color;
  final bool outlined;
  @override
  Widget build(BuildContext context) => SizedBox(
    width: double.infinity,
    height: 50,
    child: FilledButton(
      onPressed: onPressed,
      style: FilledButton.styleFrom(
        backgroundColor: outlined ? fieldColor : color,
        foregroundColor: color == Colors.red ? Colors.white : ink,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
          side: BorderSide(color: outlined ? lineColor : color),
        ),
      ),
      child: Text(label, style: const TextStyle(fontWeight: FontWeight.w600)),
    ),
  );
}

class AppField extends StatelessWidget {
  const AppField({
    super.key,
    required this.label,
    this.controller,
    this.hint,
    this.password = false,
    this.lines = 1,
    this.error,
    this.keyboardType,
  });
  final String label;
  final TextEditingController? controller;
  final String? hint;
  final bool password;
  final int lines;
  final String? error;
  final TextInputType? keyboardType;
  @override
  Widget build(BuildContext context) => Padding(
    padding: const EdgeInsets.only(bottom: 18),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: const TextStyle(fontSize: 13, fontWeight: FontWeight.w600),
        ),
        const SizedBox(height: 8),
        TextField(
          controller: controller,
          obscureText: password,
          maxLines: lines,
          keyboardType: keyboardType,
          decoration: InputDecoration(hintText: hint, errorText: error),
        ),
      ],
    ),
  );
}

class BrandIcon extends StatelessWidget {
  const BrandIcon({
    super.key,
    this.icon = Icons.menu_book_outlined,
    this.size = 56,
  });
  final IconData icon;
  final double size;
  @override
  Widget build(BuildContext context) => Container(
    width: size,
    height: size,
    decoration: BoxDecoration(
      color: const Color(0xFFFFF8C7),
      borderRadius: BorderRadius.circular(16),
    ),
    child: Icon(icon, color: const Color(0xFF8A6117), size: size * .5),
  );
}

class PageBody extends StatelessWidget {
  const PageBody({super.key, required this.children});
  final List<Widget> children;
  @override
  Widget build(BuildContext context) => SafeArea(
    child: SingleChildScrollView(
      padding: const EdgeInsets.all(24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: children,
      ),
    ),
  );
}

void notify(BuildContext context, String message) =>
    ScaffoldMessenger.of(context)
        .showSnackBar(SnackBar(content: Text(message)));
