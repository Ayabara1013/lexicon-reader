import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import '../models/chapter.dart';
import '../providers/chapter_provider.dart';
import '../providers/reading_preferences_provider.dart';
import '../theme/app_theme.dart';
import '../widgets/glow_button.dart';

/// Reader screen for displaying chapter content
class ReaderScreen extends ConsumerStatefulWidget {
  final String chapterId;

  const ReaderScreen({
    Key? key,
    required this.chapterId,
  }) : super(key: key);

  @override
  ConsumerState<ReaderScreen> createState() => _ReaderScreenState();
}

class _ReaderScreenState extends ConsumerState<ReaderScreen>
    with SingleTickerProviderStateMixin {
  final ScrollController _scrollController = ScrollController();
  bool _showControls = true;
  bool _showSettings = false;
  late AnimationController _settingsController;
  late Animation<Offset> _settingsAnimation;

  @override
  void initState() {
    super.initState();
    _settingsController = AnimationController(
      duration: const Duration(milliseconds: 300),
      vsync: this,
    );
    _settingsAnimation = Tween<Offset>(
      begin: const Offset(0, 1),
      end: Offset.zero,
    ).animate(CurvedAnimation(
      parent: _settingsController,
      curve: Curves.easeOut,
    ));
  }

  @override
  void dispose() {
    _scrollController.dispose();
    _settingsController.dispose();
    super.dispose();
  }

  void _toggleSettings() {
    setState(() {
      _showSettings = !_showSettings;
    });
    if (_showSettings) {
      _settingsController.forward();
    } else {
      _settingsController.reverse();
    }
  }

  @override
  Widget build(BuildContext context) {
    final chapter = ref.watch(chapterByIdProvider(widget.chapterId));
    final preferences = ref.watch(readingPreferencesProvider);

    if (chapter == null) {
      return Scaffold(
        backgroundColor: SynthwaveColors.deepPurple,
        body: Center(
          child: Text(
            'Chapter not found',
            style: TextStyle(color: SynthwaveColors.neonPink),
          ),
        ),
      );
    }

    return Scaffold(
      backgroundColor: SynthwaveColors.deepPurple,
      body: Stack(
        children: [
          // Main content
          CustomScrollView(
            controller: _scrollController,
            slivers: [
              // App bar
              SliverAppBar(
                pinned: true,
                expandedHeight: 200,
                backgroundColor: SynthwaveColors.darkPurple,
                leading: GlowIconButton(
                  icon: Icons.arrow_back,
                  glowColor: SynthwaveColors.neonCyan,
                  onPressed: () => Navigator.pop(context),
                ),
                actions: [
                  Padding(
                    padding: const EdgeInsets.only(right: 16),
                    child: GlowIconButton(
                      icon: Icons.tune,
                      glowColor: SynthwaveColors.neonPink,
                      onPressed: _toggleSettings,
                    ),
                  ),
                ],
                flexibleSpace: FlexibleSpaceBar(
                  background: Container(
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                        colors: [
                          SynthwaveColors.darkPurple,
                          SynthwaveColors.deepPurple,
                        ],
                      ),
                    ),
                    padding: const EdgeInsets.fromLTRB(24, 80, 24, 24),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Text(
                          chapter.title,
                          style: GoogleFonts.orbitron(
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                            color: SynthwaveColors.neonPink,
                            shadows: AppTheme.neonTextShadow(
                              color: SynthwaveColors.neonPink,
                            ),
                          ),
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                        ),
                        const SizedBox(height: 8),
                        Row(
                          children: [
                            Icon(
                              Icons.person_outline,
                              size: 16,
                              color: SynthwaveColors.neonCyan,
                            ),
                            const SizedBox(width: 6),
                            Text(
                              chapter.author,
                              style: TextStyle(
                                color: SynthwaveColors.neonCyan,
                                fontSize: 14,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            const SizedBox(width: 16),
                            Icon(
                              Icons.access_time,
                              size: 16,
                              color: SynthwaveColors.electricPurple,
                            ),
                            const SizedBox(width: 6),
                            Text(
                              chapter.readingTimeEstimate,
                              style: TextStyle(
                                color: SynthwaveColors.electricPurple,
                                fontSize: 14,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ),

              // Chapter content
              SliverToBoxAdapter(
                child: Padding(
                  padding: const EdgeInsets.all(24),
                  child: Container(
                    padding: const EdgeInsets.all(24),
                    decoration: BoxDecoration(
                      color: SynthwaveColors.darkPurple.withOpacity(0.5),
                      borderRadius: BorderRadius.circular(16),
                      border: Border.all(
                        color: SynthwaveColors.electricPurple.withOpacity(
                          preferences.enableGlowEffects ? 0.3 : 0.1,
                        ),
                        width: 1,
                      ),
                      boxShadow: preferences.enableGlowEffects
                          ? [
                              BoxShadow(
                                color: SynthwaveColors.electricPurple.withOpacity(0.1),
                                blurRadius: 20,
                                spreadRadius: 2,
                              ),
                            ]
                          : null,
                    ),
                    child: SelectableText(
                      chapter.content,
                      style: GoogleFonts.inter(
                        fontSize: preferences.fontSize,
                        height: preferences.lineHeight,
                        letterSpacing: preferences.letterSpacing,
                        color: SynthwaveColors.textPrimary.withOpacity(
                          preferences.brightnessLevel,
                        ),
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  ),
                ),
              ),

              // Bottom spacing
              const SliverToBoxAdapter(
                child: SizedBox(height: 100),
              ),
            ],
          ),

          // Settings panel
          if (_showSettings)
            GestureDetector(
              onTap: _toggleSettings,
              child: Container(
                color: Colors.black.withOpacity(0.5),
              ),
            ),

          // Settings bottom sheet
          Align(
            alignment: Alignment.bottomCenter,
            child: SlideTransition(
              position: _settingsAnimation,
              child: _buildSettingsPanel(preferences),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSettingsPanel(preferences) {
    final notifier = ref.read(readingPreferencesProvider.notifier);

    return Container(
      decoration: BoxDecoration(
        color: SynthwaveColors.darkPurple,
        borderRadius: const BorderRadius.vertical(top: Radius.circular(24)),
        border: Border.all(
          color: SynthwaveColors.electricPurple.withOpacity(0.5),
          width: 2,
        ),
        boxShadow: [
          BoxShadow(
            color: SynthwaveColors.neonPink.withOpacity(0.3),
            blurRadius: 30,
            offset: const Offset(0, -10),
          ),
        ],
      ),
      child: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Header
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'READING SETTINGS',
                    style: GoogleFonts.orbitron(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: SynthwaveColors.neonPink,
                      letterSpacing: 1.5,
                      shadows: AppTheme.neonTextShadow(
                        color: SynthwaveColors.neonPink,
                        blurRadius: 8,
                      ),
                    ),
                  ),
                  GlowIconButton(
                    icon: Icons.close,
                    glowColor: SynthwaveColors.neonCyan,
                    onPressed: _toggleSettings,
                  ),
                ],
              ),
              const SizedBox(height: 24),

              // Font size
              _buildSliderSetting(
                label: 'Font Size',
                value: preferences.fontSize,
                min: 14,
                max: 24,
                divisions: 10,
                color: SynthwaveColors.neonPink,
                onChanged: (value) => notifier.setFontSize(value),
              ),
              const SizedBox(height: 20),

              // Line height
              _buildSliderSetting(
                label: 'Line Height',
                value: preferences.lineHeight,
                min: 1.4,
                max: 2.4,
                divisions: 10,
                color: SynthwaveColors.neonCyan,
                onChanged: (value) => notifier.setLineHeight(value),
              ),
              const SizedBox(height: 20),

              // Letter spacing
              _buildSliderSetting(
                label: 'Letter Spacing',
                value: preferences.letterSpacing,
                min: 0,
                max: 1,
                divisions: 10,
                color: SynthwaveColors.electricPurple,
                onChanged: (value) => notifier.setLetterSpacing(value),
              ),
              const SizedBox(height: 20),

              // Brightness
              _buildSliderSetting(
                label: 'Brightness',
                value: preferences.brightnessLevel,
                min: 0.6,
                max: 1.0,
                divisions: 4,
                color: SynthwaveColors.neonPink,
                onChanged: (value) => notifier.setBrightnessLevel(value),
              ),
              const SizedBox(height: 20),

              // Glow effects toggle
              _buildToggleSetting(
                label: 'Neon Glow Effects',
                value: preferences.enableGlowEffects,
                color: SynthwaveColors.neonCyan,
                onChanged: (_) => notifier.toggleGlowEffects(),
              ),
              const SizedBox(height: 24),

              // Presets
              Text(
                'PRESETS',
                style: GoogleFonts.rajdhani(
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                  color: SynthwaveColors.electricPurple,
                  letterSpacing: 1,
                ),
              ),
              const SizedBox(height: 12),
              Row(
                children: [
                  Expanded(
                    child: GlowButton(
                      text: 'Compact',
                      glowColor: SynthwaveColors.neonPink,
                      onPressed: () => notifier.applyPreset(
                        ReadingPreferences.compact,
                      ),
                    ),
                  ),
                  const SizedBox(width: 8),
                  Expanded(
                    child: GlowButton(
                      text: 'Comfortable',
                      glowColor: SynthwaveColors.neonCyan,
                      onPressed: () => notifier.applyPreset(
                        ReadingPreferences.comfortable,
                      ),
                    ),
                  ),
                  const SizedBox(width: 8),
                  Expanded(
                    child: GlowButton(
                      text: 'Relaxed',
                      glowColor: SynthwaveColors.electricPurple,
                      onPressed: () => notifier.applyPreset(
                        ReadingPreferences.relaxed,
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildSliderSetting({
    required String label,
    required double value,
    required double min,
    required double max,
    required int divisions,
    required Color color,
    required ValueChanged<double> onChanged,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              label,
              style: TextStyle(
                color: color,
                fontSize: 14,
                fontWeight: FontWeight.bold,
                letterSpacing: 0.5,
              ),
            ),
            Text(
              value.toStringAsFixed(1),
              style: TextStyle(
                color: SynthwaveColors.textSecondary,
                fontSize: 14,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
        const SizedBox(height: 8),
        SliderTheme(
          data: SliderThemeData(
            activeTrackColor: color,
            inactiveTrackColor: color.withOpacity(0.2),
            thumbColor: color,
            overlayColor: color.withOpacity(0.2),
            thumbShape: const RoundSliderThumbShape(enabledThumbRadius: 8),
            trackHeight: 4,
          ),
          child: Slider(
            value: value,
            min: min,
            max: max,
            divisions: divisions,
            onChanged: onChanged,
          ),
        ),
      ],
    );
  }

  Widget _buildToggleSetting({
    required String label,
    required bool value,
    required Color color,
    required ValueChanged<bool> onChanged,
  }) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          label,
          style: TextStyle(
            color: color,
            fontSize: 14,
            fontWeight: FontWeight.bold,
            letterSpacing: 0.5,
          ),
        ),
        GestureDetector(
          onTap: () => onChanged(!value),
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 200),
            width: 56,
            height: 32,
            decoration: BoxDecoration(
              color: value ? color.withOpacity(0.3) : SynthwaveColors.textDimmed.withOpacity(0.2),
              borderRadius: BorderRadius.circular(16),
              border: Border.all(
                color: value ? color : SynthwaveColors.textDimmed,
                width: 2,
              ),
              boxShadow: value
                  ? [
                      BoxShadow(
                        color: color.withOpacity(0.3),
                        blurRadius: 10,
                        spreadRadius: 1,
                      ),
                    ]
                  : null,
            ),
            child: AnimatedAlign(
              duration: const Duration(milliseconds: 200),
              alignment: value ? Alignment.centerRight : Alignment.centerLeft,
              child: Container(
                width: 24,
                height: 24,
                margin: const EdgeInsets.symmetric(horizontal: 2),
                decoration: BoxDecoration(
                  color: value ? color : SynthwaveColors.textDimmed,
                  shape: BoxShape.circle,
                  boxShadow: [
                    BoxShadow(
                      color: (value ? color : SynthwaveColors.textDimmed).withOpacity(0.5),
                      blurRadius: 8,
                      spreadRadius: 1,
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
