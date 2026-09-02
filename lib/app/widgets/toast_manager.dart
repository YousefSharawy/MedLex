import 'package:flutter/material.dart';
import 'package:medlex/app/resources/values_manager.dart';
import 'custom_toast.dart';

class ToastManager {
  static OverlayEntry? _currentEntry;

  static void show(
    BuildContext context, {
    required String message,
    String? icon,
    String? actionLabel,
    VoidCallback? onAction,
    Duration duration = const Duration(seconds: 3),
  }) {
     if (!context.mounted) return;
    dismiss();
        final bottomPadding = MediaQuery.of(context).padding.bottom;
    final overlay = Overlay.of(context);
    late OverlayEntry entry;
    entry = OverlayEntry(
      builder:
          (_) => Positioned(
            bottom:  bottomPadding+ AppWidth.s20,
            left: 0,
            right: 0,
            child: CustomToast(
              message: message,
              icon: icon,
              actionLabel: actionLabel,
              onAction: onAction,
              duration: duration,
              onDismiss: () {
                entry.remove();
                if (_currentEntry == entry) _currentEntry = null;
              },
            ),
          ),
    );

    _currentEntry = entry;
    overlay.insert(entry);
  }

  static void dismiss() {
    _currentEntry?.remove();
    _currentEntry = null;
  }
}
