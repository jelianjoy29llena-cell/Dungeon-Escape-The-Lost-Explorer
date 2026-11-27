
import 'package:flutter/material.dart';

class PauseScreen extends StatelessWidget {
  final VoidCallback onResume;
  final VoidCallback onRestart;
  final VoidCallback onMainMenu;

  const PauseScreen({
    super.key,
    required this.onResume,
    required this.onRestart,
    required this.onMainMenu,
  });

  static const Color backgroundColor = Color(0xFF100E18);
  static const Color panelColor = Color(0xFF211B32);
  static const Color goldColor = Color(0xFFFFC857);

  Widget _menuButton({
    required String label,
    required IconData icon,
    required VoidCallback onPressed,
    bool primary = false,
  }) {
    return SizedBox(
      width: double.infinity,
      height: 52,
      child: FilledButton.icon(
        onPressed: onPressed,
        icon: Icon(icon),
        label: Text(
          label,
          style: const TextStyle(
            fontWeight: FontWeight.bold,
            letterSpacing: 1,
          ),
        ),
        style: FilledButton.styleFrom(
          backgroundColor:
              primary ? goldColor : const Color(0xFF493765),
          foregroundColor:
              primary ? backgroundColor : Colors.white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(14),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundColor,
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(28),
            child: Container(
              width: double.infinity,
              padding: const EdgeInsets.all(25),
              decoration: BoxDecoration(
                color: panelColor,
                borderRadius: BorderRadius.circular(24),
                border: Border.all(
                  color: goldColor.withValues(alpha: 0.45),
                  width: 1.5,
                ),
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Icon(
                    Icons.pause_circle_filled,
                    size: 85,
                    color: goldColor,
                  ),

                  const SizedBox(height: 15),

                  const Text(
                    'GAME PAUSED',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: goldColor,
                      fontSize: 27,
                      fontWeight: FontWeight.bold,
                      letterSpacing: 2,
                    ),
                  ),

                  const SizedBox(height: 8),

                  const Text(
                    'Take a break, explorer!',
                    style: TextStyle(
                      color: Colors.white70,
                      fontSize: 14,
                    ),
                  ),

                  const SizedBox(height: 35),

                  _menuButton(
                    label: 'RESUME GAME',
                    icon: Icons.play_arrow,
                    onPressed: onResume,
                    primary: true,
                  ),

                  const SizedBox(height: 14),

                  _menuButton(
                    label: 'RESTART LEVEL',
                    icon: Icons.refresh,
                    onPressed: onRestart,
                  ),

                  const SizedBox(height: 14),

                  _menuButton(
                    label: 'MAIN MENU',
                    icon: Icons.home,
                    onPressed: onMainMenu,
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
