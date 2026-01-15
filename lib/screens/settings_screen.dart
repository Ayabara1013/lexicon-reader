import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import '../providers/reading_preferences_provider.dart';
import '../theme/app_theme.dart';
import '../widgets/neon_card.dart';
import '../widgets/glow_button.dart';

/// Settings screen for app and reading preferences
class SettingsScreen extends ConsumerStatefulWidget {
  const SettingsScreen({Key? key}) : super(key: key);

  @override
  ConsumerState<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends ConsumerState<SettingsScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _headerController;
  late Animation<double> _headerAnimation;

  @override
  void initState() {
    super.initState();
    _headerController = AnimationController(
      duration: const Duration(milliseconds: 1500),
      vsync: this,
    );
    _headerAnimation = CurvedAnimation(
      parent: _headerController,
      curve: Curves.easeOut,
    );
    _headerController.forward();
  }

  @override
  void dispose() {
    _headerController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final preferences = ref.watch(readingPreferencesProvider);

    return Scaffold(
      backgroundColor: SynthwaveColors.deepPurple,
      body: CustomScrollView(
        slivers: [
          // Animated header
          SliverToBoxAdapter(
            child: FadeTransition(
              opacity: _headerAnimation,
              child: SlideTransition(
                position: Tween<Offset>(
                  begin: const Offset(0, -0.5),
                  end: Offset.zero,
                ).animate(_headerAnimation),
                child: Container(
                  padding: const EdgeInsets.fromLTRB(24, 60, 24, 32),
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
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'SETTINGS',
                        style: theme.textTheme.displayLarge?.copyWith(
                          shadows: AppTheme.neonTextShadow(
                            color: SynthwaveColors.neonCyan,
                            blurRadius: 15,
                          ),
                          color: SynthwaveColors.neonCyan,
                        ),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        'Customize Your Experience',
                        style: theme.textTheme.bodyMedium?.copyWith(
                          color: SynthwaveColors.electricPurple,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),

          // Settings content
          SliverPadding(
            padding: const EdgeInsets.all(24),
            sliver: SliverList(
              delegate: SliverChildListDelegate([
                // Reading preferences section
                _buildSectionHeader('READING PREFERENCES', SynthwaveColors.neonPink),
                const SizedBox(height: 16),
                _buildReadingPreferencesCard(preferences),
                const SizedBox(height: 32),

                // Theme section
                _buildSectionHeader('THEME', SynthwaveColors.neonCyan),
                const SizedBox(height: 16),
                _buildThemeCard(),
                const SizedBox(height: 32),

                // App info section
                _buildSectionHeader('ABOUT', SynthwaveColors.electricPurple),
                const SizedBox(height: 16),
                _buildAboutCard(),
                const SizedBox(height: 32),
              ]),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSectionHeader(String title, Color color) {
    return Text(
      title,
      style: GoogleFonts.orbitron(
        fontSize: 16,
        fontWeight: FontWeight.bold,
        color: color,
        letterSpacing: 2,
        shadows: AppTheme.neonTextShadow(
          color: color,
          blurRadius: 8,
        ),
      ),
    );
  }

  Widget _buildReadingPreferencesCard(preferences) {
    final notifier = ref.read(readingPreferencesProvider.notifier);

    return NeonCard(
      glowColor: SynthwaveColors.neonPink,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Current values
          _buildPreferenceItem(
            icon: Icons.format_size,
            label: 'Font Size',
            value: preferences.fontSize.toStringAsFixed(0),
            color: SynthwaveColors.neonPink,
          ),
          const Divider(height: 24),
          _buildPreferenceItem(
            icon: Icons.format_line_spacing,
            label: 'Line Height',
            value: preferences.lineHeight.toStringAsFixed(1),
            color: SynthwaveColors.neonCyan,
          ),
          const Divider(height: 24),
          _buildPreferenceItem(
            icon: Icons.brightness_6,
            label: 'Brightness',
            value: '${(preferences.brightnessLevel * 100).toInt()}%',
            color: SynthwaveColors.electricPurple,
          ),
          const Divider(height: 24),

          // Glow effects toggle
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Icon(
                    Icons.auto_awesome,
                    color: SynthwaveColors.neonPink,
                    size: 20,
                  ),
                  const SizedBox(width: 12),
                  Text(
                    'Glow Effects',
                    style: TextStyle(
                      color: SynthwaveColors.textPrimary,
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ),
              GestureDetector(
                onTap: () => notifier.toggleGlowEffects(),
                child: AnimatedContainer(
                  duration: const Duration(milliseconds: 200),
                  width: 56,
                  height: 32,
                  decoration: BoxDecoration(
                    color: preferences.enableGlowEffects
                        ? SynthwaveColors.neonPink.withOpacity(0.3)
                        : SynthwaveColors.textDimmed.withOpacity(0.2),
                    borderRadius: BorderRadius.circular(16),
                    border: Border.all(
                      color: preferences.enableGlowEffects
                          ? SynthwaveColors.neonPink
                          : SynthwaveColors.textDimmed,
                      width: 2,
                    ),
                    boxShadow: preferences.enableGlowEffects
                        ? [
                            BoxShadow(
                              color: SynthwaveColors.neonPink.withOpacity(0.3),
                              blurRadius: 10,
                              spreadRadius: 1,
                            ),
                          ]
                        : null,
                  ),
                  child: AnimatedAlign(
                    duration: const Duration(milliseconds: 200),
                    alignment: preferences.enableGlowEffects
                        ? Alignment.centerRight
                        : Alignment.centerLeft,
                    child: Container(
                      width: 24,
                      height: 24,
                      margin: const EdgeInsets.symmetric(horizontal: 2),
                      decoration: BoxDecoration(
                        color: preferences.enableGlowEffects
                            ? SynthwaveColors.neonPink
                            : SynthwaveColors.textDimmed,
                        shape: BoxShape.circle,
                        boxShadow: [
                          BoxShadow(
                            color: (preferences.enableGlowEffects
                                    ? SynthwaveColors.neonPink
                                    : SynthwaveColors.textDimmed)
                                .withOpacity(0.5),
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
          ),
          const SizedBox(height: 24),

          // Reset button
          GlowButton(
            text: 'Reset to Defaults',
            icon: Icons.refresh,
            glowColor: SynthwaveColors.electricPurple,
            isFullWidth: true,
            onPressed: () {
              notifier.resetToDefaults();
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text(
                    'Settings reset to defaults',
                    style: TextStyle(color: Colors.white),
                  ),
                  backgroundColor: SynthwaveColors.darkPurple,
                  behavior: SnackBarBehavior.floating,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                    side: BorderSide(
                      color: SynthwaveColors.neonPink.withOpacity(0.5),
                    ),
                  ),
                ),
              );
            },
          ),
        ],
      ),
    );
  }

  Widget _buildPreferenceItem({
    required IconData icon,
    required String label,
    required String value,
    required Color color,
  }) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Row(
          children: [
            Icon(icon, color: color, size: 20),
            const SizedBox(width: 12),
            Text(
              label,
              style: TextStyle(
                color: SynthwaveColors.textPrimary,
                fontSize: 16,
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        ),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
          decoration: BoxDecoration(
            color: color.withOpacity(0.15),
            borderRadius: BorderRadius.circular(8),
            border: Border.all(
              color: color.withOpacity(0.3),
              width: 1,
            ),
          ),
          child: Text(
            value,
            style: TextStyle(
              color: color,
              fontSize: 14,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildThemeCard() {
    return NeonCard(
      glowColor: SynthwaveColors.neonCyan,
      child: Column(
        children: [
          _buildSettingsItem(
            icon: Icons.palette,
            title: 'Synthwave Theme',
            subtitle: 'Dark mode with neon accents',
            color: SynthwaveColors.neonCyan,
            trailing: Container(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
              decoration: BoxDecoration(
                color: SynthwaveColors.neonCyan.withOpacity(0.15),
                borderRadius: BorderRadius.circular(8),
                border: Border.all(
                  color: SynthwaveColors.neonCyan.withOpacity(0.3),
                ),
              ),
              child: Text(
                'Active',
                style: TextStyle(
                  color: SynthwaveColors.neonCyan,
                  fontSize: 12,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
          const Divider(height: 24),
          _buildSettingsItem(
            icon: Icons.color_lens,
            title: 'Color Palette',
            subtitle: 'Pink • Cyan • Purple',
            color: SynthwaveColors.neonPink,
            trailing: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                _colorDot(SynthwaveColors.neonPink),
                const SizedBox(width: 6),
                _colorDot(SynthwaveColors.neonCyan),
                const SizedBox(width: 6),
                _colorDot(SynthwaveColors.electricPurple),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _colorDot(Color color) {
    return Container(
      width: 20,
      height: 20,
      decoration: BoxDecoration(
        color: color,
        shape: BoxShape.circle,
        boxShadow: [
          BoxShadow(
            color: color.withOpacity(0.5),
            blurRadius: 8,
            spreadRadius: 1,
          ),
        ],
      ),
    );
  }

  Widget _buildAboutCard() {
    return NeonCard(
      glowColor: SynthwaveColors.electricPurple,
      child: Column(
        children: [
          _buildSettingsItem(
            icon: Icons.info_outline,
            title: 'Lexicon Reader',
            subtitle: 'Version 1.0.0',
            color: SynthwaveColors.electricPurple,
          ),
          const Divider(height: 24),
          _buildSettingsItem(
            icon: Icons.code,
            title: 'Built with Flutter',
            subtitle: 'Powered by Riverpod',
            color: SynthwaveColors.neonCyan,
          ),
          const Divider(height: 24),
          _buildSettingsItem(
            icon: Icons.style,
            title: 'Design',
            subtitle: 'Synthwave/Cyberpunk Aesthetic',
            color: SynthwaveColors.neonPink,
          ),
        ],
      ),
    );
  }

  Widget _buildSettingsItem({
    required IconData icon,
    required String title,
    required String subtitle,
    required Color color,
    Widget? trailing,
  }) {
    return Row(
      children: [
        Container(
          padding: const EdgeInsets.all(10),
          decoration: BoxDecoration(
            color: color.withOpacity(0.15),
            borderRadius: BorderRadius.circular(10),
            border: Border.all(
              color: color.withOpacity(0.3),
              width: 1,
            ),
          ),
          child: Icon(icon, color: color, size: 24),
        ),
        const SizedBox(width: 16),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: TextStyle(
                  color: SynthwaveColors.textPrimary,
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                ),
              ),
              const SizedBox(height: 4),
              Text(
                subtitle,
                style: TextStyle(
                  color: SynthwaveColors.textSecondary,
                  fontSize: 13,
                ),
              ),
            ],
          ),
        ),
        if (trailing != null) trailing,
      ],
    );
  }
}
