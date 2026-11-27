
import 'package:flutter/material.dart';

class HowToPlayScreen extends StatelessWidget {
  const HowToPlayScreen({super.key});

  static const Color backgroundColor = Color(0xFF100E18);
  static const Color goldColor = Color(0xFFFFC857);
  static const Color textColor = Color(0xFFF5EBD7);
  static const Color cardColor = Color(0xFF211A30);

  Widget _instructionCard({
    required IconData icon,
    required String title,
    required String description,
    required Color color,
  }) {
    return Container(
      margin: const EdgeInsets.only(bottom: 14),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: cardColor,
        borderRadius: BorderRadius.circular(15),
        border: Border.all(
          color: color.withValues(alpha: 0.35),
        ),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            height: 48,
            width: 48,
            decoration: BoxDecoration(
              color: color.withValues(alpha: 0.15),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Icon(
              icon,
              color: color,
              size: 26,
            ),
          ),
          const SizedBox(width: 14),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    color: textColor,
                    fontSize: 14,
                    fontWeight: FontWeight.w900,
                  ),
                ),
                const SizedBox(height: 6),
                Text(
                  description,
                  style: const TextStyle(
                    color: Colors.white60,
                    fontSize: 12,
                    height: 1.6,
                  ),
                ),
              ],
            ),
          ),
        ],
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
          child: Column(
            children: [
              // TOP BAR
              Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: 12,
                ),
                child: Row(
                  children: [
                    IconButton(
                      onPressed: () => Navigator.pop(context),
                      icon: const Icon(
                        Icons.arrow_back,
                        color: textColor,
                      ),
                    ),
                    const Expanded(
                      child: Text(
                        'HOW TO PLAY',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: goldColor,
                          fontSize: 18,
                          fontWeight: FontWeight.w900,
                          letterSpacing: 2,
                        ),
                      ),
                    ),
                    const SizedBox(width: 48),
                  ],
                ),
              ),

              // CONTENT
              Expanded(
                child: SingleChildScrollView(
                  padding: const EdgeInsets.fromLTRB(
                    22,
                    12,
                    22,
                    25,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Center(
                        child: Icon(
                          Icons.menu_book,
                          color: goldColor,
                          size: 65,
                        ),
                      ),

                      const SizedBox(height: 12),

                      const Center(
                        child: Text(
                          'LEARN THE BASICS',
                          style: TextStyle(
                            color: textColor,
                            fontSize: 19,
                            fontWeight: FontWeight.w900,
                            letterSpacing: 1,
                          ),
                        ),
                      ),

                      const SizedBox(height: 8),

                      const Center(
                        child: Text(
                          'Follow these instructions to escape the dungeon.',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: Colors.white60,
                            fontSize: 12,
                            height: 1.5,
                          ),
                        ),
                      ),

                      const SizedBox(height: 28),

                      const Text(
                        'GAME INSTRUCTIONS',
                        style: TextStyle(
                          color: goldColor,
                          fontSize: 12,
                          fontWeight: FontWeight.bold,
                          letterSpacing: 2,
                        ),
                      ),

                      const SizedBox(height: 15),

                      _instructionCard(
                        icon: Icons.gamepad,
                        title: 'MOVE YOUR CHARACTER',
                        description:
                            'Use the on-screen directional controls '
                            'to move around the dungeon and explore '
                            'different paths.',
                        color: const Color(0xFF70C88A),
                      ),

                      _instructionCard(
                        icon: Icons.key,
                        title: 'FIND THE GOLDEN KEY',
                        description:
                            'Explore the dungeon and collect the key. '
                            'You need it to unlock the exit.',
                        color: goldColor,
                      ),

                      _instructionCard(
                        icon: Icons.card_giftcard,
                        title: 'COLLECT TREASURES',
                        description:
                            'Collect treasures along your journey. '
                            'Each treasure gives you 50 points.',
                        color: const Color(0xFFFFD166),
                      ),

                      _instructionCard(
                        icon: Icons.favorite,
                        title: 'PROTECT YOUR FIVE HEARTS',
                        description:
                            'You start with five hearts. Avoid traps '
                            'because each trap hit removes one heart. '
                            'Losing all five hearts ends the game.',
                        color: const Color(0xFFFF6B81),
                      ),

                      _instructionCard(
                        icon: Icons.diamond,
                        title: 'DISCOVER THE MYSTERIOUS CRYSTAL',
                        description:
                            'Collect the special crystal to earn '
                            '100 points and shift selected dungeon '
                            'walls to reveal a new path.',
                        color: const Color(0xFFB78BFF),
                      ),

                      _instructionCard(
                        icon: Icons.exit_to_app,
                        title: 'REACH THE EXIT',
                        description:
                            'After collecting the key, find the exit '
                            'to complete the level and unlock the '
                            'next dungeon.',
                        color: const Color(0xFF70C88A),
                      ),

                      const SizedBox(height: 12),

                      // SCORING
                      Container(
                        width: double.infinity,
                        padding: const EdgeInsets.all(18),
                        decoration: BoxDecoration(
                          color: const Color(0xFF302044),
                          borderRadius: BorderRadius.circular(15),
                          border: Border.all(
                            color: goldColor.withValues(alpha: 0.5),
                          ),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text(
                              'SCORING SYSTEM',
                              style: TextStyle(
                                color: goldColor,
                                fontSize: 13,
                                fontWeight: FontWeight.w900,
                                letterSpacing: 1.5,
                              ),
                            ),

                            const SizedBox(height: 14),

                            _scoreRow('Treasure collected', '+50 points'),
                            _scoreRow('Special crystal', '+100 points'),
                            _scoreRow(
                              'Level completion',
                              '+50 per remaining heart',
                            ),
                          ],
                        ),
                      ),

                      const SizedBox(height: 20),

                      const Center(
                        child: Text(
                          'GOOD LUCK, EXPLORER!',
                          style: TextStyle(
                            color: goldColor,
                            fontSize: 13,
                            fontWeight: FontWeight.w900,
                            letterSpacing: 2,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _scoreRow(String label, String points) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            child: Text(
              label,
              style: const TextStyle(
                color: Colors.white70,
                fontSize: 12,
              ),
            ),
          ),
          Text(
            points,
            style: const TextStyle(
              color: goldColor,
              fontSize: 12,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }
}
