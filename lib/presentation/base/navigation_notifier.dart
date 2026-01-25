// lib/presentation/navigation/navigation_state.dart
import 'package:flutter/material.dart';

class NavigationStateNotifier extends ChangeNotifier {
  int _currentIndex = 0;
  int _previousIndex = 0;

  int get currentIndex => _currentIndex;
  int get previousIndex => _previousIndex;

  void updateIndex(int newIndex) {
    if (_currentIndex != newIndex) {
      _previousIndex = _currentIndex;
      _currentIndex = newIndex;
      notifyListeners();
    }
  }
}

// Global instance (or use Provider/Riverpod)
final navigationStateNotifier = NavigationStateNotifier();
mixin ResettableTabState<T extends StatefulWidget> on State<T> {
  /// The tab index this screen belongs to
  int get tabIndex;

  /// Override this to reset your screen's state
  void resetState();

  VoidCallback? _listener;

  @override
  void initState() {
    super.initState();
    _listener = () {
      // Reset when navigating away from this tab
      if (navigationStateNotifier.previousIndex == tabIndex &&
          navigationStateNotifier.currentIndex != tabIndex) {
        resetState();
      }
    };
    navigationStateNotifier.addListener(_listener!);
  }

  @override
  void dispose() {
    if (_listener != null) {
      navigationStateNotifier.removeListener(_listener!);
    }
    super.dispose();
  }
}