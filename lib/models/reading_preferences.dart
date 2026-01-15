/// User reading preferences for customizing the reading experience
class ReadingPreferences {
  final double fontSize;
  final double lineHeight;
  final double letterSpacing;
  final String fontFamily;
  final bool enableGlowEffects;
  final double brightnessLevel;

  const ReadingPreferences({
    this.fontSize = 18.0,
    this.lineHeight = 1.8,
    this.letterSpacing = 0.3,
    this.fontFamily = 'Inter',
    this.enableGlowEffects = true,
    this.brightnessLevel = 1.0,
  });

  /// Copy with method for creating modified copies
  ReadingPreferences copyWith({
    double? fontSize,
    double? lineHeight,
    double? letterSpacing,
    String? fontFamily,
    bool? enableGlowEffects,
    double? brightnessLevel,
  }) {
    return ReadingPreferences(
      fontSize: fontSize ?? this.fontSize,
      lineHeight: lineHeight ?? this.lineHeight,
      letterSpacing: letterSpacing ?? this.letterSpacing,
      fontFamily: fontFamily ?? this.fontFamily,
      enableGlowEffects: enableGlowEffects ?? this.enableGlowEffects,
      brightnessLevel: brightnessLevel ?? this.brightnessLevel,
    );
  }

  /// Preset configurations
  static const compact = ReadingPreferences(
    fontSize: 16.0,
    lineHeight: 1.6,
    letterSpacing: 0.2,
  );

  static const comfortable = ReadingPreferences(
    fontSize: 18.0,
    lineHeight: 1.8,
    letterSpacing: 0.3,
  );

  static const relaxed = ReadingPreferences(
    fontSize: 20.0,
    lineHeight: 2.0,
    letterSpacing: 0.4,
  );
}
