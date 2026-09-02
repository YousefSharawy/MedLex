import 'package:flutter/material.dart';
import 'package:medlex/app/di.dart';
import 'package:medlex/app/tts_service.dart';
import 'package:medlex/domain/models.dart';
import 'package:medlex/app/resources/assets_manager.dart';
import 'package:medlex/app/resources/color_manager.dart';
import 'package:medlex/app/resources/font_manager.dart';
import 'package:medlex/app/resources/style_manager.dart';
import 'package:medlex/app/resources/values_manager.dart';

/// The term name row (with optional TTS button + category badge)
/// followed by the pronunciation line.
import 'category_badge.dart';

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
            CategoryBadge(category: term.category),
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
