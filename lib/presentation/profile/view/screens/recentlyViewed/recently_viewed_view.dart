import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:medlex/app/ui_utils.dart';
import 'package:medlex/cubit/recently_viewed_cubit.dart';
import 'package:medlex/presentation/profile/view/screens/savedTerms/widgets/saved_terms_list.dart';
import 'package:medlex/app/resources/color_manager.dart';
import 'package:medlex/app/resources/font_manager.dart';
import 'package:medlex/app/resources/style_manager.dart';
import 'package:medlex/app/resources/values_manager.dart';
import 'package:medlex/presentation/base/primary_teal_scaffold.dart';

class RecentlyViewedView extends StatefulWidget {
  const RecentlyViewedView({super.key});

  @override
  State<RecentlyViewedView> createState() => _RecentlyViewedViewState();
}

class _RecentlyViewedViewState extends State<RecentlyViewedView> {
  @override
  // void initState() {
  //   super.initState();
  //   final cubit = context.read<TermsCubit>();
  //   final recentlyViewed = cubit.recentlyViewedHistory;
  // }

  @override
  Widget build(BuildContext context) {
    return PrimaryTealScaffold(
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
                    'Recently Viewed',
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
            Expanded(child: _buildContent()),
          ],
        ),
      ),
    );
  }
  Widget _buildContent() {
  final terms = context.read<RecentlyViewedCubit>().recentlyViewedHistory;
  if (terms.isEmpty) return  UiUtils.emptyWidget(message: "Nothing here yet",subMessage: "Terms you open will appear here so you can quickly get back to them");
  return TermsList(terms: terms);
}
}
