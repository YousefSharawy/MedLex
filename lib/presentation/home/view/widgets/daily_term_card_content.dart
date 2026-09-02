import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:medlex/app/di.dart';
import 'package:medlex/app/tts_service.dart';
import 'package:medlex/app/ui_utils.dart';
import 'package:medlex/cubit/recently_viewed_cubit.dart';
import 'package:medlex/domain/models.dart';
import 'package:medlex/app/resources/assets_manager.dart';
import 'package:medlex/app/resources/color_manager.dart';
import 'package:medlex/app/resources/font_manager.dart';
import 'package:medlex/app/resources/routes.dart';
import 'package:medlex/app/resources/style_manager.dart';
import 'package:medlex/app/resources/values_manager.dart';

class DailyTermCardContent extends StatelessWidget {
  final TermModel term;

  const DailyTermCardContent({super.key, required this.term});

  void _speakPronunciation(String t) {
    getIt<TtsService>().speakPronunciation(t);
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        context.read<RecentlyViewedCubit>().addToRecentlyViewed(term);
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
                      onTap: () => _speakPronunciation(term.latinTerm),
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
