
import 'package:flutter/material.dart';

class GameOverScreen extends StatelessWidget {
  final int levelNumber;
  final int finalScore;

  final VoidCallback onRetry;
  final VoidCallback onLevelSelection;
  final VoidCallback onMainMenu;

  const GameOverScreen({
    super.key,
    required this.levelNumber,
    required this.finalScore,
    required this.onRetry,
    required this.onLevelSelection,
    required this.onMainMenu,
  });

  static const Color backgroundColor = Color(0xFF100E18);
  static const Color panelColor = Color(0xFF211B32);
  static const Color redColor = Color(0xFFFF5C68);
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
              primary ? redColor : const Color(0xFF493765),
          foregroundColor: Colors.white,
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
            padding: const EdgeInsets.all(25),
            child: Container(
              width: double.infinity,
              padding: const EdgeInsets.all(25),
              decoration: BoxDecoration(
                color: panelColor,
                borderRadius: BorderRadius.circular(24),
                border: Border.all(
                  color: redColor.withValues(alpha: 0.5),
                  width: 1.5,
                ),
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Icon(
                    Icons.heart_broken,
                    color: redColor,
                    size: 90,
                  ),

                  const SizedBox(height: 18),

                  const Text(
                    'GAME OVER',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: redColor,
                      fontSize: 32,
                      fontWeight: FontWeight.bold,
                      letterSpacing: 2,
                    ),
                  ),

                  const SizedBox(height: 10),

                  const Text(
                    'Your adventure has ended.',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Colors.white70,
                      fontSize: 15,
                    ),
                  ),

                  const SizedBox(height: 25),

                  Container(
                    width: double.infinity,
                    padding: const EdgeInsets.all(18),
                    decoration: BoxDecoration(
                      color: backgroundColor,
                      borderRadius: BorderRadius.circular(15),
                    ),
                    child: Column(
                      children: [
                        const Text(
                          'YOUR RESULTS',
                          style: TextStyle(
                            color: goldColor,
                            fontWeight: FontWeight.bold,
                            letterSpacing: 1.5,
                          ),
                        ),

                        const SizedBox(height: 18),

                        Row(
                          mainAxisAlignment:
                              MainAxisAlignment.spaceBetween,
                          children: [
                            const Text(
                              'Level Reached',
                              style: TextStyle(color: Colors.white70),
                            ),
                            Text(
                              '$levelNumber',
                              style: const TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),

                        const SizedBox(height: 14),

                        Row(
                          mainAxisAlignment:
                              MainAxisAlignment.spaceBetween,
                          children: [
                            const Text(
                              'Final Score',
                              style: TextStyle(color: Colors.white70),
                            ),
                            Text(
                              '$finalScore',
                              style: const TextStyle(
                                color: goldColor,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),

                  const SizedBox(height: 25),

                  _actionButton(
                    label: 'TRY AGAIN',
                    icon: Icons.refresh,
                    onPressed: onRetry,
                    primary: true,
                  ),

                  const SizedBox(height: 12),

                  _actionButton(
                    label: 'LEVEL SELECTION',
                    icon: Icons.grid_view,
                    onPressed: onLevelSelection,
                  ),

                  const SizedBox(height: 12),

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
