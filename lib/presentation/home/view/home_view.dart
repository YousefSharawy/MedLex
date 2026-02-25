import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:transly/cubit/terms_cubit.dart';
import 'package:transly/domain/models.dart';
import 'package:transly/presentation/auth/view/login_bottom_sheet.dart';
import 'package:transly/presentation/auth/viewModel/cubit/auth_cubit.dart';
import 'package:transly/presentation/base/components.dart';
import 'package:transly/presentation/home/view/widgets/daily_term_card.dart';
import 'package:transly/presentation/home/view/widgets/recently_view_item.dart';
import 'package:transly/presentation/home/view/widgets/section_header.dart';
import 'package:transly/presentation/search/view/widgets/presistent_search_bar.dart';
import 'package:transly/presentation/resources/color_manager.dart';
import 'package:transly/presentation/resources/font_manager.dart';
import 'package:transly/presentation/resources/style_manager.dart';
import 'package:transly/presentation/resources/values_manager.dart';
import 'package:transly/presentation/resources/assets_manager.dart';
import 'package:transly/presentation/resources/routes.dart';
import 'package:transly/presentation/search/view/search_view.dart';
import 'package:transly/presentation/search/view/widgets/resettable_tab.dart';
import 'package:transly/presentation/search/viewModel/cubit/search_cubit.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> with ResettableTabState {
  bool _isSearching = false;
  // Tracks whether SearchView has EVER been built this session.
  // Once true, we keep it in the tree (hidden) so it never cold-starts again.
  bool _searchEverOpened = false;
  final ScrollController _scrollController = ScrollController();

  @override
  int get tabIndex => 0;

  @override
  void resetState() {
    if (mounted) {
      setState(() {
        _isSearching = false;
      });
      context.read<SearchCubit>().resetSearchState();
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
    scheduleMicrotask(() {
      if (!mounted) return;
      setState(() {
        _isSearching = true;
        _searchEverOpened = true;
      });
      context.read<SearchCubit>().setSearching(true);
    });
  }

  void _onSearchClose() {
    scheduleMicrotask(() {
      if (!mounted) return;
      setState(() {
        _isSearching = false;
      });
      context.read<SearchCubit>().setSearching(false);
    });
  }

  @override
  Widget buildContent(BuildContext context) {
    return PrimaryScaffold(
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: AppHeight.s4),
            // ---------- Header ----------
            Padding(
              padding: EdgeInsets.symmetric(horizontal: AppWidth.s14),
              child: _buildAnimatedHeader(),
            ),
            // ---------- Search Bar ----------
            Padding(
              padding: EdgeInsets.symmetric(horizontal: AppWidth.s16),
              child: PersistentSearchBar(
                isSearching: _isSearching,
                onSearchStart: _onSearchStart,
                onSearchClose: _onSearchClose,
              ),
            ),
            SizedBox(height: AppHeight.s18),
            // ---------- Body ----------
            Expanded(child: _buildAnimatedBody()),
          ],
        ),
      ),
    );
  }

  Widget _buildAnimatedHeader() {
    const duration = Duration(milliseconds: 300);

    final homeHeader = AnimatedOpacity(
      duration: duration,
      opacity: _isSearching ? 0.0 : 1.0,
      child: Column(
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
                onPressed: () async {
                  final authCubit = context.read<AuthCubit>();
                  if (authCubit.isAnonymous) {
                    final result = await LoginBottomSheet.show(context);
                    if (result != true) return;
                  }
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
    );
    final searchHeader = AnimatedOpacity(
      duration: duration,
      opacity: _isSearching ? 1.0 : 0.0,
      child: Column(
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

    return AnimatedSize(
      duration: duration,
      curve: Curves.easeOut,
      child: _isSearching ? searchHeader : homeHeader,
    );
  }

  Widget _buildAnimatedBody() {
    const duration = Duration(milliseconds: 300);

    return Stack(
      children: [
        // --- Home content (always alive) ---
        AnimatedOpacity(
          duration: duration,
          opacity: _isSearching ? 0.0 : 1.0,
          child: IgnorePointer(
            ignoring: _isSearching,
            child: _buildHomeContent(),
          ),
        ),
        if (_searchEverOpened)
          AnimatedOpacity(
            duration: duration,
            opacity: _isSearching ? 1.0 : 0.0,
            child: IgnorePointer(
              ignoring: !_isSearching,
              child: RepaintBoundary(
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: AppWidth.s16),
                  child: const SearchView(),
                ),
              ),
            ),
          ),
      ],
    );
  }

  Widget _buildHomeContent() {
    return BlocBuilder<TermsCubit, TermsState>(
      buildWhen: (previous, current) => current is RecentlyViewedUpdated,
      builder: (context, state) {
        final recentlyViewed =
            state is RecentlyViewedUpdated
                ? state.recentlyViewed
                : <TermModel>[];

        return Align(
          alignment: Alignment.topCenter,
          child: SingleChildScrollView(
            controller: _scrollController,
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
                        context.read<TermsCubit>().addToRecentlyViewed(term);
                        context.push(Routes.termDetails, extra: term);
                      },
                    ),
                  ),
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
