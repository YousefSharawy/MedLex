import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:transly/cubit/cubit/app_cubit.dart';
import 'package:transly/domain/models.dart';
import 'package:transly/presentation/base/primary_widgets.dart';
import 'package:transly/presentation/home/view/widgets/recently_view_item.dart';
import 'package:transly/presentation/home/view/widgets/section_header.dart';
import 'package:transly/presentation/resources/assets_manager.dart';
import 'package:transly/presentation/resources/color_manager.dart';
import 'package:transly/presentation/resources/font_manager.dart';
import 'package:transly/presentation/resources/routes.dart';
import 'package:transly/presentation/resources/style_manager.dart';
import 'package:transly/presentation/resources/values_manager.dart';
import 'package:transly/presentation/search/view/widgets/recently_searched_item.dart';
import 'package:transly/presentation/search/view/widgets/search_helper.dart';
import 'package:transly/presentation/search/view/widgets/trending_search_item.dart';

class DefaultView extends StatelessWidget {
  const DefaultView({
    super.key,
    required this.recentlyViewed,
    required this.recentlySearched,
    required this.popularTerms,
    required this.trendingTerms,
  });

  final List<TermModel> recentlyViewed;
  final List<String> recentlySearched;
  final List<TermModel> popularTerms;
  final List<TermModel> trendingTerms;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: EdgeInsets.zero,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          /// Recently searched
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const SectionHeader(
                iconPath: IconAssets.clockIcon,
                title: 'Recently Searched',
              ),
              if (recentlySearched.isNotEmpty)
                PrimaryElevatedButton(
                  borderColor: ColorManager.primary,
                  width: AppWidth.s10,
                  height: AppHeight.s10,
                  buttonRadius: AppRadius.s32,
                  title: "Clear",
                  onPress: () {
                    ClearRecentlySearchedDialog.show(context);
                  },
                  backGroundColor: ColorManager.white,
                  textStyle: getBoldStyle(
                    color: ColorManager.primary,
                    fontSize: FontSize.s22,
                  ),
                ),
            ],
          ),

          SizedBox(height: AppHeight.s12),

          if (recentlySearched.isNotEmpty)
            SizedBox(
              height: AppHeight.s32,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: recentlySearched.length,
                itemBuilder: (_, index) {
                  return RecentlySearchedItem(
                    label: recentlySearched[index],
                    onTap: () {
                      handleSearchItemClick(context, recentlySearched[index]);
                    },
                  );
                },
              ),
            )
          else
            EmptyHint(text: 'No recent searches yet'),

          SizedBox(height: AppHeight.s16),

          /// Trending
          const SectionHeader(
            iconPath: IconAssets.trending,
            title: 'Trending Searches',
          ),

          SizedBox(height: AppHeight.s12),

          if (trendingTerms.isNotEmpty)
            SizedBox(
              height: AppHeight.s32,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: trendingTerms.length,
                itemBuilder: (_, index) {
                  final term = trendingTerms[index];
                  final text =
                      term.latinTerm.isNotEmpty
                          ? term.latinTerm
                          : term.englishTerm;

                  return TrendingSearchItem(
                    label: text,
                    onTap: () {
                      handleSearchItemClick(context, text);
                    },
                  );
                },
              ),
            )
          else
            EmptyHint(text: 'Loading trending searches...'),

          SizedBox(height: AppHeight.s24),

          /// Popular / Recently viewed
          Text(
            "Popular Terms",
            style: getRegularStyle(
              fontSize: FontSize.s15,
              color: ColorManager.primaryText,
            ),
          ),

          SizedBox(height: AppHeight.s10),

          if (popularTerms.isNotEmpty)
            ...popularTerms.map(_buildTermItem(context))
          else if (recentlyViewed.isNotEmpty)
            ...recentlyViewed.map(_buildTermItem(context))
          else
            PlaceHolderItem(),

          SizedBox(height: AppHeight.s80),
        ],
      ),
    );
  }

  Widget Function(TermModel) _buildTermItem(BuildContext context) {
    return (term) => RecentlyViewedItem(
      term: term,
      onTap: () {
        context.read<AppCubit>().addToRecentlyViewed(term);
        context.push(Routes.termDetails, extra: term);
      },
    );
  }
}



