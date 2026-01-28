import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:transly/app/di.dart';
import 'package:transly/cubit/cubit/app_cubit.dart';
import 'package:transly/presentation/base/components.dart';
import 'package:transly/presentation/home/widgets/daily_term_card.dart';
import 'package:transly/presentation/home/widgets/recently_view_item.dart';
import 'package:transly/presentation/home/widgets/section_header.dart';
import 'package:transly/presentation/search/widgets/presistent_search_bar.dart';
import 'package:transly/presentation/resources/color_manager.dart';
import 'package:transly/presentation/resources/font_manager.dart';
import 'package:transly/presentation/resources/style_manager.dart';
import 'package:transly/presentation/resources/values_manager.dart';
import 'package:transly/presentation/resources/assets_manager.dart';
import 'package:transly/presentation/search/search_view.dart';

class HomeView extends StatelessWidget {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => getIt<AppCubit>()..getDailyTerm(),
      child: const _HomeContent(),
    );
  }
}

class _HomeContent extends StatelessWidget {
  const _HomeContent();

  @override
  Widget build(BuildContext context) {
    return PrimaryScaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          padding: EdgeInsets.symmetric(horizontal: AppWidth.s14),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: AppHeight.s4),
              BlocBuilder<AppCubit, AppState>(
                buildWhen: (previous, current) => current is HomeLoaded,
                builder: (context, state) {
                  final isSearching =
                      state is HomeLoaded ? state.isSearching : false;

                  return AnimatedCrossFade(
                    duration: const Duration(milliseconds: 300),
                    crossFadeState:
                        isSearching
                            ? CrossFadeState.showSecond
                            : CrossFadeState.showFirst,
                    firstChild: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Medlex',
                          style: getBoldStyle(
                            fontSize: FontSize.s24,
                            fontFamily: FontConstants.interFamily,
                            color: ColorManager.primaryText,
                          ),
                        ),
                        SizedBox(height: AppHeight.s6),
                        Padding(
                          padding: EdgeInsets.symmetric(
                            horizontal: AppWidth.s2,
                          ),
                          child: Text(
                            'Medical knowledge made visual',
                            style: getRegularStyle(
                              fontSize: FontSize.s15,
                              fontFamily: FontConstants.interFamily,
                              color: ColorManager.secondaryText,
                            ),
                          ),
                        ),
                        SizedBox(height: AppHeight.s8),
                      ],
                    ),
                    secondChild: Column(
                      children: [
                        Text(
                          'Search',
                          style: getBoldStyle(
                            fontSize: FontSize.s24,
                            fontFamily: FontConstants.interFamily,
                            color: ColorManager.primaryText,
                          ),
                        ),
                        SizedBox(height: AppHeight.s12),
                      ],
                    ),
                  );
                },
              ),
              BlocBuilder<AppCubit, AppState>(
                buildWhen: (previous, current) => current is HomeLoaded,
                builder: (context, state) {
                  final isSearching =
                      state is HomeLoaded ? state.isSearching : false;

                  return PersistentSearchBar(
                    isSearching: isSearching,
                    onSearchStart:
                        () => context.read<AppCubit>().setSearching(true),
                    onSearchClose:
                        () => context.read<AppCubit>().setSearching(false),
                  );
                },
              ),
              SizedBox(height: AppHeight.s24),
              BlocBuilder<AppCubit, AppState>(
                buildWhen: (previous, current) => current is HomeLoaded,
                builder: (context, state) {
                  final isSearching =
                      state is HomeLoaded ? state.isSearching : false;

                  return AnimatedCrossFade(
                    duration: const Duration(milliseconds: 300),
                    crossFadeState:
                        isSearching
                            ? CrossFadeState.showSecond
                            : CrossFadeState.showFirst,
                    firstChild: Padding(
                      padding: EdgeInsets.symmetric(horizontal: AppWidth.s2),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SectionHeader(
                            iconPath: IconAssets.calendarIcon,
                            title: 'Daily Medical Term',
                          ),
                          SizedBox(height: AppHeight.s15),
                          const DailyTermCard(),
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
                          const RecentlyViewedItem(
                            title: 'Myocardium',
                            category: 'Cardiology',
                          ),
                          SizedBox(height: AppHeight.s80),
                        ],
                      ),
                    ),
                    secondChild: const SearchView(),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
