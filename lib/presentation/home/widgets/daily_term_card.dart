import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:transly/app/di.dart';
import 'package:transly/app/tts_service.dart';
import 'package:transly/app/ui_utiles.dart';
import 'package:transly/cubit/cubit/app_cubit.dart';
import 'package:transly/domain/models.dart';
import 'package:transly/presentation/resources/assets_manager.dart';
import 'package:transly/presentation/resources/color_manager.dart';
import 'package:transly/presentation/resources/font_manager.dart';
import 'package:transly/presentation/resources/style_manager.dart';
import 'package:transly/presentation/resources/values_manager.dart';

class DailyTermCard extends StatelessWidget {
  const DailyTermCard({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AppCubit, AppState>(
      builder: (context, state) {
        return state.maybeWhen(
          homeLoaded: (dailyTerm, isSearching, isLoading, errorMessage) {
            if (isLoading) {
              return UiUtils.loadingCard();
            }
            if (errorMessage != null) {
              return UiUtils.errorCard(
                message: errorMessage,
                onRetry: () => context.read<AppCubit>().getDailyTerm(),
              );
            }
            if (dailyTerm != null) {
              return _buildTermCard(context, dailyTerm);
            }
            return UiUtils.loadingCard();
          },
          orElse: () => UiUtils.loadingCard(),
        );
      },
    );
  }

  void _speakPronunciation(String pronunciation, String term) {
    getIt<TtsService>().speakPronunciation(pronunciation, term);
  }

  Widget _buildTermCard(BuildContext context, TermModel term) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.only(top: AppHeight.s9, bottom: AppHeight.s15),
      decoration: UiUtils.cardDecoration(),
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: AppWidth.s16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: UiUtils.cachedNetworkImage(
                imageUrl: term.imageUrl,
                height: AppHeight.s144,
                borderRadius: BorderRadius.circular(AppRadius.s12),
              ),
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
                    onTap:
                        () => _speakPronunciation(
                          term.pronunciation,
                          term.latinTerm,
                        ),
                    child: Image.asset(IconAssets.volumeUp),
                  ),
                ],
              ),
            SizedBox(height: AppHeight.s8),
            Text(
              term.simpleDefinition,
              style: getRegularStyle(
                fontSize: FontSize.s12,
                fontFamily: FontConstants.interFamily,
                color: ColorManager.primaryText,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
