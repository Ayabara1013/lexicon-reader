import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/reading_preferences.dart';

/// StateNotifier for managing reading preferences
class ReadingPreferencesNotifier extends StateNotifier<ReadingPreferences> {
  ReadingPreferencesNotifier() : super(const ReadingPreferences());

  /// Update font size
  void setFontSize(double size) {
    state = state.copyWith(fontSize: size);
  }

  /// Update line height
  void setLineHeight(double height) {
    state = state.copyWith(lineHeight: height);
  }

  /// Update letter spacing
  void setLetterSpacing(double spacing) {
    state = state.copyWith(letterSpacing: spacing);
  }

  /// Update font family
  void setFontFamily(String family) {
    state = state.copyWith(fontFamily: family);
  }

  /// Toggle glow effects
  void toggleGlowEffects() {
    state = state.copyWith(enableGlowEffects: !state.enableGlowEffects);
  }

  /// Update brightness level
  void setBrightnessLevel(double level) {
    state = state.copyWith(brightnessLevel: level);
  }

  /// Apply preset
  void applyPreset(ReadingPreferences preset) {
    state = preset;
  }

  /// Reset to defaults
  void resetToDefaults() {
    state = const ReadingPreferences();
  }
}

/// Provider for reading preferences
final readingPreferencesProvider =
    StateNotifierProvider<ReadingPreferencesNotifier, ReadingPreferences>((ref) {
  return ReadingPreferencesNotifier();
});
