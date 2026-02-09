import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:transly/cubit/cubit/app_cubit.dart';
import 'package:transly/presentation/resources/assets_manager.dart';
import 'package:transly/presentation/resources/color_manager.dart';
import 'package:transly/presentation/resources/font_manager.dart';
import 'package:transly/presentation/resources/style_manager.dart';
import 'package:transly/presentation/resources/values_manager.dart';

class PersistentSearchBar extends StatefulWidget {
  final bool isSearching;
  final VoidCallback onSearchStart;
  final VoidCallback onSearchClose;

  const PersistentSearchBar({
    super.key,
    required this.isSearching,
    required this.onSearchStart,
    required this.onSearchClose,
  });

  @override
  State<PersistentSearchBar> createState() => PersistentSearchBarState();
}

class PersistentSearchBarState extends State<PersistentSearchBar>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _scaleAnimation;
  late Animation<double> _opacityAnimation;
  final TextEditingController _searchController = TextEditingController();
  final FocusNode _focusNode = FocusNode();

  // Debounce timer
  Timer? _debounceTimer;
  static const Duration _debounceDuration = Duration(milliseconds: 400);
  void setSearchText(String text) {
    _searchController.text = text;
    _debounceTimer?.cancel();
    if (text.trim().isNotEmpty) {
      context.read<AppCubit>().searchTerms(text.trim());
    }
  }
  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 300),
      vsync: this,
    );
    _scaleAnimation = Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(CurvedAnimation(parent: _controller, curve: Curves.elasticOut));
    _opacityAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: _controller,
        curve: const Interval(0.0, 0.5, curve: Curves.easeIn),
      ),
    );
    if (widget.isSearching) {
      _controller.forward();
    }
  }

  @override
  void didUpdateWidget(PersistentSearchBar oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.isSearching && !oldWidget.isSearching) {
      _controller.forward();
      _focusNode.requestFocus();
    } else if (!widget.isSearching && oldWidget.isSearching) {
      _controller.reverse();
      _focusNode.unfocus();
      _searchController.clear();
      _debounceTimer?.cancel();
    }
  }

  @override
  void dispose() {
    _debounceTimer?.cancel();
    _controller.dispose();
    _searchController.dispose();
    _focusNode.dispose();
    super.dispose();
  }

  void _onTextChanged(String query) {
    _debounceTimer?.cancel();

    _debounceTimer = Timer(_debounceDuration, () {
      if (query.trim().isNotEmpty) {
        context.read<AppCubit>().searchTerms(query.trim());
      } else {
        context.read<AppCubit>().clearSearchResults();
      }
    });
  }

  // Handle when user presses Enter/Submit
  void _onSubmitted(String query) {
    // Cancel debounce timer
    _debounceTimer?.cancel();

    // Immediately search
    if (query.trim().isNotEmpty) {
      context.read<AppCubit>().searchTerms(query.trim());
    }
  }

  void _onClose() {
    _debounceTimer?.cancel();
    _searchController.clear();
    context.read<AppCubit>().clearSearchResults();
    widget.onSearchClose();
  }

  void _clearText() {
    _debounceTimer?.cancel();
    _searchController.clear();
    context.read<AppCubit>().clearSearchResults();
    _focusNode.requestFocus();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<AppCubit, AppState>(
      listenWhen: (previous, current) {
        if (current is! HomeLoaded) return false;
        if (previous is! HomeLoaded) return true;
        return current.pendingSearchText != previous.pendingSearchText;
      },
      listener: (context, state) {
        if (state is HomeLoaded && state.pendingSearchText != null) {
          if (state.pendingSearchText!.isNotEmpty && widget.isSearching) {
            _searchController.text = state.pendingSearchText!;
            context.read<AppCubit>().clearPendingSearchText();
          }
        }
      },
      child: Row(
        children: [
          Expanded(
            child: GestureDetector(
              onTap: widget.isSearching ? null : widget.onSearchStart,
              child: Container(
                height: AppHeight.s48,
                decoration: BoxDecoration(
                  color: ColorManager.white,
                  borderRadius: BorderRadius.circular(AppRadius.s32),
                  border: Border.all(
                    color:
                        widget.isSearching
                            ? ColorManager.primary.withAlpha(127)
                            : ColorManager.black.withAlpha(20),
                    width: widget.isSearching ? 1.5.sp : 1.sp,
                  ),
                ),
                child: Row(
                  children: [
                    SizedBox(width: AppWidth.s16),
                    Image.asset(IconAssets.searchicon),
                    SizedBox(width: AppWidth.s8),
                    Expanded(
                      child:
                          widget.isSearching
                              ? TextField(
                                controller: _searchController,
                                focusNode: _focusNode,
                                textInputAction: TextInputAction.search,
                                onChanged: _onTextChanged,
                                onSubmitted: _onSubmitted,
                                decoration: InputDecoration(
                                  filled: false,
                                  isDense: true,
                                  hintText: 'Search medical terms',
                                  hintStyle: getRegularStyle(
                                    fontSize: FontSize.s12,
                                    fontFamily: FontConstants.interFamily,
                                    color: ColorManager.secondaryText,
                                  ),
                                  border: InputBorder.none,
                                  enabledBorder: InputBorder.none,
                                  focusedBorder: InputBorder.none,
                                ),
                              )
                              : Text(
                                'Search medical terms',
                                style: getRegularStyle(
                                  fontSize: FontSize.s12,
                                  fontFamily: FontConstants.interFamily,
                                  color: ColorManager.secondaryText,
                                ),
                              ),
                    ),
                    // Clear text button (shows when there's text)
                    if (widget.isSearching)
                      ValueListenableBuilder<TextEditingValue>(
                        valueListenable: _searchController,
                        builder: (context, value, child) {
                          if (value.text.isNotEmpty) {
                            return GestureDetector(
                              onTap: _clearText,
                              child: Padding(
                                padding: EdgeInsets.only(right: AppWidth.s12),
                                child: Icon(
                                  Icons.clear,
                                  color: ColorManager.grey,
                                  size: 20.sp,
                                ),
                              ),
                            );
                          }
                          return const SizedBox.shrink();
                        },
                      ),
                  ],
                ),
              ),
            ),
          ),
          // X Button with animation
          SizeTransition(
            sizeFactor: _opacityAnimation,
            axis: Axis.horizontal,
            child: FadeTransition(
              opacity: _opacityAnimation,
              child: ScaleTransition(
                scale: _scaleAnimation,
                child: Padding(
                  padding: EdgeInsets.only(left: AppWidth.s12),
                  child: GestureDetector(
                    onTap: _onClose,
                    child: Container(
                      width: AppWidth.s36,
                      height: AppHeight.s36,
                      decoration: BoxDecoration(
                        color: ColorManager.grey.withOpacity(0.1),
                        shape: BoxShape.circle,
                      ),
                      child: Icon(
                        Icons.close,
                        color: ColorManager.grey,
                        size: 20.sp,
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
