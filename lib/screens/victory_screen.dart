
import 'package:flutter/material.dart';

class VictoryScreen extends StatelessWidget {
  final int totalScore;
  final VoidCallback onPlayAgain;
  final VoidCallback onMainMenu;

  const VictoryScreen({
    super.key,
    required this.totalScore,
    required this.onPlayAgain,
    required this.onMainMenu,
  });

  static const Color backgroundColor = Color(0xFF100E18);
  static const Color panelColor = Color(0xFF211B32);
  static const Color goldColor = Color(0xFFFFC857);

  Widget _actionButton({
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
            padding: const EdgeInsets.all(24),
            child: Container(
              width: double.infinity,
              padding: const EdgeInsets.all(25),
              decoration: BoxDecoration(
                color: panelColor,
                borderRadius: BorderRadius.circular(25),
                border: Border.all(
                  color: goldColor.withValues(alpha: 0.6),
                  width: 2,
                ),
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Icon(
                    Icons.emoji_events,
                    size: 105,
                    color: goldColor,
                  ),

                  const SizedBox(height: 18),

                  const Text(
                    'VICTORY!',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: goldColor,
                      fontSize: 36,
                      fontWeight: FontWeight.bold,
                      letterSpacing: 3,
                    ),
                  ),

                  const SizedBox(height: 12),

                  const Text(
                    'THE LOST EXPLORER',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 17,
                      fontWeight: FontWeight.bold,
                      letterSpacing: 2,
                    ),
                  ),

                  const SizedBox(height: 15),

                  const Text(
                    'Congratulations, explorer!\n'
                    'You have conquered all three dungeons '
                    'and completed your adventure!',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Colors.white70,
                      fontSize: 14,
                      height: 1.6,
                    ),
                  ),

                  const SizedBox(height: 28),

                  Container(
                    width: double.infinity,
                    padding: const EdgeInsets.all(22),
                    decoration: BoxDecoration(
                      color: backgroundColor,
                      borderRadius: BorderRadius.circular(18),
                    ),
                    child: Column(
                      children: [
                        const Icon(
                          Icons.stars,
                          color: goldColor,
                          size: 35,
                        ),

                        const SizedBox(height: 8),

                        const Text(
                          'TOTAL ADVENTURE SCORE',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: Colors.white70,
                            fontSize: 12,
                            letterSpacing: 1,
                          ),
                        ),

                        const SizedBox(height: 8),

                        Text(
                          '$totalScore',
                          style: const TextStyle(
                            color: goldColor,
                            fontSize: 34,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ),

                  const SizedBox(height: 28),

                  _actionButton(
                    label: 'PLAY AGAIN',
                    icon: Icons.replay,
                    onPressed: onPlayAgain,
                    primary: true,
                  ),

                  const SizedBox(height: 13),

                  _actionButton(
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

