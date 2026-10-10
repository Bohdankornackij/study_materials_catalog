import 'package:flutter/material.dart';

import 'core/theme.dart';
import 'screens/welcome_screen.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) => MaterialApp(
    title: 'StudyHub',
    debugShowCheckedModeBanner: false,
    theme: appTheme,
    home: const WelcomeScreen(),
  );
}
