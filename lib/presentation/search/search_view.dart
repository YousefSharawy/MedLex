import 'package:flutter/material.dart';
import 'package:transly/presentation/home/widgets/recently_view_item.dart';
import 'package:transly/presentation/home/widgets/section_header.dart';
import 'package:transly/presentation/resources/assets_manager.dart';
import 'package:transly/presentation/resources/color_manager.dart';
import 'package:transly/presentation/resources/font_manager.dart';
import 'package:transly/presentation/resources/style_manager.dart';
import 'package:transly/presentation/resources/values_manager.dart';
import 'package:transly/presentation/search/widgets/recently_searched_item.dart';
import 'package:transly/presentation/search/widgets/trending_search_item.dart';

class SearchView extends StatelessWidget {
  const SearchView({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: EdgeInsets.symmetric(horizontal: AppWidth.s2),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SectionHeader(
            iconPath: IconAssets.clockIcon,
            title: 'Recently Searched',
          ),
          SizedBox(height: AppHeight.s12),
          SizedBox(
            height: AppHeight.s32,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: 3,
              itemBuilder: (_, int index) {
                return RecentlySearchedItem(label: 'Anatomy');
              },
            ),
          ),

          SizedBox(height: AppHeight.s16),
          SectionHeader(
            iconPath: IconAssets.trending,
            title: 'Trending Searches',
          ),
          SizedBox(height: AppHeight.s12),
          SizedBox(
            height: AppHeight.s32,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: 3,
              itemBuilder: (_, int index) {
                return TrendingSearchItem(label: 'Anatomy');
              },
            ),
          ),

          SizedBox(height: AppHeight.s30),
          Text(
            "Popular Terms",
            style: getRegularStyle(
              fontFamily: FontConstants.interFamily,
              fontSize: FontSize.s15,
              color: ColorManager.primaryText,
            ),
          ),
          SizedBox(height: AppHeight.s10),

          RecentlyViewedItem(title: "Myocardium", category: "Cardiology"),
          RecentlyViewedItem(title: "Myocardium", category: "Cardiology"),

          RecentlyViewedItem(title: "Myocardium", category: "Cardiology"),
          RecentlyViewedItem(title: "Myocardium", category: "Cardiology"),
          SizedBox(height: AppHeight.s100),
        ],
      ),
    );
  }
}
