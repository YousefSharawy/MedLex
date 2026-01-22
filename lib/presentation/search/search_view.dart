import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:transly/presentation/resources/assets_manager.dart';
import 'package:transly/presentation/resources/color_manager.dart';
import 'package:transly/presentation/resources/font_manager.dart';
import 'package:transly/presentation/resources/style_manager.dart';
import 'package:transly/presentation/resources/values_manager.dart';

class SearchView extends StatefulWidget {
  const SearchView({super.key});

  @override
  State<SearchView> createState() => _SearchViewState();
}

class _SearchViewState extends State<SearchView>
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

    // Start animation and focus after build
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _controller.forward();
      _focusNode.requestFocus();
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    _searchController.dispose();
    _focusNode.dispose();
    super.dispose();
  }

  void _onClose() async {
    _focusNode.unfocus();
    await _controller.reverse();
    if (mounted) {
      context.pop();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            SizedBox(height: AppHeight.s10),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: AppWidth.s16),
              child: Row(
                children: [
                  // Search Bar
                  Expanded(
                    child: Container(
                      height: AppHeight.s48,
                      decoration: BoxDecoration(
                        color: ColorManager.white,
                        borderRadius: BorderRadius.circular(AppRadius.s32),
                        border: Border.all(
                          color: ColorManager.black.withAlpha(25),
                          width: 1.5,
                        ),
                      ),
                      child: Row(
                        children: [
                          SizedBox(width: AppWidth.s16),
                          Image.asset(IconAssets.searchicon),
                          SizedBox(width: AppWidth.s8),
                          Expanded(
                            child: TextField(
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
                                disabledBorder: InputBorder.none,
                                errorBorder: InputBorder.none,
                                focusedErrorBorder: InputBorder.none,
                                focusedBorder: OutlineInputBorder(
                                  borderSide: BorderSide.none,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  // Animated X Button
                  AnimatedBuilder(
                    animation: _controller,
                    builder: (context, child) {
                      return Opacity(
                        opacity: _opacityAnimation.value,
                        child: Transform.scale(
                          scale: _scaleAnimation.value,
                          child: child,
                        ),
                      );
                    },
                    child: Padding(
                      padding: EdgeInsets.only(left: AppWidth.s12),
                      child: GestureDetector(
                        onTap: _onClose,
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
                ],
              ),
            ),
            SizedBox(height: AppHeight.s20),

            Expanded(
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: AppWidth.s16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Your search results content here
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
