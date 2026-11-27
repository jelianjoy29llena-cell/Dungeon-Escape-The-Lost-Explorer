
import 'package:flutter/material.dart';

class LevelSelectionScreen extends StatelessWidget {
  final int unlockedLevel;
  final Function(int) onLevelSelected;

  const LevelSelectionScreen({
    super.key,
    this.unlockedLevel = 1,
    required this.onLevelSelected,
  });

  static const Color backgroundColor = Color(0xFF100E18);
  static const Color goldColor = Color(0xFFFFC857);
  static const Color textColor = Color(0xFFF5EBD7);

  static const List<Map<String, dynamic>> levels = [
    {
      'number': 1,
      'name': 'FORGOTTEN ENTRANCE',
      'difficulty': 'EASY',
      'description':
          'Begin your journey and explore the forgotten dungeon.',
      'icon': Icons.door_front_door,
      'color': Color(0xFF70C88A),
    },
    {
      'number': 2,
      'name': 'CRYSTAL CAVERNS',
      'difficulty': 'MEDIUM',
      'description':
          'Discover mysterious crystals and shifting walls.',
      'icon': Icons.diamond,
      'color': Color(0xFFB78BFF),
    },
    {
      'number': 3,
      'name': 'LOST KINGDOM',
      'difficulty': 'HARD',
      'description':
          'Face the final challenge of the Lost Kingdom.',
      'icon': Icons.castle,
      'color': Color(0xFFFF8B70),
    },
  ];

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
                  horizontal: 20,
                  vertical: 15,
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
                        'SELECT YOUR LEVEL',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: goldColor,
                          fontSize: 17,
                          fontWeight: FontWeight.w900,
                          letterSpacing: 2,
                        ),
                      ),
                    ),
                    const SizedBox(width: 48),
                  ],
                ),
              ),

              const SizedBox(height: 15),

              const Text(
                'CHOOSE YOUR DUNGEON',
                style: TextStyle(
                  color: textColor,
                  fontSize: 21,
                  fontWeight: FontWeight.bold,
                  letterSpacing: 1,
                ),
              ),

              const SizedBox(height: 8),

              const Text(
                'Complete each level to unlock the next.',
                style: TextStyle(
                  color: Colors.white60,
                  fontSize: 12,
                ),
              ),

              const SizedBox(height: 25),

              // LEVEL CARDS
              Expanded(
                child: ListView.builder(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 22,
                    vertical: 8,
                  ),
                  itemCount: levels.length,
                  itemBuilder: (context, index) {
                    final level = levels[index];
                    final int number = level['number'] as int;
                    final bool isUnlocked =
                        number <= unlockedLevel;
                    final Color levelColor =
                        level['color'] as Color;

                    return Container(
                      margin: const EdgeInsets.only(
                        bottom: 18,
                      ),
                      decoration: BoxDecoration(
                        color: const Color(0xFF211A30),
                        borderRadius: BorderRadius.circular(18),
                        border: Border.all(
                          color: isUnlocked
                              ? levelColor.withValues(alpha: 0.65)
                              : Colors.white12,
                          width: 1.5,
                        ),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(18),
                        child: Row(
                          children: [
                            // LEVEL ICON
                            Container(
                              height: 75,
                              width: 75,
                              decoration: BoxDecoration(
                                color: isUnlocked
                                    ? levelColor.withValues(
                                        alpha: 0.15,
                                      )
                                    : Colors.white10,
                                borderRadius:
                                    BorderRadius.circular(15),
                              ),
                              child: Icon(
                                isUnlocked
                                    ? level['icon'] as IconData
                                    : Icons.lock,
                                color: isUnlocked
                                    ? levelColor
                                    : Colors.white38,
                                size: 35,
                              ),
                            ),

                            const SizedBox(width: 15),

                            // LEVEL DETAILS
                            Expanded(
                              child: Column(
                                crossAxisAlignment:
                                    CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    'LEVEL $number',
                                    style: const TextStyle(
                                      color: Colors.white54,
                                      fontSize: 10,
                                      fontWeight: FontWeight.bold,
                                      letterSpacing: 1,
                                    ),
                                  ),

                                  const SizedBox(height: 5),

                                  Text(
                                    level['name'] as String,
                                    style: TextStyle(
                                      color: isUnlocked
                                          ? textColor
                                          : Colors.white38,
                                      fontSize: 13,
                                      fontWeight:
                                          FontWeight.w900,
                                    ),
                                  ),

                                  const SizedBox(height: 5),

                                  Text(
                                    level['difficulty'] as String,
                                    style: TextStyle(
                                      color: isUnlocked
                                          ? levelColor
                                          : Colors.white30,
                                      fontSize: 10,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),

                                  const SizedBox(height: 7),

                                  Text(
                                    level['description'] as String,
                                    style: const TextStyle(
                                      color: Colors.white54,
                                      fontSize: 10,
                                      height: 1.4,
                                    ),
                                  ),
                                ],
                              ),
                            ),

                            const SizedBox(width: 8),

                            // PLAY / LOCK BUTTON
                            IconButton(
                              onPressed: isUnlocked
                                  ? () => onLevelSelected(number)
                                  : null,
                              icon: Icon(
                                isUnlocked
                                    ? Icons.play_circle_fill
                                    : Icons.lock,
                                color: isUnlocked
                                    ? goldColor
                                    : Colors.white24,
                                size: 32,
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                ),
              ),

              const Padding(
                padding: EdgeInsets.only(bottom: 18),
                child: Text(
                  'YOUR ADVENTURE STARTS HERE',
                  style: TextStyle(
                    color: Colors.white30,
                    fontSize: 9,
                    letterSpacing: 2,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
