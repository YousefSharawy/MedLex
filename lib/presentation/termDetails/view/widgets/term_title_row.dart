import 'package:flutter/material.dart';
import 'package:transly/app/di.dart';
import 'package:transly/app/tts_service.dart';
import 'package:transly/domain/models.dart';
import 'package:transly/presentation/resources/assets_manager.dart';
import 'package:transly/presentation/resources/color_manager.dart';
import 'package:transly/presentation/resources/font_manager.dart';
import 'package:transly/presentation/resources/style_manager.dart';
import 'package:transly/presentation/resources/values_manager.dart';

/// The term name row (with optional TTS button + category badge)
/// followed by the pronunciation line.
class TermTitleRow extends StatelessWidget {
  const TermTitleRow({super.key, required this.term});

  final TermModel term;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Flexible(
              
              child: Text(
                maxLines: 4,
                overflow: TextOverflow.ellipsis,
                term.latinTerm,
                style: getSemiBoldStyle(
                  fontSize: FontSize.s16,
                  fontFamily: FontConstants.interFamily,
                  color: ColorManager.primaryText,
                ),
              ),
            ),
            SizedBox(width: AppWidth.s8),
            if (term.pronunciation.isNotEmpty)
              GestureDetector(
                onTap: () =>
                    getIt<TtsService>().speakPronunciation(term.latinTerm),
                child: Image.asset(IconAssets.volumeUp),
              ),
            SizedBox(width: AppWidth.s8),
            const Spacer(),
            _CategoryBadge(category: term.category),
          ],
        ),
        if (term.pronunciation.isNotEmpty) ...[
          SizedBox(height: AppHeight.s4),
          Text(
            term.pronunciation,
            style: getRegularStyle(
              fontSize: FontSize.s14,
              fontFamily: FontConstants.interFamily,
              color: ColorManager.secondaryText,
            ),
          ),
        ],
      ],
    );
  }
}

class _CategoryBadge extends StatelessWidget {
  const _CategoryBadge({super.key, required this.category});

  final String category;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: AppWidth.s10,
        vertical: AppHeight.s7,
      ),
      decoration: BoxDecoration(
        color: ColorManager.tealSoft,
        borderRadius: BorderRadius.circular(AppRadius.s32),
      ),
      child: Text(
        category,
        style: getRegularStyle(
          fontSize: FontSize.s12,
          fontFamily: FontConstants.interFamily,
          color: ColorManager.primaryText,
        ),
      ),
    );
  }
}