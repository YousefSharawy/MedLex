import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:transly/app/di.dart';
import 'package:transly/app/tts_service.dart';
import 'package:transly/app/ui_utiles.dart';
import 'package:transly/cubit/cubit/app_cubit.dart';
import 'package:transly/domain/models.dart';
import 'package:transly/presentation/resources/assets_manager.dart';
import 'package:transly/presentation/resources/color_manager.dart';
import 'package:transly/presentation/resources/font_manager.dart';
import 'package:transly/presentation/resources/routes.dart';
import 'package:transly/presentation/resources/style_manager.dart';
import 'package:transly/presentation/resources/values_manager.dart';

class DailyTermCard extends StatelessWidget {
  const DailyTermCard({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AppCubit, AppState>(
      buildWhen: (previous, current) => current is HomeLoaded,
      builder: (context, state) {
        if (state is! HomeLoaded) {
          return UiUtils.loadingCard();
        }
        if (state.isLoading) {
          return UiUtils.loadingCard();
        }
        if (state.errorMessage != null) {
          return UiUtils.errorCard(
            message: state.errorMessage!,
            onRetry: () => context.read<AppCubit>().getDailyTerm(),
          );
        }
        if (state.dailyTerm != null) {
          return _buildTermCard(context, state.dailyTerm!, state.favoriteIds);
        }
        return UiUtils.loadingCard();
      },
    );
  }

  void _speakPronunciation( String term) {
    getIt<TtsService>().speakPronunciation(term);
  }

  Widget _buildTermCard(
      BuildContext context, TermModel term, List<int> favoriteIds) {
    final isFavorite = favoriteIds.contains(term.id);

    return GestureDetector(
      onTap: () {
        context.read<AppCubit>().addToRecentlyViewed(term);
        context.push(Routes.termDetails, extra: term);
      },
      child: Container(
        width: double.infinity,
        padding: EdgeInsets.only(top: AppHeight.s9, bottom: AppHeight.s15),
        decoration: UiUtils.cardDecoration(),
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: AppWidth.s16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Bookmark button at top right
              Align(
                alignment: Alignment.topRight,
                child: GestureDetector(
                  onTap: () => context.read<AppCubit>().toggleFavorite(term),
                  child: Padding(
                    padding: EdgeInsets.all(4.sp),
                    child: isFavorite
                        ? Image.asset(IconAssets.bookmarkActive)
                        : Image.asset(IconAssets.bookmark),
                  ),
                ),
              ),
              Center(
                child: term.imageUrl != null && term.imageUrl!.isNotEmpty
                    ? UiUtils.cachedNetworkImage(
                        imageUrl: term.imageUrl,
                        height: AppHeight.s144,
                        borderRadius: BorderRadius.circular(AppRadius.s12),
                      )
                    : UiUtils.dailyTermNoImagePlaceholder(),
              ),
              SizedBox(height: AppHeight.s14),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: Text(
                      term.latinTerm,
                      style: getSemiBoldStyle(
                        fontSize: FontSize.s16,
                        fontFamily: FontConstants.interFamily,
                        color: ColorManager.primaryText,
                      ),
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.symmetric(
                      horizontal: AppHeight.s10,
                      vertical: AppWidth.s7,
                    ),
                    decoration: BoxDecoration(
                      color: ColorManager.tealSoft,
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Text(
                      term.category,
                      style: getRegularStyle(
                        fontSize: FontSize.s12,
                        fontFamily: FontConstants.interFamily,
                        color: ColorManager.primaryText,
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(height: AppHeight.s8),
              if (term.pronunciation.isNotEmpty)
                Row(
                  children: [
                    Text(
                      term.pronunciation,
                      style: getRegularStyle(
                        fontSize: FontSize.s12,
                        fontFamily: FontConstants.interFamily,
                        color: ColorManager.secondaryText,
                      ),
                    ),
                    SizedBox(width: AppWidth.s9),
                    GestureDetector(
                      onTap: () => _speakPronunciation(
                        term.latinTerm
                      ),
                      child: Image.asset(IconAssets.volumeUp),
                    ),
                  ],
                ),
              SizedBox(height: AppHeight.s8),
              Text(
                term.englishDefinition.isNotEmpty
                    ? term.englishDefinition
                    : term.simpleDefinition,
                style: getRegularStyle(
                  fontSize: FontSize.s12,
                  fontFamily: FontConstants.interFamily,
                  color: ColorManager.primaryText,
                ),
                maxLines: 3,
                overflow: TextOverflow.ellipsis,
              ),
            ],
          ),
        ),
      ),
    );
  }

  
}