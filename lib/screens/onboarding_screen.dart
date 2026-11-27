
import 'package:flutter/material.dart';

class OnboardingScreen extends StatefulWidget {
  final VoidCallback onFinished;

  const OnboardingScreen({
    super.key,
    required this.onFinished,
  });

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  final PageController _pageController = PageController();

  int _currentPage = 0;
  bool _isFinishing = false;

  final List<Map<String, dynamic>> _pages = [
    {
      'icon': Icons.explore,
      'title': 'BEGIN YOUR ADVENTURE',
      'description':
          'Enter a mysterious dungeon, explore hidden paths, '
          'and uncover the secrets of the Lost Explorer.',
      'subtitle': 'A WORLD WAITING TO BE DISCOVERED',
      'color': const Color(0xFFB58AE8),
    },
    {
      'icon': Icons.key,
      'title': 'COLLECT AND SURVIVE',
      'description':
          'Find golden keys, collect valuable treasures, '
          'and avoid dangerous traps. Protect your five hearts!',
      'subtitle': 'YOUR SURVIVAL IS IN YOUR HANDS',
      'color': const Color(0xFFFFC857),
    },
    {
      'icon': Icons.diamond,
      'title': 'THE SHIFTING DUNGEON',
      'description':
          'Discover the mysterious crystal. Collect it to '
          'shift selected dungeon walls and reveal a new path '
          'toward your escape.',
      'subtitle': 'EVERY CRYSTAL CHANGES YOUR JOURNEY',
      'color': const Color(0xFFB78BFF),
    },
  ];

  void _nextPage() {
    if (_isFinishing) return;

    if (_currentPage < _pages.length - 1) {
      _pageController.nextPage(
        duration: const Duration(milliseconds: 350),
        curve: Curves.easeInOut,
      );
    } else {
      _finishOnboarding();
    }
  }

  void _finishOnboarding() {
    if (_isFinishing) return;

    setState(() {
      _isFinishing = true;
    });

    debugPrint('ONBOARDING: START ADVENTURE PRESSED');
    debugPrint('ONBOARDING: Calling Main Menu navigation');

    widget.onFinished();
  }

