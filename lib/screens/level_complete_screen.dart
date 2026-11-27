
import 'package:flutter/material.dart';

class LevelCompleteScreen extends StatelessWidget {
  final int levelNumber;
  final String levelName;
  final int score;
  final int remainingHearts;

  final VoidCallback onContinue;
  final VoidCallback onReplay;
  final VoidCallback onMainMenu;

  const LevelCompleteScreen({
    super.key,
    required this.levelNumber,
    required this.levelName,
    required this.score,
    required this.remainingHearts,
    required this.onContinue,
    required this.onReplay,
    required this.onMainMenu,
  });

  static const Color backgroundColor = Color(0xFF100E18);
  static const Color panelColor = Color(0xFF211B32);
  static const Color goldColor = Color(0xFFFFC857);

  Widget _resultRow(String label, String value, IconData icon) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 9),
      child: Row(
        children: [
          Icon(icon, color: goldColor, size: 22),
          const SizedBox(width: 12),
          Expanded(
            child: Text(
              label,
              style: const TextStyle(
                color: Colors.white70,
                fontSize: 14,
              ),
            ),
          ),
          Text(
            value,
            style: const TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
              fontSize: 15,
            ),
          ),
        ],
      ),
    );
  }

  Widget _actionButton({
    required String label,
    required IconData icon,
    required VoidCallback onPressed,
    bool primary = false,
  }) {
    return SizedBox(
      width: double.infinity,
      height: 50,
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
            borderRadius: BorderRadius.circular(13),
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
              padding: const EdgeInsets.all(24),
              decoration: BoxDecoration(
                color: panelColor,
                borderRadius: BorderRadius.circular(24),
                border: Border.all(
                  color: goldColor.withValues(alpha: 0.5),
                  width: 1.5,
                ),
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Icon(
                    Icons.emoji_events,
                    color: goldColor,
                    size: 90,
                  ),

                  const SizedBox(height: 15),

                  const Text(
                    'LEVEL COMPLETE!',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: goldColor,
                      fontSize: 27,
                      fontWeight: FontWeight.bold,
                      letterSpacing: 1.5,
                    ),
                  ),

                  const SizedBox(height: 8),

                  Text(
                    levelName,
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                      color: Colors.white70,
                      fontSize: 16,
                    ),
                  ),

                  const SizedBox(height: 25),

                  Container(
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: backgroundColor,
                      borderRadius: BorderRadius.circular(16),
                    ),
                    child: Column(
                      children: [
                        _resultRow(
                          'Level',
                          '$levelNumber',
                          Icons.flag,
                        ),
                        _resultRow(
                          'Final Score',
                          '$score',
                          Icons.stars,
                        ),
                        _resultRow(
                          'Remaining Hearts',
                          '$remainingHearts / 5',
                          Icons.favorite,
                        ),
                      ],
                    ),
                  ),

                  const SizedBox(height: 25),

                  _actionButton(
                    label: 'CONTINUE',
                    icon: Icons.arrow_forward,
                    onPressed: onContinue,
                    primary: true,
                  ),

                  const SizedBox(height: 12),

                  _actionButton(
                    label: 'REPLAY LEVEL',
                    icon: Icons.refresh,
                    onPressed: onReplay,
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
