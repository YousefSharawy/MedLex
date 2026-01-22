import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:transly/presentation/resources/assets_manager.dart';
import 'package:transly/presentation/resources/color_manager.dart';
import 'package:transly/presentation/resources/font_manager.dart';
import 'package:transly/presentation/resources/style_manager.dart';
import 'package:transly/presentation/resources/values_manager.dart';
import 'package:transly/presentation/resources/routes.dart';

class HomeSearchBar extends StatelessWidget {
  const HomeSearchBar({super.key});
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => context.push(Routes.search),
      child: Container(
        height: AppHeight.s48,
        width: AppWidth.s343,
        decoration: BoxDecoration(
          color: ColorManager.white,
          borderRadius: BorderRadius.circular(AppRadius.s32),
          border: Border.all(color: ColorManager.black.withAlpha(20), width: 1),
        ),
        child: Row(
          children: [
            SizedBox(width: AppWidth.s16),
            Image.asset(IconAssets.searchicon),
            SizedBox(width: AppWidth.s8),
            Text(
              'Search medical terms',
              style: getRegularStyle(
                fontSize: FontSize.s12,
                fontFamily: FontConstants.interFamily,
                color: ColorManager.secondaryText,
              ),
            ),
          ],
        ),
      ),
    );
  }
}