  void _skipOnboarding() {
    if (_isFinishing) return;

    _pageController.animateToPage(
      _pages.length - 1,
      duration: const Duration(milliseconds: 350),
      curve: Curves.easeInOut,
    );
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final bool isLastPage =
        _currentPage == _pages.length - 1;

    return Scaffold(
      backgroundColor: const Color(0xFF100E18),
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Color(0xFF302044),
              Color(0xFF191322),
              Color(0xFF100E18),
            ],
          ),
        ),
        child: SafeArea(
          child: Column(
            children: [
              // TOP BAR
              Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 24,
                  vertical: 12,
                ),
                child: Row(
                  children: [
                    const Icon(
                      Icons.diamond,
                      color: Color(0xFFFFC857),
                      size: 25,
                    ),
                    const SizedBox(width: 8),
                    const Text(
                      'DUNGEON ESCAPE',
                      style: TextStyle(
                        color: Color(0xFFFFC857),
                        fontWeight: FontWeight.bold,
                        fontSize: 13,
                        letterSpacing: 2,
                      ),
                    ),
                    const Spacer(),
                    if (!isLastPage)
                      TextButton(
                        onPressed: _skipOnboarding,
                        child: const Text(
                          'SKIP',
                          style: TextStyle(
                            color: Colors.white60,
                            letterSpacing: 1,
                          ),
                        ),
                      ),
                  ],
                ),
              ),

              // ONBOARDING PAGES
              Expanded(
                child: PageView.builder(
                  controller: _pageController,
                  itemCount: _pages.length,
                  onPageChanged: (index) {
                    setState(() {
                      _currentPage = index;
                    });
                  },
                  itemBuilder: (context, index) {
                    final page = _pages[index];
                    final Color pageColor =
                        page['color'] as Color;

                    return Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 28,
                      ),
                      child: SingleChildScrollView(
                        child: Column(
                          mainAxisAlignment:
                              MainAxisAlignment.center,
                          children: [
                            const SizedBox(height: 20),

                            // ILLUSTRATION
                            Container(
                              height: 245,
                              width: 245,
                              decoration: BoxDecoration(
                                color: const Color(0xFF211A30),
                                borderRadius:
                                    BorderRadius.circular(30),
                                border: Border.all(
                                  color: pageColor.withValues(
                                    alpha: 0.55,
                                  ),
                                  width: 2,
                                ),
                                boxShadow: [
                                  BoxShadow(
                                    color: pageColor.withValues(
                                      alpha: 0.15,
                                    ),
                                    blurRadius: 35,
                                    spreadRadius: 3,
                                  ),
                                ],
                              ),
                              child: Stack(
                                alignment: Alignment.center,
                                children: [
                                  Icon(
                                    Icons.auto_awesome,
                                    size: 190,
                                    color: pageColor.withValues(
                                      alpha: 0.08,
                                    ),
                                  ),
                                  Icon(
                                    page['icon'] as IconData,
                                    size: 115,
                                    color: pageColor,
                                  ),
                                ],
                              ),
                            ),

                            const SizedBox(height: 40),

                            Text(
                              page['subtitle'] as String,
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                color: pageColor,
                                fontSize: 10,
                                fontWeight: FontWeight.bold,
                                letterSpacing: 2,
                              ),
                            ),

                            const SizedBox(height: 15),

                            Text(
                              page['title'] as String,
                              textAlign: TextAlign.center,
                              style: const TextStyle(
                                color: Color(0xFFF5EBD7),
                                fontSize: 23,
                                fontWeight: FontWeight.w900,
                                letterSpacing: 1,
                              ),
                            ),

                            const SizedBox(height: 18),

                            Text(
                              page['description'] as String,
                              textAlign: TextAlign.center,
                              style: const TextStyle(
                                color: Colors.white70,
                                fontSize: 14,
                                height: 1.8,
                              ),
                            ),

                            const SizedBox(height: 25),
                          ],
                        ),
                      ),
                    );
                  },
                ),
              ),

              // BOTTOM NAVIGATION
              Padding(
                padding: const EdgeInsets.fromLTRB(
                  28,
                  12,
                  28,
                  28,
                ),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment:
                          MainAxisAlignment.center,
                      children: List.generate(
                        _pages.length,
                        (index) => AnimatedContainer(
                          duration:
                              const Duration(milliseconds: 250),
                          margin: const EdgeInsets.symmetric(
                            horizontal: 4,
                          ),
                          height: 7,
                          width: _currentPage == index ? 27 : 8,
                          decoration: BoxDecoration(
                            color: _currentPage == index
                                ? const Color(0xFFFFC857)
                                : Colors.white24,
                            borderRadius:
                                BorderRadius.circular(10),
                          ),
                        ),
                      ),
                    ),

                    const SizedBox(height: 28),

                    SizedBox(
                      width: double.infinity,
                      height: 55,
                      child: ElevatedButton(
                        onPressed:
                            _isFinishing ? null : _nextPage,
                        style: ElevatedButton.styleFrom(
                          backgroundColor:
                              const Color(0xFFFFC857),
                          foregroundColor:
                              const Color(0xFF100E18),
                          disabledBackgroundColor:
                              const Color(0xFFFFC857),
                          shape: RoundedRectangleBorder(
                            borderRadius:
                                BorderRadius.circular(12),
                          ),
                          elevation: 5,
                        ),
                        child: Row(
                          mainAxisAlignment:
                              MainAxisAlignment.center,
                          children: [
                            Text(
                              _isFinishing
                                  ? 'STARTING...'
                                  : isLastPage
                                      ? 'START ADVENTURE'
                                      : 'CONTINUE',
                              style: const TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.w900,
                                letterSpacing: 2,
                              ),
                            ),
                            const SizedBox(width: 10),
                            const Icon(
                              Icons.arrow_forward,
                              size: 19,
                            ),
                          ],
                        ),
                      ),
                    ),

                    const SizedBox(height: 15),

                    const Text(
                      'DUNGEON ESCAPE: THE LOST EXPLORER',
                      style: TextStyle(
                        color: Colors.white30,
                        fontSize: 9,
                        letterSpacing: 1.5,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
