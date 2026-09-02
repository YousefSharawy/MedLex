import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:medlex/app/resources/assets_manager.dart';
import 'package:medlex/app/resources/color_manager.dart';
import 'package:medlex/app/resources/routes.dart';
import 'package:medlex/app/resources/values_manager.dart';
import 'section_row.dart';

class TopSectionCard extends StatelessWidget {
  const TopSectionCard({super.key});
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: ColorManager.white,
        borderRadius: BorderRadius.circular(AppRadius.s16),
      ),
      child: InkWell(
        onTap: () => context.push(Routes.savedItems),
        borderRadius: BorderRadius.circular(AppRadius.s16),
        child: Column(
          children: [
            SizedBox(height: AppHeight.s16),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: AppWidth.s20),
              child: SectionRow(
                icon: IconAssets.savedItemSection,
                label: 'Saved Terms',
                onTap: () => context.push(Routes.savedItems),
              ),
            ),
            SizedBox(height: AppHeight.s8),
            Divider(),
            SizedBox(height: AppHeight.s8),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: AppWidth.s20),
              child: SectionRow(
                icon: IconAssets.timeCircle,
                label: 'Recently Viewed',
                onTap: () => context.push(Routes.recentlyViewed),
                iconWidth: AppWidth.s20,
                iconHeight: AppHeight.s20,
                iconColor: ColorManager.grayIcon,
              ),
            ),
            SizedBox(height: AppHeight.s16),
          ],
        ),
      ),
    );
  }
}
