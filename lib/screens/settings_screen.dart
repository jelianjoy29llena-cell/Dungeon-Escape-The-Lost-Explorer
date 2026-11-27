
import 'package:flutter/material.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({super.key});

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  static const Color backgroundColor = Color(0xFF100E18);
  static const Color goldColor = Color(0xFFFFC857);
  static const Color textColor = Color(0xFFF5EBD7);
  static const Color cardColor = Color(0xFF211A30);

  bool _soundEnabled = true;
  bool _musicEnabled = true;
  double _soundVolume = 0.8;
  double _musicVolume = 0.6;

  Widget _settingsCard({
    required String title,
    required String description,
    required IconData icon,
    required Widget control,
  }) {
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: cardColor,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: goldColor.withValues(alpha: 0.2),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(
                icon,
                color: goldColor,
                size: 25,
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      style: const TextStyle(
                        color: textColor,
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      description,
                      style: const TextStyle(
                        color: Colors.white54,
                        fontSize: 11,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 15),
          control,
        ],
      ),
    );
  }

  void _resetSettings() {
    setState(() {
      _soundEnabled = true;
      _musicEnabled = true;
      _soundVolume = 0.8;
      _musicVolume = 0.6;
    });

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Settings restored to default!'),
        backgroundColor: Color(0xFF302044),
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
                        'SETTINGS',
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

              // SETTINGS CONTENT
              Expanded(
                child: SingleChildScrollView(
                  padding: const EdgeInsets.fromLTRB(
                    22,
                    15,
                    22,
                    25,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Center(
                        child: Icon(
                          Icons.settings,
                          color: goldColor,
                          size: 65,
                        ),
                      ),

                      const SizedBox(height: 12),

                      const Center(
                        child: Text(
                          'GAME PREFERENCES',
                          style: TextStyle(
                            color: textColor,
                            fontSize: 18,
                            fontWeight: FontWeight.w900,
                            letterSpacing: 1,
                          ),
                        ),
                      ),

                      const SizedBox(height: 8),

                      const Center(
                        child: Text(
                          'Customize your dungeon adventure.',
                          style: TextStyle(
                            color: Colors.white60,
                            fontSize: 12,
                          ),
                        ),
                      ),

                      const SizedBox(height: 30),

                      const Text(
                        'AUDIO SETTINGS',
                        style: TextStyle(
                          color: goldColor,
                          fontSize: 12,
                          fontWeight: FontWeight.bold,
                          letterSpacing: 2,
                        ),
                      ),

                      const SizedBox(height: 15),

                      // SOUND EFFECTS
                      _settingsCard(
                        title: 'Sound Effects',
                        description: 'Enable or disable game sounds.',
                        icon: Icons.volume_up,
                        control: SwitchListTile(
                          contentPadding: EdgeInsets.zero,
                          title: Text(
                            _soundEnabled ? 'ON' : 'OFF',
                            style: const TextStyle(
                              color: textColor,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          value: _soundEnabled,
                          activeThumbColor: goldColor,
                          onChanged: (value) {
                            setState(() {
                              _soundEnabled = value;
                            });
                          },
                        ),
                      ),

                      // SOUND VOLUME
                      _settingsCard(
                        title: 'Sound Volume',
                        description: 'Adjust the sound effect volume.',
                        icon: Icons.volume_down,
                        control: Column(
                          children: [
                            Slider(
                              value: _soundVolume,
                              min: 0,
                              max: 1,
                              activeColor: goldColor,
                              inactiveColor: Colors.white24,
                              onChanged: _soundEnabled
                                  ? (value) {
                                      setState(() {
                                        _soundVolume = value;
                                      });
                                    }
                                  : null,
                            ),
                            Align(
                              alignment: Alignment.centerRight,
                              child: Text(
                                '${(_soundVolume * 100).round()}%',
                                style: const TextStyle(
                                  color: goldColor,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),

                      // BACKGROUND MUSIC
                      _settingsCard(
                        title: 'Background Music',
                        description: 'Enable or disable background music.',
                        icon: Icons.music_note,
                        control: SwitchListTile(
                          contentPadding: EdgeInsets.zero,
                          title: Text(
                            _musicEnabled ? 'ON' : 'OFF',
                            style: const TextStyle(
                              color: textColor,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          value: _musicEnabled,
                          activeThumbColor: goldColor,
                          onChanged: (value) {
                            setState(() {
                              _musicEnabled = value;
                            });
                          },
                        ),
                      ),

                      // MUSIC VOLUME
                      _settingsCard(
                        title: 'Music Volume',
                        description: 'Adjust the background music volume.',
                        icon: Icons.headphones,
                        control: Column(
                          children: [
                            Slider(
                              value: _musicVolume,
                              min: 0,
                              max: 1,
                              activeColor: goldColor,
                              inactiveColor: Colors.white24,
                              onChanged: _musicEnabled
                                  ? (value) {
                                      setState(() {
                                        _musicVolume = value;
                                      });
                                    }
                                  : null,
                            ),
                            Align(
                              alignment: Alignment.centerRight,
                              child: Text(
                                '${(_musicVolume * 100).round()}%',
                                style: const TextStyle(
                                  color: goldColor,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),

                      const SizedBox(height: 12),

                      // RESET BUTTON
                      SizedBox(
                        width: double.infinity,
                        height: 52,
                        child: OutlinedButton.icon(
                          onPressed: _resetSettings,
                          icon: const Icon(Icons.refresh),
                          label: const Text(
                            'RESET SETTINGS',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              letterSpacing: 1,
                            ),
                          ),
                          style: OutlinedButton.styleFrom(
                            foregroundColor: goldColor,
                            side: const BorderSide(
                              color: goldColor,
                            ),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                          ),
                        ),
                      ),

                      const SizedBox(height: 25),

                      const Center(
                        child: Text(
                          'DUNGEON ESCAPE: THE LOST EXPLORER',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: Colors.white30,
                            fontSize: 9,
                            letterSpacing: 1.5,
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
}
