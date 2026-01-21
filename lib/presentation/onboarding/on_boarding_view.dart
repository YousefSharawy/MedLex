import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:transly/presentation/base/components.dart';
import 'package:transly/presentation/base/primary_widgets.dart';
import 'package:transly/presentation/onboarding/points_column.dart';
import 'package:transly/presentation/resources/assets_manager.dart';
import 'package:transly/presentation/resources/color_manager.dart';
import 'package:transly/presentation/resources/font_manager.dart';
import 'package:transly/presentation/resources/routes.dart';
import 'package:transly/presentation/resources/style_manager.dart';
import 'package:transly/presentation/resources/values_manager.dart';

class OnBoardingView extends StatelessWidget {
  const OnBoardingView({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [ColorManager.splashGradiant1, ColorManager.splashGradiant2],
        ),
      ),
      child: PrimaryScaffold(
        backgroundColor: ColorManager.trasnparent,
        appBar: AppBar(
          backgroundColor: ColorManager.trasnparent,
          elevation: 0,
          leading: Padding(
            padding: EdgeInsets.only(left: AppWidth.s24),
            child: IconButton(
              icon: const Icon(
                size: 30,
                Icons.chevron_left,
                color: ColorManager.white,
              ),
              onPressed: () => (context).pop(),
            ),
          ),
        ),
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(height: AppHeight.s16),

            Image.asset(ImageAssets.secondSplashImage),

            Text(
              style: getBoldStyle(
                color: ColorManager.white,
                fontSize: FontSize.s24,
              ),
              "Study Smarter,",
            ),
            Text(
              style: getBoldStyle(
                color: ColorManager.white,
                fontSize: FontSize.s24,
              ),
              "not harder",
            ),
            SizedBox(height: AppHeight.s19),
            PointsColumn(),
            SizedBox(height: AppHeight.s33),
            PrimaryElevatedButton(
              title: "Next",
              height: AppHeight.s46,
              width: AppWidth.s267,
              backGroundColor: ColorManager.white,
              buttonRadius: AppRadius.s16,
              textStyle: getBoldStyle(
                fontSize: FontSize.s14,
                fontFamily: FontConstants.interFamily,
                color: ColorManager.primary,
              ),
              onPress: () {
                context.go(Routes.home);
              }
            ),
          ],
        ),
      ),
    );
  }
}
