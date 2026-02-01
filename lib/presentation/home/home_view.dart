import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:transly/cubit/cubit/app_cubit.dart';
import 'package:transly/domain/models.dart';
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
import 'package:transly/presentation/resources/routes.dart';
import 'package:transly/presentation/search/search_view.dart';
import 'package:transly/presentation/search/widgets/resettable_tab.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> with ResettableTabState {
  bool _isSearching = false;
  final ScrollController _scrollController = ScrollController();

  @override
  int get tabIndex => 0;

  @override
  void resetState() {
    if (mounted) {
      setState(() {
        _isSearching = false;
      });
      context.read<AppCubit>().resetHomeState();
      if (_scrollController.hasClients) {
        _scrollController.animateTo(
          0,
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeOut,
        );
      }
    }
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  void _onSearchStart() {
    setState(() => _isSearching = true);
    context.read<AppCubit>().setSearching(true);
  }

  void _onSearchClose() {
    setState(() => _isSearching = false);
    context.read<AppCubit>().setSearching(false);
  }

  @override
  Widget buildContent(BuildContext context) {
    return PrimaryScaffold(
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: AppHeight.s4),
            // Header
            Padding(
              padding: EdgeInsets.symmetric(horizontal: AppWidth.s14),
              child: AnimatedCrossFade(
                duration: const Duration(milliseconds: 300),
                crossFadeState:
                    _isSearching
                        ? CrossFadeState.showSecond
                        : CrossFadeState.showFirst,
                firstChild: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Expanded(
                          child: Text(
                            'Medlex',
                            style: getBoldStyle(
                              fontSize: FontSize.s24,
                              fontFamily: FontConstants.interFamily,
                              color: ColorManager.primaryText,
                            ),
                          ),
                        ),
                        IconButton(
                          onPressed: () {
                            context.push(Routes.profile);
                            context.pushReplacement(Routes.savedItems);
                          },
                          icon: Image.asset(IconAssets.bookmarkActive),
                        ),
                      ],
                    ),
                    SizedBox(height: AppHeight.s6),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: AppWidth.s2),
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
              ),
            ),
            // Search Bar
            Padding(
              padding: EdgeInsets.symmetric(horizontal: AppWidth.s14),
              child: PersistentSearchBar(
                isSearching: _isSearching,
                onSearchStart: _onSearchStart,
                onSearchClose: _onSearchClose,
              ),
            ),
            SizedBox(height: AppHeight.s18),
            Expanded(
              child: AnimatedSwitcher(
                duration: const Duration(milliseconds: 300),
                child:
                    _isSearching
                        ? Padding(
                          padding: EdgeInsets.symmetric(
                            horizontal: AppWidth.s16,
                          ),
                          child: const SearchView(key: ValueKey('search')),
                        )
                        : _buildHomeContent(),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildHomeContent() {
    return BlocBuilder<AppCubit, AppState>(
      buildWhen: (previous, current) => current is HomeLoaded,
      builder: (context, state) {
        final recentlyViewed =
            state is HomeLoaded ? state.recentlyViewed : <TermModel>[];

        return Align(
          alignment: Alignment.topCenter,
          child: SingleChildScrollView(
            controller: _scrollController,
            key: const ValueKey('home'),
            padding: EdgeInsets.symmetric(horizontal: AppWidth.s16),
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
                if (recentlyViewed.isNotEmpty) ...[
                  SectionHeader(
                    iconPath: IconAssets.clockIcon,
                    title: 'Recently Viewed',
                  ),
                  SizedBox(height: AppHeight.s8),
                  ...recentlyViewed.map(
                    (term) => RecentlyViewedItem(
                      term: term,
                      onTap: () {
                        context.read<AppCubit>().addToRecentlyViewed(term);
                        context.push(Routes.termDetails, extra: term);
                      },
                    ),
                  ),
                ],
                SizedBox(height: AppHeight.s80),
              ],
            ),
          ),
        );
      },
    );
  }
}
