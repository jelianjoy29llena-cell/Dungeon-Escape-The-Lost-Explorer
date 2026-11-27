
import 'package:flutter/material.dart';
import 'screens/splash_screen.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const DungeonEscapeApp());
}

class DungeonEscapeApp extends StatelessWidget {
  const DungeonEscapeApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Dungeon Escape: The Lost Explorer',
      theme: ThemeData(
        brightness: Brightness.dark,
        useMaterial3: true,
        scaffoldBackgroundColor: const Color(0xFF100E18),
        colorScheme: const ColorScheme.dark(
          primary: Color(0xFFFFC857),
          secondary: Color(0xFFB78BFF),
          surface: Color(0xFF100E18),
        ),
      ),
      home: const SplashScreen(),
    );
  }
}
