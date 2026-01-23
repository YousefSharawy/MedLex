import 'package:flutter/material.dart';
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
  State<PersistentSearchBar> createState() => _PersistentSearchBarState();
}

class _PersistentSearchBarState extends State<PersistentSearchBar>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _scaleAnimation;
  late Animation<double> _opacityAnimation;
  final TextEditingController _searchController = TextEditingController();
  final FocusNode _focusNode = FocusNode();

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 300),
      vsync: this,
    );

    _scaleAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _controller, curve: Curves.elasticOut),
    );

    _opacityAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: _controller,
        curve: const Interval(0.0, 0.5, curve: Curves.easeIn),
      ),
    );

    // Start animation if already searching
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
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    _searchController.dispose();
    _focusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Row(
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
                  color: ColorManager.black.withAlpha(widget.isSearching ? 25 : 20),
                  width: widget.isSearching ? 1.5 : 1,
                ),
              ),
              child: Row(
                children: [
                  SizedBox(width: AppWidth.s16),
                  Image.asset(IconAssets.searchicon),
                  SizedBox(width: AppWidth.s8),
                  Expanded(
                    child: widget.isSearching
                        ? TextField(
                            controller: _searchController,
                            focusNode: _focusNode,
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
                  onTap: widget.onSearchClose,
                  child: Container(
                    width: 36,
                    height: 36,
                    decoration: BoxDecoration(
                      color: ColorManager.grey.withOpacity(0.1),
                      shape: BoxShape.circle,
                    ),
                    child: Icon(
                      Icons.close,
                      color: ColorManager.grey,
                      size: 20,
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}