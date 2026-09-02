import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:medlex/app/widgets/term_item.dart';
import 'package:medlex/cubit/recently_viewed_cubit.dart';
import 'package:medlex/domain/models.dart';
import 'package:medlex/presentation/home/view/widgets/daily_term_card.dart';
import 'package:medlex/presentation/home/view/widgets/section_header.dart';
import 'package:medlex/app/resources/assets_manager.dart';
import 'package:medlex/app/resources/values_manager.dart';

class HomeContent extends StatelessWidget {
  final ScrollController scrollController;

  const HomeContent({super.key, required this.scrollController});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<RecentlyViewedCubit, RecentlyViewedState>(
      buildWhen: (previous, current) => current is RecentlyViewedUpdated,
      builder: (context, state) {
        final recentlyViewed =
            state is RecentlyViewedUpdated
                ? state.recentlyViewed
                : <TermModel>[];

        return Align(
          alignment: Alignment.topCenter,
          child: SingleChildScrollView(
            controller: scrollController,
            padding: EdgeInsets.symmetric(horizontal: AppWidth.s16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SectionHeader(
                  iconPath: IconAssets.calendarIcon,
                  title: 'Daily Medical Term',
                ),
                SizedBox(height: AppHeight.s15),
                DailyTermCard(),
                SizedBox(height: AppHeight.s18),
                if (recentlyViewed.isNotEmpty) ...[
                  SectionHeader(
                    iconPath: IconAssets.clockIcon,
                    title: 'Recently Viewed',
                  ),
                  SizedBox(height: AppHeight.s8),
                  ...recentlyViewed.map((term) => TermItem(term: term)),
                ],
                SizedBox(height: AppHeight.s10),
              ],
            ),
          ),
        );
      },
    );
  }
}
