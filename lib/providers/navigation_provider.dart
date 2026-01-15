import 'package:flutter_riverpod/flutter_riverpod.dart';

/// Navigation state notifier
class NavigationNotifier extends StateNotifier<int> {
  NavigationNotifier() : super(0);

  void setIndex(int index) {
    state = index;
  }
}

/// Provider for bottom navigation
final navigationProvider = StateNotifierProvider<NavigationNotifier, int>((ref) {
  return NavigationNotifier();
});
