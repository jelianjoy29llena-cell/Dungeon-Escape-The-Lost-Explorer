
import 'package:flutter/material.dart';

class GameplayScreen extends StatefulWidget {
  const GameplayScreen({super.key});

  @override
  State<GameplayScreen> createState() => _GameplayScreenState();
}

class _GameplayScreenState extends State<GameplayScreen> {
  static const int rows = 11;
  static const int columns = 13;

  final List<String> originalMap = [
    '#############',
    '#P....#.....#',
    '#.#...#.#...#',
    '#.#.......#.#',
    '#.###.###.#.#',
    '#..T..#...#.#',
    '###.#.#.###.#',
    '#...#.....K.#',
    '#.#.###.#...#',
    '#.....X...E.#',
    '#############',
  ];

  late List<List<String>> map;

  int playerRow = 1;
  int playerCol = 1;
  int hearts = 5;
  int score = 0;

  bool hasKey = false;
  bool gameEnded = false;

  @override
  void initState() {
    super.initState();
    _resetGame();
  }

  void _resetGame() {
    map = originalMap.map((row) => row.split('')).toList();

    playerRow = 1;
    playerCol = 1;
    hearts = 5;
    score = 0;
    hasKey = false;
    gameEnded = false;

    if (mounted) setState(() {});
  }

  void _movePlayer(int rowChange, int colChange) {
    if (gameEnded) return;

    final nextRow = playerRow + rowChange;
    final nextCol = playerCol + colChange;

    if (nextRow < 0 ||
        nextRow >= rows ||
        nextCol < 0 ||
        nextCol >= columns) {
      return;
    }

    final tile = map[nextRow][nextCol];

    // Collision with walls
    if (tile == '#') return;

    // Exit requires the key
    if (tile == 'E' && !hasKey) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('You need the key to unlock the exit!'),
          duration: Duration(milliseconds: 900),
        ),
      );
      return;
    }

    setState(() {
      playerRow = nextRow;
      playerCol = nextCol;

      if (tile == 'K') {
        hasKey = true;
        map[nextRow][nextCol] = '.';
        score += 100;
      } else if (tile == 'T') {
        map[nextRow][nextCol] = '.';
        score += 50;
      } else if (tile == 'X') {
        map[nextRow][nextCol] = '.';
        hearts--;

        if (hearts <= 0) {
          hearts = 0;
          gameEnded = true;
        }
      } else if (tile == 'E' && hasKey) {
        score += hearts * 50;
        gameEnded = true;
      }
    });

    if (gameEnded) {
      if (hearts <= 0) {
        _showGameOverDialog();
      } else {
        _showLevelCompleteDialog();
      }
    }
  }

  void _showGameOverDialog() {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (dialogContext) => AlertDialog(
        backgroundColor: const Color(0xFF211B32),
        title: const Text(
          'GAME OVER',
          style: TextStyle(
            color: Colors.redAccent,
            fontWeight: FontWeight.bold,
          ),
        ),
        content: const Text(
          'You ran out of hearts. Try again, explorer!',
          style: TextStyle(color: Colors.white),
        ),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.pop(dialogContext);
              _resetGame();
            },
            child: const Text('TRY AGAIN'),
          ),
          TextButton(
            onPressed: () {
              Navigator.pop(dialogContext);
              Navigator.pop(context);
            },
            child: const Text('MAIN MENU'),
          ),
        ],
      ),
    );
  }

  void _showLevelCompleteDialog() {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (dialogContext) => AlertDialog(
        backgroundColor: const Color(0xFF211B32),
        title: const Text(
          'LEVEL COMPLETE!',
          style: TextStyle(
            color: Color(0xFFFFC857),
            fontWeight: FontWeight.bold,
          ),
        ),
        content: Text(
          'You escaped the Forgotten Entrance!\n\n'
          'Final Score: $score',
          style: const TextStyle(color: Colors.white),
        ),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.pop(dialogContext);
              Navigator.pop(context);
            },
            child: const Text('BACK TO LEVELS'),
          ),
        ],
      ),
    );
  }

  Widget _controlButton(
    IconData icon,
    int rowChange,
    int colChange,
  ) {
    return SizedBox(
      width: 58,
      height: 52,
      child: FilledButton(
        style: FilledButton.styleFrom(
          backgroundColor: const Color(0xFF493765),
          foregroundColor: const Color(0xFFFFC857),
          padding: EdgeInsets.zero,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
            side: const BorderSide(color: Color(0xFF8063A8)),
          ),
        ),
        onPressed: gameEnded
            ? null
            : () => _movePlayer(rowChange, colChange),
        child: Icon(icon, size: 27),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF100E18),
      appBar: AppBar(
        backgroundColor: const Color(0xFF211B32),
        foregroundColor: Colors.white,
        title: const Text(
          'FORGOTTEN ENTRANCE',
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
            letterSpacing: 1,
          ),
        ),
        leading: IconButton(
          icon: const Icon(Icons.pause_circle_outline),
          onPressed: () {
            showDialog(
              context: context,
              builder: (dialogContext) => AlertDialog(
                backgroundColor: const Color(0xFF211B32),
                title: const Text(
                  'PAUSED',
                  style: TextStyle(color: Color(0xFFFFC857)),
                ),
                content: const Text(
                  'Game is paused.',
                  style: TextStyle(color: Colors.white),
                ),
                actions: [
                  TextButton(
                    onPressed: () => Navigator.pop(dialogContext),
                    child: const Text('RESUME'),
                  ),
                  TextButton(
                    onPressed: () {
                      Navigator.pop(dialogContext);
                      Navigator.pop(context);
                    },
                    child: const Text('QUIT'),
                  ),
                ],
              ),
            );
          },
        ),
      ),
      body: SafeArea(
        child: Column(
          children: [
            const SizedBox(height: 12),

            // HUD
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 18),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      const Icon(
                        Icons.favorite,
                        color: Colors.redAccent,
                      ),
                      const SizedBox(width: 6),
                      Text(
                        '$hearts / 5',
                        style: const TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      const Icon(
                        Icons.stars,
                        color: Color(0xFFFFC857),
                      ),
                      const SizedBox(width: 6),
                      Text(
                        '$score',
                        style: const TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      Icon(
                        Icons.vpn_key,
                        color: hasKey
                            ? const Color(0xFFFFC857)
                            : Colors.grey,
                      ),
                      const SizedBox(width: 5),
                      Text(
                        hasKey ? 'KEY FOUND' : 'NO KEY',
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 11,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),

            const SizedBox(height: 12),

            const Text(
              'Find the key and reach the exit!',
              style: TextStyle(
                color: Colors.white70,
                fontSize: 13,
              ),
            ),

            const SizedBox(height: 12),

            // Dungeon map
            Expanded(
              child: Center(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8),
                  child: AspectRatio(
                    aspectRatio: columns / rows,
                    child: CustomPaint(
                      painter: DungeonPainter(
                        map: map,
                        playerRow: playerRow,
                        playerCol: playerCol,
                      ),
                      child: const SizedBox.expand(),
                    ),
                  ),
                ),
              ),
            ),

            const SizedBox(height: 8),

            // Directional controls
            Column(
              children: [
                _controlButton(
                  Icons.keyboard_arrow_up,
                  -1,
                  0,
                ),
                const SizedBox(height: 5),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    _controlButton(
                      Icons.keyboard_arrow_left,
                      0,
                      -1,
                    ),
                    const SizedBox(width: 65),
                    _controlButton(
                      Icons.keyboard_arrow_right,
                      0,
                      1,
                    ),
                  ],
                ),
                const SizedBox(height: 5),
                _controlButton(
                  Icons.keyboard_arrow_down,
                  1,
                  0,
                ),
              ],
            ),

            const SizedBox(height: 15),
          ],
        ),
      ),
    );
  }
}

