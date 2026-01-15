# 🌃 Lexicon Reader - Synthwave Edition

A beautiful Flutter mobile app for reading Patreon chapters with a stunning **synthwave/cyberpunk dark theme** aesthetic. Featuring neon purples, pinks, and cyans with smooth animations and glowing effects.

## ✨ Features

### 📚 Core Functionality
- **Chapter Library**: Browse your collection of chapters with elegant neon-styled cards
- **Immersive Reader**: Clean, distraction-free reading experience with customizable settings
- **Settings Panel**: Full control over your reading preferences and app configuration

### 🎨 Synthwave Aesthetic
- **Deep purple/black backgrounds** (#0A0A1F, #1A1A2E)
- **Neon accent colors**:
  - Hot Pink (#FF00FF)
  - Cyan (#00FFFF)
  - Electric Purple (#BD00FF)
- **Glowing effects** on cards, buttons, and interactive elements
- **Smooth animations** with fade and slide transitions
- **Retro-futuristic typography** using Orbitron, Rajdhani, and Inter fonts

### ⚙️ Reading Customization
- **Font Size**: Adjust from 14-24pt
- **Line Height**: Control spacing from 1.4-2.4
- **Letter Spacing**: Fine-tune from 0-1
- **Brightness Level**: Adjust text opacity for comfortable reading
- **Glow Effects Toggle**: Enable/disable neon glow on UI elements
- **Reading Presets**: Compact, Comfortable, and Relaxed modes

## 🏗️ Project Structure

```
lib/
├── main.dart                          # App entry point with navigation
├── models/                            # Data models
│   ├── chapter.dart                   # Chapter data model
│   └── reading_preferences.dart       # Reading settings model
├── providers/                         # Riverpod state management
│   ├── chapter_provider.dart          # Mock chapter data & providers
│   ├── reading_preferences_provider.dart  # Reading settings state
│   └── navigation_provider.dart       # Bottom nav state
├── screens/                           # Main app screens
│   ├── library_screen.dart            # Chapter library/home
│   ├── reader_screen.dart             # Chapter reading view
│   └── settings_screen.dart           # App settings
├── theme/                             # Theme configuration
│   └── app_theme.dart                 # Synthwave color palette & theming
└── widgets/                           # Reusable components
    ├── neon_card.dart                 # Glowing card components
    ├── glow_button.dart               # Neon button components
    └── neon_bottom_nav.dart           # Bottom navigation bar
```

## 🚀 Getting Started

### Prerequisites
- Flutter SDK (3.0.0 or higher)
- Dart SDK
- iOS Simulator / Android Emulator / Physical device

### Installation

1. **Clone the repository**
   ```bash
   git clone <your-repo-url>
   cd lexicon-reader
   ```

2. **Install dependencies**
   ```bash
   flutter pub get
   ```

3. **Run the app**
   ```bash
   flutter run
   ```

## 📦 Dependencies

- **flutter_riverpod**: State management
- **google_fonts**: Custom typography (Orbitron, Rajdhani, Inter)
- **cupertino_icons**: iOS-style icons

## 🎯 Key Concepts Demonstrated

### Flutter Theming
- **ThemeData configuration** with Material 3
- **Custom color schemes** for consistent branding
- **Typography system** with Google Fonts
- **Reusable theme utilities** for neon effects

### State Management (Riverpod)
- **Provider** for read-only data (chapters, categories)
- **StateNotifierProvider** for mutable state (preferences, navigation)
- **Family modifiers** for parameterized providers
- **Ref.watch/read** for consuming state in widgets

### Custom Widgets
- **Stateful animations** with AnimationController
- **Gesture detection** for interactive feedback
- **Composition patterns** for reusable components
- **Theme-aware styling** using Theme.of(context)

### Advanced UI Patterns
- **CustomScrollView** with slivers for efficient scrolling
- **Hero animations** and page transitions
- **Bottom sheets** for settings panels
- **Responsive layouts** with flexible containers

## 🎨 Design Philosophy

This app showcases:
1. **Consistent theming** across all screens
2. **Visual hierarchy** through color and typography
3. **Feedback animations** for all interactions
4. **Readability optimization** for long-form content
5. **Aesthetic cohesion** with the synthwave theme

## 🔮 Future Enhancements

- [ ] Connect to actual Patreon API
- [ ] Add bookmark functionality
- [ ] Implement search and filtering
- [ ] Add reading progress tracking
- [ ] Enable offline reading mode
- [ ] Add more theme options
- [ ] Implement dark/light mode toggle

## 📱 Screenshots

*(Add screenshots of your app here)*

## 🤝 Contributing

This is a learning/demonstration project. Feel free to fork and experiment!

## 📄 License

MIT License - Feel free to use this code for learning purposes.

## 🌟 Acknowledgments

- Inspired by **DaisyUI's Synthwave theme**
- Built with **Flutter & Riverpod**
- Typography powered by **Google Fonts**

---

**Crafted with 💜 for the cyberpunk aesthetic lovers**
