import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:medlex/app/resources/color_manager.dart';
import 'package:medlex/app/resources/font_manager.dart';
import 'package:medlex/app/resources/style_manager.dart';
import 'package:medlex/app/resources/values_manager.dart';

class CustomToast extends StatefulWidget {
  final String message;
  final String? icon;
  final String? actionLabel;
  final VoidCallback? onAction;
  final VoidCallback onDismiss;
  final Duration duration;

  const CustomToast({
    super.key,
    required this.message,
    required this.onDismiss,
    this.icon,
    this.actionLabel,
    this.onAction,
    this.duration = const Duration(seconds: 3),
  });
  @override
  State<CustomToast> createState() => _CustomToastState();
}

class _CustomToastState extends State<CustomToast>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;
  late final Animation<Offset> _slideAnimation;
  late final Animation<double> _fadeAnimation;
  Timer? _autoDismissTimer;
  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 300),
    );
    _slideAnimation = Tween<Offset>(
      begin: const Offset(0, 1),
      end: Offset.zero,
    ).animate(CurvedAnimation(parent: _controller, curve: Curves.easeOutCubic));
    _fadeAnimation = Tween<double>(
      begin: 0,
      end: 1,
    ).animate(CurvedAnimation(parent: _controller, curve: Curves.easeOut));
    _controller.forward();
    _startAutoDismiss();
  }

  void _startAutoDismiss() {
    _autoDismissTimer = Timer(widget.duration, _dismiss);
  }

  Future<void> _dismiss() async {
    _autoDismissTimer?.cancel();
    if (!mounted) return;
    await _controller.reverse();
    if (mounted) widget.onDismiss();
  }

  @override
  void dispose() {
    _autoDismissTimer?.cancel();
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      type: MaterialType.transparency,
      child: SlideTransition(
        position: _slideAnimation,
        child: FadeTransition(
          opacity: _fadeAnimation,
          child: Container(
            margin: EdgeInsets.symmetric(horizontal: AppWidth.s16),
            padding: EdgeInsets.symmetric(
              horizontal: AppWidth.s16,
              vertical: AppHeight.s14,
            ),
            decoration: BoxDecoration(
              color: ColorManager.primaryText,
              borderRadius: BorderRadius.circular(AppRadius.s16),
            ),
            child: Row(
              children: [
                widget.icon == null
                    ? SizedBox(width: AppWidth.s4)
                    : Image.asset(
                      color: ColorManager.primaryTeal,
                      widget.icon!,
                      width: AppWidth.s24,
                      height: AppHeight.s24,
                    ),
                SizedBox(width: AppWidth.s12),
                Expanded(
                  child: Text(
                    widget.message,
                    style: getBoldStyle(
                      fontSize: FontSize.s12,
                      color: ColorManager.white,
                      fontFamily: FontConstants.interFamily,
                    ),
                  ),
                ),
                if (widget.actionLabel != null) ...[
                  GestureDetector(
                    onTap: () {
                      widget.onAction?.call();
                      _dismiss();
                    },
                    child: Text(
                      widget.actionLabel!,
                      style: getRegularStyle(
                        color: ColorManager.primaryTeal,
                        fontSize: FontSize.s12,
                        fontFamily: FontConstants.interFamily,
                      ),
                    ),
                  ),
                ],
                SizedBox(width: AppWidth.s4,),
                GestureDetector(
                  onTap: _dismiss,
                  child: Icon(
                    Icons.close,
                    color: ColorManager.chevronRight,
                    size: 16.sp,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
