import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:medlex/app/ui_utils.dart';
import 'package:medlex/cubit/recently_viewed_cubit.dart';
import 'package:medlex/presentation/home/viewModel/cubit/home_cubit.dart';
import 'package:medlex/presentation/search/view/widgets/default_view.dart';
import 'package:medlex/presentation/search/view/widgets/search_results.dart';
import 'package:medlex/presentation/search/viewModel/cubit/search_cubit.dart';

class SearchView extends StatelessWidget {
  final GlobalKey<dynamic>? searchBarKey;

  const SearchView({super.key, this.searchBarKey});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SearchCubit, SearchState>(
      buildWhen: (previous, current) {
        if (current is! SearchLoaded) return false;
        if (previous is! SearchLoaded) return true;

        return current.recentlySearched != previous.recentlySearched ||
            current.searchResults != previous.searchResults ||
            current.isSearchLoading != previous.isSearchLoading ||
            current.searchError != previous.searchError;
      },
      builder: (context, state) {
        if (state is! SearchLoaded) {
          return const SizedBox.shrink();
        }

        if (state.isSearchLoading) {
          return Center(child: UiUtils.loadingWidget());
        }

        if (state.searchError != null) {
          return UiUtils.errorWidget(
            message: state.searchError!,
            onRetry: () {},
          );
        }

        if (state.searchResults != null) {
          if (state.searchResults!.isEmpty) {
            return UiUtils.emptyWidget(message: 'No results found',subMessage:  "Try searching with a different keyword or check spelling");
          }
          return SearchResults(terms: state.searchResults!);
        }

        return DefaultView(
          recentlyViewed: context.read<RecentlyViewedCubit>().recentlyViewed,
          recentlySearched: state.recentlySearched,
          popularTerms: context.read<HomeCubit>().popularTerms,
          trendingTerms: context.read<HomeCubit>().trendingTerms,
        );
      },
    );
  }
}