import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:transly/app/ui_utiles.dart';
import 'package:transly/cubit/cubit/app_cubit.dart';
import 'package:transly/domain/models.dart';
import 'package:transly/presentation/resources/assets_manager.dart';
import 'package:transly/presentation/resources/color_manager.dart';
import 'package:transly/presentation/resources/font_manager.dart';
import 'package:transly/presentation/resources/style_manager.dart';
import 'package:transly/presentation/resources/values_manager.dart';

class RecentlyViewedItem extends StatelessWidget {
  final TermModel term;
  final VoidCallback? onTap;

  const RecentlyViewedItem({super.key, required this.term, this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
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
            _buildBookmarkButton(context),
          ],
        ),
      ),
    );
  }

  Widget _buildBookmarkButton(BuildContext context) {
    return BlocSelector<AppCubit, AppState, bool>(
      selector: (state) {
        if (state is HomeLoaded) {
          return state.favoriteIds.contains(term.id);
        }
        return context.read<AppCubit>().isFavorite(term.id);
      },
      builder: (context, isFavorite) {
        return GestureDetector(
          onTap: () {
            context.read<AppCubit>().toggleFavorite(term);
          },
          child: Padding(
            padding: EdgeInsets.all(8.sp),
            child:
                isFavorite
                    ? Image.asset(IconAssets.bookmarkActive)
                    : Image.asset(IconAssets.bookmark),
          ),
        );
      },
    );
  }
}
