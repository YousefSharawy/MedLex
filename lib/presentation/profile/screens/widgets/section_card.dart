import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:transly/presentation/resources/assets_manager.dart';
import 'package:transly/presentation/resources/color_manager.dart';
import 'package:transly/presentation/resources/font_manager.dart';
import 'package:transly/presentation/resources/routes.dart';
import 'package:transly/presentation/resources/style_manager.dart';
import 'package:transly/presentation/resources/values_manager.dart';

class SectionCard extends StatelessWidget {
  const SectionCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: AppHeight.s56,
      decoration: BoxDecoration(
        color: ColorManager.white,
        borderRadius: BorderRadius.circular(AppRadius.s16),
      ),
      child: InkWell(
        onTap: () => context.push(Routes.savedItems),
        borderRadius: BorderRadius.circular(AppRadius.s16),
        child: Padding(
          padding: EdgeInsets.symmetric(
            horizontal: AppWidth.s20,
            vertical: AppHeight.s18,
          ),
          child: Row(
            children: [
              Image.asset(IconAssets.savedItemSection),
              SizedBox(width: AppWidth.s12),
              Expanded(
                child: Text(
                  'Saved Terms',
                  style: getRegularStyle(
                    fontSize: FontSize.s15,
                    fontFamily: FontConstants.interFamily,
                    color: ColorManager.primaryText,
                  ),
                ),
              ),
              Icon(
                Icons.chevron_right,
                color: ColorManager.chevronRight,
                size: 20,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
