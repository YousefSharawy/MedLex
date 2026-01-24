import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:transly/presentation/base/components.dart';
import 'package:transly/presentation/profile/screens/savedItems/saved_term_item.dart';
import 'package:transly/presentation/resources/color_manager.dart';
import 'package:transly/presentation/resources/font_manager.dart';
import 'package:transly/presentation/resources/style_manager.dart';
import 'package:transly/presentation/resources/values_manager.dart';

class SavedTermsView extends StatelessWidget {
  const SavedTermsView({super.key});

  @override
  Widget build(BuildContext context) {
    return PrimaryScaffold(
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: AppHeight.s21),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: AppWidth.s16),
              child: Row(
                children: [
                  GestureDetector(
                    onTap: () => context.pop(),
                    child: Icon(
                      Icons.arrow_back_ios_new,
                      color: ColorManager.primaryText,
                      size: 24.sp,
                    ),
                  ),
                  SizedBox(width: AppWidth.s66),
                  Text(
                    'Saved Terms',
                    style: getBoldStyle(
                      fontSize: FontSize.s24,
                      fontFamily: FontConstants.interFamily,
                      color: ColorManager.primaryText,
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: AppHeight.s17),
            Expanded(
              child: ListView.separated(
                padding: EdgeInsets.symmetric(horizontal: AppWidth.s16),
                itemCount: 6,
                separatorBuilder: (_, __) => SizedBox(height: AppHeight.s10),
                itemBuilder: (context, index) {
                  return SavedTermItem(
                    title: 'Myocardium',
                    category: 'Cardiology',
                    onTap: () {},
                    onBookmarkTap: () {},
                  );
                },
              ),
            ),
            SizedBox(height: AppHeight.s100),
          ],
        ),
      ),
    );
  }
}

