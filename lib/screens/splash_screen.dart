
import 'dart:async';

import 'package:flutter/material.dart';

import 'onboarding_screen.dart';
import 'main_menu_screen.dart';
import 'how_to_play_screen.dart';
import 'settings_screen.dart';
import 'level_selection_screen.dart';
import 'gameplay_screen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with SingleTickerProviderStateMixin {
  static const Color backgroundColor = Color(0xFF100E18);
  static const Color goldColor = Color(0xFFFFC857);
  static const Color textColor = Color(0xFFF5EBD7);

  late AnimationController _animationController;
  late Animation<double> _scaleAnimation;

  double _loadingProgress = 0;
  Timer? _loadingTimer;
  bool _hasNavigated = false;

  @override
  void initState() {
    super.initState();

    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1200),
    )..repeat(reverse: true);

    _scaleAnimation = Tween<double>(
      begin: 0.9,
      end: 1.08,
    ).animate(
      CurvedAnimation(
        parent: _animationController,
        curve: Curves.easeInOut,
      ),
    );

    _startLoading();
  }

  // ==========================================
  // SPLASH LOADING
  // ==========================================

  void _startLoading() {
    _loadingTimer = Timer.periodic(
      const Duration(milliseconds: 40),
      (timer) {
        if (!mounted) {
          timer.cancel();
          return;
        }

        setState(() {
          _loadingProgress =
              (_loadingProgress + 0.02).clamp(0.0, 1.0);
        });

        if (_loadingProgress >= 1 && !_hasNavigated) {
          timer.cancel();
          _hasNavigated = true;

          _goToOnboarding();
        }
      },
    );
  }

  // ==========================================
  // SPLASH TO ONBOARDING
  // ==========================================

  void _goToOnboarding() {
    if (!mounted) return;

    Navigator.of(context).pushReplacement(
      MaterialPageRoute(
        builder: (onboardingContext) {
          return OnboardingScreen(
            onFinished: () {
              _goToMainMenu(onboardingContext);
            },
          );
        },
      ),
    );
  }

  // ==========================================
  // ONBOARDING TO MAIN MENU
  // ==========================================

  void _goToMainMenu(BuildContext onboardingContext) {
    Navigator.of(onboardingContext).pushReplacement(
      MaterialPageRoute(
        builder: (menuContext) {
          return MainMenuScreen(
            onStartAdventure: () {
              _openLevelSelection(menuContext);
            },
            onHowToPlay: () {
              _openHowToPlay(menuContext);
            },
            onSettings: () {
              _openSettings(menuContext);
            },
          );
        },
      ),
    );
  }

  // ==========================================
  // MAIN MENU TO LEVEL SELECTION
  // ==========================================

  void _openLevelSelection(BuildContext menuContext) {
    Navigator.of(menuContext).push(
      MaterialPageRoute(
        builder: (levelContext) {
          return LevelSelectionScreen(
            unlockedLevel: 1,
            onLevelSelected: (levelNumber) {
              if (levelNumber == 1) {
                Navigator.of(levelContext).push(
                  MaterialPageRoute(
                    builder: (_) => const GameplayScreen(),
                  ),
                );
              }
            },
          );
        },
      ),
    );
  }

  // ==========================================
  // MAIN MENU TO HOW TO PLAY
  // ==========================================

  void _openHowToPlay(BuildContext menuContext) {
    Navigator.of(menuContext).push(
      MaterialPageRoute(
        builder: (_) => HowToPlayScreen(),
      ),
    );
  }

  // ==========================================
  // MAIN MENU TO SETTINGS
  // ==========================================

  void _openSettings(BuildContext menuContext) {
    Navigator.of(menuContext).push(
      MaterialPageRoute(
        builder: (_) => SettingsScreen(),
      ),
    );
  }

  // ==========================================
  // DISPOSE
  // ==========================================

  @override
  void dispose() {
    _loadingTimer?.cancel();
    _animationController.dispose();
    super.dispose();
  }

  // ==========================================
  // SPLASH SCREEN UI
  // ==========================================

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
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 35),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ScaleTransition(
                    scale: _scaleAnimation,
                    child: Container(
                      height: 190,
                      width: 190,
                      decoration: BoxDecoration(
                        color: const Color(0xFF211A30),
                        borderRadius: BorderRadius.circular(35),
                        border: Border.all(
                          color: goldColor.withValues(alpha: 0.6),
                          width: 2,
                        ),
                        boxShadow: [
                          BoxShadow(
                            color: goldColor.withValues(alpha: 0.15),
                            blurRadius: 35,
                            spreadRadius: 5,
                          ),
                        ],
                      ),
                      child: const Icon(
                        Icons.explore,
                        color: goldColor,
                        size: 110,
                      ),
                    ),
                  ),

                  const SizedBox(height: 35),

                  const Text(
                    'DUNGEON',
                    style: TextStyle(
                      color: textColor,
                      fontSize: 36,
                      fontWeight: FontWeight.w900,
                      letterSpacing: 5,
                    ),
                  ),

                  const Text(
                    'ESCAPE',
                    style: TextStyle(
                      color: goldColor,
                      fontSize: 36,
                      fontWeight: FontWeight.w900,
                      letterSpacing: 7,
                    ),
                  ),

                  const SizedBox(height: 12),

                  const Text(
                    'THE LOST EXPLORER',
                    style: TextStyle(
                      color: Colors.white60,
                      fontSize: 11,
                      fontWeight: FontWeight.bold,
                      letterSpacing: 3,
                    ),
                  ),

                  const SizedBox(height: 65),

                  ClipRRect(
                    borderRadius: BorderRadius.circular(20),
                    child: LinearProgressIndicator(
                      value: _loadingProgress,
                      minHeight: 7,
                      backgroundColor: Colors.white12,
                      valueColor:
                          const AlwaysStoppedAnimation<Color>(
                        goldColor,
                      ),
                    ),
                  ),

                  const SizedBox(height: 15),

                  Text(
                    'LOADING... ${(_loadingProgress * 100).round()}%',
                    style: const TextStyle(
                      color: Colors.white60,
                      fontSize: 11,
                      fontWeight: FontWeight.bold,
                      letterSpacing: 2,
                    ),
                  ),

                  const SizedBox(height: 60),

                  const Text(
                    'AN ADVENTURE AWAITS',
                    style: TextStyle(
                      color: goldColor,
                      fontSize: 10,
                      fontWeight: FontWeight.bold,
                      letterSpacing: 2,
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
