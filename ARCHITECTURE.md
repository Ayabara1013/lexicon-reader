# 🏛️ Architecture Guide

This document explains the architecture and design patterns used in Lexicon Reader.

## 📐 Architecture Overview

Lexicon Reader follows a **feature-based architecture** with clear separation of concerns:

```
┌─────────────────────────────────────────┐
│            Presentation Layer           │
│   (Screens, Widgets, UI Components)    │
├─────────────────────────────────────────┤
│         State Management Layer          │
│       (Riverpod Providers/Notifiers)    │
├─────────────────────────────────────────┤
│            Domain Layer                 │
│        (Models, Business Logic)         │
├─────────────────────────────────────────┤
│            Data Layer                   │
│      (Mock Data, Future: API calls)     │
└─────────────────────────────────────────┘
```

## 🎯 Design Patterns

### 1. **Provider Pattern (Riverpod)**

We use different types of providers for different use cases:

#### Provider (Immutable Data)
```dart
final chaptersProvider = Provider<List<Chapter>>((ref) {
  return _mockChapters; // Read-only data
});
```
- Used for data that doesn't change
- Cached and shared across the app
- Examples: chapter list, categories

#### StateNotifierProvider (Mutable State)
```dart
final readingPreferencesProvider =
    StateNotifierProvider<ReadingPreferencesNotifier, ReadingPreferences>((ref) {
  return ReadingPreferencesNotifier();
});
```
- Used for state that changes over time
- Provides immutable state with controlled mutations
- Examples: user preferences, navigation state

#### Family Modifier (Parameterized Providers)
```dart
final chapterByIdProvider = Provider.family<Chapter?, String>((ref, id) {
  return chapters.firstWhere((chapter) => chapter.id == id);
});
```
- Creates provider instances based on parameters
- Useful for filtering or selecting specific items

### 2. **Composition Over Inheritance**

Instead of complex widget hierarchies, we compose smaller widgets:

```dart
// ❌ Bad: Monolithic widget
class ComplexCard extends StatelessWidget { ... }

// ✅ Good: Composed from smaller pieces
NeonCard(
  child: Column(
    children: [
      _InfoChip(...),
      _InfoChip(...),
    ],
  ),
)
```

### 3. **Separation of Concerns**

Each file has a single, clear responsibility:

- **Models**: Pure data structures with helper methods
- **Providers**: State management and business logic
- **Widgets**: Reusable UI components
- **Screens**: Complete page layouts
- **Theme**: Visual styling and design system

### 4. **Immutable Data Structures**

All models use immutable data with `copyWith` methods:

```dart
class ReadingPreferences {
  final double fontSize;

  const ReadingPreferences({this.fontSize = 18.0});

  ReadingPreferences copyWith({double? fontSize}) {
    return ReadingPreferences(
      fontSize: fontSize ?? this.fontSize,
    );
  }
}
```

Benefits:
- Predictable state changes
- Easy to track state history
- No accidental mutations

### 5. **Theme System Architecture**

Our theming follows a hierarchical approach:

```
AppTheme.darkTheme (Global)
    ↓
SynthwaveColors (Constants)
    ↓
Theme.of(context) (Local Access)
    ↓
AppTheme Utilities (Helpers)
```

## 🗂️ File Organization

### Models (`/models`)
- **Purpose**: Define data structures
- **Rules**:
  - Immutable classes with `const` constructors
  - Include `copyWith` for updates
  - Add computed properties for derived data
  - Keep business logic minimal

### Providers (`/providers`)
- **Purpose**: State management and data provision
- **Rules**:
  - One provider per concern
  - Use appropriate provider type
  - Keep logic in notifiers, not widgets
  - Export all providers clearly

### Widgets (`/widgets`)
- **Purpose**: Reusable UI components
- **Rules**:
  - Should be theme-agnostic (use `Theme.of(context)`)
  - Accept data via constructor
  - No direct state management
  - Focused on single responsibility

### Screens (`/screens`)
- **Purpose**: Complete page layouts
- **Rules**:
  - Consume providers using `ref.watch/read`
  - Handle navigation
  - Compose from smaller widgets
  - Manage local UI state (animations, etc.)

### Theme (`/theme`)
- **Purpose**: Visual design system
- **Rules**:
  - Define all colors as constants
  - Create reusable styling utilities
  - Use Material 3 theming system
  - Document color usage

## 🔄 Data Flow

### Reading a Chapter

```
1. User taps chapter card
   ↓
2. Navigator.push() to ReaderScreen
   ↓
3. ReaderScreen reads chapterByIdProvider(id)
   ↓
4. Provider fetches chapter from chaptersProvider
   ↓
5. UI renders with chapter data
```

### Updating Reading Preferences

```
1. User adjusts font size slider
   ↓
2. Widget calls notifier.setFontSize(newValue)
   ↓
3. Notifier updates state immutably
   ↓
4. Riverpod notifies all listeners
   ↓
5. Reader text updates automatically
```

## 🎨 Theming Strategy

### Color System
- **Primary colors**: Define the brand (neon pink, cyan, purple)
- **Background colors**: Create depth (deep purple, dark purple)
- **Text colors**: Ensure readability (primary, secondary, dimmed)

### Typography Hierarchy
```
Display → Headlines → Body → Labels
  ↓           ↓        ↓       ↓
Orbitron   Rajdhani  Inter  Rajdhani
(Headers)  (Titles)  (Text) (Labels)
```

### Visual Effects
- **Glow**: BoxShadow with color.withOpacity()
- **Gradient**: LinearGradient for depth
- **Animation**: AnimationController for smooth transitions
- **Border**: Subtle borders for definition

## 🚀 Performance Considerations

### State Management
- ✅ Providers are cached and reused
- ✅ Only widgets that watch a provider rebuild
- ✅ Family providers are memoized by parameter

### Animations
- ✅ Use `vsync` with `SingleTickerProviderStateMixin`
- ✅ Dispose controllers in `dispose()`
- ✅ Use `const` constructors where possible

### Rendering
- ✅ Slivers for efficient scrolling
- ✅ `RepaintBoundary` for complex animations (implicit)
- ✅ `AnimatedBuilder` to limit rebuild scope

## 🧪 Testing Strategy (Future)

### Unit Tests
- Test models (copyWith, computed properties)
- Test providers (state mutations)
- Test utility functions (theme helpers)

### Widget Tests
- Test individual widgets in isolation
- Verify animations work correctly
- Test user interactions

### Integration Tests
- Test complete user flows
- Verify navigation works
- Test state persistence

## 📚 Learning Resources

This architecture demonstrates:

1. **Riverpod** - Modern Flutter state management
2. **Material 3** - Latest Material Design system
3. **Custom Theming** - Building a cohesive design system
4. **Animation** - Creating smooth, polished UX
5. **Composition** - Building complex UIs from simple pieces

## 🔮 Scalability Path

As the app grows, consider:

1. **Repository Pattern** - Abstract data sources
2. **Use Cases/Interactors** - Complex business logic
3. **Dependency Injection** - More provider overrides
4. **Feature Modules** - Separate feature folders
5. **Code Generation** - Freezed, json_serializable, etc.

---

This architecture provides a solid foundation for a maintainable, testable, and scalable Flutter application while keeping the codebase clean and understandable.
