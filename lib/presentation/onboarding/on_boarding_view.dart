import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:medlex/app/local_storage.dart';
import 'package:medlex/presentation/base/primary_elevated_button.dart';
import 'package:medlex/presentation/onboarding/points_column.dart';
import 'package:medlex/app/resources/assets_manager.dart';
import 'package:medlex/app/resources/color_manager.dart';
import 'package:medlex/app/resources/font_manager.dart';
import 'package:medlex/app/resources/routes.dart';
import 'package:medlex/app/resources/style_manager.dart';
import 'package:medlex/app/resources/values_manager.dart';
import 'package:medlex/presentation/base/primary_teal_scaffold.dart';

class OnBoardingView extends StatelessWidget {
  const OnBoardingView({super.key});

  Future<void> _onNextPressed(BuildContext context) async {
    // Mark onboarding as completed
    await LocalAppStorage.setOnboardingCompleted();

    // Navigate to home
    if (context.mounted) {
      context.go(Routes.home);
    }
  }

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
      child: PrimaryTealScaffold(
        backgroundColor: ColorManager.trasnparent,
        appBar: AppBar(
          backgroundColor: ColorManager.trasnparent,
          elevation: 0,
          leading: Padding(
            padding: EdgeInsets.only(left: AppWidth.s24),
            child: IconButton(
              icon: Icon(
                size: 30.sp,
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
                color: ColorManager.primaryTeal,
              ),
              onPress: () => _onNextPressed(context),
            ),
          ],
        ),
      ),
    );
  }
}