class DungeonPainter extends CustomPainter {
  final List<List<String>> map;
  final int playerRow;
  final int playerCol;

  DungeonPainter({
    required this.map,
    required this.playerRow,
    required this.playerCol,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final tileWidth = size.width / 13;
    final tileHeight = size.height / 11;

    final wallPaint = Paint()
      ..color = const Color(0xFF493765);

    final floorPaint = Paint()
      ..color = const Color(0xFF211B32);

    final gridPaint = Paint()
      ..color = const Color(0xFF352A48)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1;

    for (int row = 0; row < 11; row++) {
      for (int col = 0; col < 13; col++) {
        final tile = map[row][col];

        final rect = Rect.fromLTWH(
          col * tileWidth,
          row * tileHeight,
          tileWidth,
          tileHeight,
        );

        canvas.drawRect(
          rect,
          tile == '#' ? wallPaint : floorPaint,
        );

        canvas.drawRect(rect, gridPaint);

        String? symbol;
        Color? symbolColor;

        if (tile == 'K') {
          symbol = 'K';
          symbolColor = const Color(0xFFFFC857);
        } else if (tile == 'T') {
          symbol = '★';
          symbolColor = Colors.amber;
        } else if (tile == 'X') {
          symbol = '!';
          symbolColor = Colors.redAccent;
        } else if (tile == 'E') {
          symbol = 'E';
          symbolColor = Colors.greenAccent;
        }

        if (symbol != null) {
          _drawText(
            canvas,
            symbol,
            Offset(
              rect.center.dx,
              rect.center.dy,
            ),
            symbolColor!,
            tileWidth * 0.55,
          );
        }
      }
    }

    // Player
    final playerCenter = Offset(
      (playerCol + 0.5) * tileWidth,
      (playerRow + 0.5) * tileHeight,
    );

    canvas.drawCircle(
      playerCenter,
      tileWidth * 0.32,
      Paint()..color = const Color(0xFFFFC857),
    );

    canvas.drawCircle(
      playerCenter,
      tileWidth * 0.16,
      Paint()..color = const Color(0xFF211B32),
    );
  }

  void _drawText(
    Canvas canvas,
    String text,
    Offset center,
    Color color,
    double fontSize,
  ) {
    final textPainter = TextPainter(
      text: TextSpan(
        text: text,
        style: TextStyle(
          color: color,
          fontSize: fontSize,
          fontWeight: FontWeight.bold,
        ),
      ),
      textDirection: TextDirection.ltr,
    );

    textPainter.layout();

    textPainter.paint(
      canvas,
      Offset(
        center.dx - textPainter.width / 2,
        center.dy - textPainter.height / 2,
      ),
    );
  }

  @override
  bool shouldRepaint(covariant DungeonPainter oldDelegate) {
    return oldDelegate.playerRow != playerRow ||
        oldDelegate.playerCol != playerCol ||
        oldDelegate.map != map;
  }
}
