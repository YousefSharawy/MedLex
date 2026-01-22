import 'package:flutter/material.dart';
import 'package:transly/presentation/base/components.dart';
import 'package:transly/presentation/home/widgets/daily_term_card.dart';
import 'package:transly/presentation/home/widgets/home_search_bar.dart';
import 'package:transly/presentation/home/widgets/recently_view_item.dart';
import 'package:transly/presentation/home/widgets/section_header.dart';
import 'package:transly/presentation/resources/color_manager.dart';
import 'package:transly/presentation/resources/font_manager.dart';
import 'package:transly/presentation/resources/style_manager.dart';
import 'package:transly/presentation/resources/values_manager.dart';
import 'package:transly/presentation/resources/assets_manager.dart';

class HomeView extends StatelessWidget {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    return PrimaryScaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          padding: EdgeInsets.symmetric(horizontal: AppWidth.s16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: AppHeight.s10),
              Text(
                'Medlex',
                style: getBoldStyle(
                  fontSize: FontSize.s24,
                  fontFamily: FontConstants.interFamily,
                  color: ColorManager.primaryText,
                ),
              ),
              SizedBox(height: AppHeight.s6),
              Text(
                'Medical knowledge made visual',
                style: getRegularStyle(
                  fontSize: FontSize.s15,
                  fontFamily: FontConstants.interFamily,
                  color: ColorManager.secondaryText,
                ),
              ),
              SizedBox(height: AppHeight.s8),
              const HomeSearchBar(),
              SizedBox(height: AppHeight.s24),
              SectionHeader(
                iconPath: IconAssets.calendarIcon,
                title: 'Daily Medical Term',
              ),
              SizedBox(height: AppHeight.s15),
               DailyTermCard(),
              SizedBox(height: AppHeight.s18),
              SectionHeader(
                iconPath: IconAssets.clockIcon,
                title: 'Recently Viewed',
              ),
              SizedBox(height: AppHeight.s8),

              const RecentlyViewedItem(
                title: 'Myocardium',
                category: 'Cardiology',
              ),
              SizedBox(height: AppHeight.s8),
              const RecentlyViewedItem(
                title: 'Myocardium',
                category: 'Cardiology',
              ),
            ],
          ),
        ),
      ),
    );
  }
}


// Recently Viewed Item Widget
