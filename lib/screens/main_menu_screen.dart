
import 'package:flutter/material.dart';

class MainMenuScreen extends StatelessWidget {
  final VoidCallback? onStartAdventure;
  final VoidCallback? onHowToPlay;
  final VoidCallback? onSettings;

  const MainMenuScreen({
    super.key,
    this.onStartAdventure,
    this.onHowToPlay,
    this.onSettings,
  });

  static const Color backgroundColor = Color(0xFF100E18);
  static const Color goldColor = Color(0xFFFFC857);
  static const Color purpleColor = Color(0xFF302044);
  static const Color textColor = Color(0xFFF5EBD7);

  void _showComingSoon(BuildContext context, String feature) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('$feature screen is coming soon!'),
        backgroundColor: purpleColor,
      ),
    );
  }

  Widget _menuButton({
    required String title,
    required IconData icon,
    required VoidCallback onPressed,
    bool primary = false,
  }) {
    return SizedBox(
      width: double.infinity,
      height: 58,
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: primary ? goldColor : purpleColor,
          foregroundColor: primary ? backgroundColor : textColor,
          elevation: primary ? 6 : 2,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(14),
            side: primary
                ? BorderSide.none
                : BorderSide(
                    color: goldColor.withValues(alpha: 0.35),
                  ),
          ),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, size: 21),
            const SizedBox(width: 12),
            Text(
              title,
              style: const TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w900,
                letterSpacing: 1.5,
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundColor,
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Color(0xFF302044),
              Color(0xFF191322),
              backgroundColor,
            ],
          ),
        ),
        child: SafeArea(
          child: Center(
            child: SingleChildScrollView(
              padding: const EdgeInsets.symmetric(
                horizontal: 30,
                vertical: 25,
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  // GAME LOGO
                  Container(
                    height: 190,
                    width: 190,
                    decoration: BoxDecoration(
                      color: const Color(0xFF211A30),
                      borderRadius: BorderRadius.circular(35),
                      border: Border.all(
                        color: goldColor.withValues(alpha: 0.5),
                        width: 2,
                      ),
                      boxShadow: [
                        BoxShadow(
                          color: goldColor.withValues(alpha: 0.12),
                          blurRadius: 30,
                          spreadRadius: 5,
                        ),
                      ],
                    ),
                    child: const Icon(
                      Icons.explore,
                      color: goldColor,
                      size: 105,
                    ),
                  ),

                  const SizedBox(height: 28),

                  // GAME TITLE
                  const Text(
                    'DUNGEON',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: textColor,
                      fontSize: 38,
                      fontWeight: FontWeight.w900,
                      letterSpacing: 5,
                    ),
                  ),

                  const Text(
                    'ESCAPE',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: goldColor,
                      fontSize: 38,
                      fontWeight: FontWeight.w900,
                      letterSpacing: 7,
                    ),
                  ),

                  const SizedBox(height: 10),

                  const Text(
                    'THE LOST EXPLORER',
                    style: TextStyle(
                      color: Colors.white60,
                      fontSize: 11,
                      fontWeight: FontWeight.bold,
                      letterSpacing: 3,
                    ),
                  ),

                  const SizedBox(height: 45),

                  // START ADVENTURE
                  _menuButton(
                    title: 'START ADVENTURE',
                    icon: Icons.play_arrow,
                    primary: true,
                    onPressed: onStartAdventure ??
                        () => _showComingSoon(
                              context,
                              'Level Selection',
                            ),
                  ),

                  const SizedBox(height: 15),

                  // HOW TO PLAY
                  _menuButton(
                    title: 'HOW TO PLAY',
                    icon: Icons.menu_book,
                    onPressed: onHowToPlay ??
                        () => _showComingSoon(
                              context,
                              'How to Play',
                            ),
                  ),

                  const SizedBox(height: 15),

                  // SETTINGS
                  _menuButton(
                    title: 'SETTINGS',
                    icon: Icons.settings,
                    onPressed: onSettings ??
                        () => _showComingSoon(
                              context,
                              'Settings',
                            ),
                  ),

                  const SizedBox(height: 30),

                  const Text(
                    'OFFLINE • SINGLE PLAYER',
                    style: TextStyle(
                      color: Colors.white38,
                      fontSize: 10,
                      letterSpacing: 2,
                    ),
                  ),

                  const SizedBox(height: 8),

                  const Text(
                    'VERSION 1.0.0',
                    style: TextStyle(
                      color: Colors.white24,
                      fontSize: 9,
                      letterSpacing: 1,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
