import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:medlex/app/resources/routes.dart';
import 'package:medlex/app/ui_utils.dart';
import 'package:medlex/cubit/recently_viewed_cubit.dart';
import 'package:medlex/domain/models.dart';
import 'package:medlex/presentation/home/view/widgets/term_bookmark_button.dart';
import 'package:medlex/app/resources/color_manager.dart';
import 'package:medlex/app/resources/font_manager.dart';
import 'package:medlex/app/resources/style_manager.dart';
import 'package:medlex/app/resources/values_manager.dart';

class TermItem extends StatelessWidget {
  final TermModel term;

  const TermItem({super.key, required this.term,});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        context.read<RecentlyViewedCubit>().addToRecentlyViewed(term);
        context.read<RecentlyViewedCubit>().addToRecentlyViewedHistory(term);
        context.push(Routes.termDetails, extra: term);
      },
      child: Container(
        margin: EdgeInsets.only(bottom: AppHeight.s12),
        padding: EdgeInsets.symmetric(
          horizontal: AppWidth.s10,
          vertical: AppHeight.s7,
        ),
        decoration: BoxDecoration(
          color: ColorManager.white,
          border: Border.all(color: ColorManager.black.withAlpha(25)),
          borderRadius: BorderRadius.circular(AppRadius.s16),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.03),
              blurRadius: 8,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Row(
          children: [
            SizedBox(
              width: AppWidth.s59,
              height: AppHeight.s66,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(AppRadius.s8),
                child:
                    term.imageUrl != null && term.imageUrl!.isNotEmpty
                        ? UiUtils.cachedNetworkImage(
                          imageUrl: term.imageUrl,
                          height: AppHeight.s66,
                          width: AppWidth.s59,
                          fit: BoxFit.cover,
                        )
                        : UiUtils.termItemNoImagePlaceholder(),
              ),
            ),
            SizedBox(width: AppWidth.s15),
            Expanded(
              child: Padding(
                padding: EdgeInsets.symmetric(vertical: AppHeight.s3),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      term.latinTerm,
                      style: getRegularStyle(
                        fontSize: FontSize.s15,
                        fontFamily: FontConstants.interFamily,
                        color: ColorManager.primaryText,
                      ),
                    ),
                    SizedBox(height: AppHeight.s8),
                    Text(
                      term.category,
                      style: getRegularStyle(
                        fontSize: FontSize.s12,
                        fontFamily: FontConstants.interFamily,
                        color: ColorManager.secondaryText,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            TermBookmarkButton(term: term),
          ],
        ),
      ),
    );
  }
}
