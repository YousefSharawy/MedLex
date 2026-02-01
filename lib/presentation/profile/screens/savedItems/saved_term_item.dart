import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:transly/app/ui_utiles.dart';
import 'package:transly/domain/models.dart';
import 'package:transly/presentation/resources/assets_manager.dart';
import 'package:transly/presentation/resources/color_manager.dart';
import 'package:transly/presentation/resources/font_manager.dart';
import 'package:transly/presentation/resources/style_manager.dart';
import 'package:transly/presentation/resources/values_manager.dart';

class SavedTermItem extends StatelessWidget {
  final TermModel term;
  final VoidCallback onTap;
  final VoidCallback onBookmarkTap;

  const SavedTermItem({
    super.key,
    required this.term,
    required this.onTap,
    required this.onBookmarkTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
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
            // Image
            SizedBox(
              width: AppWidth.s59,
              height: AppHeight.s66,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(AppRadius.s8),
                child: term.imageUrl != null && term.imageUrl!.isNotEmpty
                    ? UiUtils.cachedNetworkImage(
                        imageUrl: term.imageUrl,
                        height: AppHeight.s66,
                        width: AppWidth.s59,
                        fit: BoxFit.cover,
                      )
                    : _buildPlaceholder(),
              ),
            ),
            SizedBox(width: AppWidth.s15),

            // Title & Category
            Expanded(
              child: Padding(
                padding: EdgeInsets.symmetric(vertical: AppHeight.s3),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
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

            // Bookmark Icon (always active in saved view)
            GestureDetector(
              onTap: onBookmarkTap,
              child: Padding(
                padding: EdgeInsets.all(8.sp),
                child: Image.asset(IconAssets.bookmarkActive),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildPlaceholder() {
    return Container(
      width: AppWidth.s59,
      height: AppHeight.s66,
      decoration: BoxDecoration(
        color: ColorManager.tealSoft.withOpacity(0.5),
        borderRadius: BorderRadius.circular(AppRadius.s8),
      ),
      child: Icon(
        Icons.medical_information_outlined,
        size: 28,
        color: ColorManager.secondaryText.withOpacity(0.5),
      ),
    );
  }
}