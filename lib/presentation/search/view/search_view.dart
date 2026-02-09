import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:transly/app/ui_utiles.dart';
import 'package:transly/cubit/cubit/app_cubit.dart';
import 'package:transly/presentation/search/view/widgets/default_view.dart';
import 'package:transly/presentation/search/view/widgets/search_results.dart';

class SearchView extends StatelessWidget {
  final GlobalKey<dynamic>? searchBarKey;

  const SearchView({super.key, this.searchBarKey});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AppCubit, AppState>(
      buildWhen: (previous, current) {
        if (current is! HomeLoaded) return false;
        if (previous is! HomeLoaded) return true;

        return current.recentlySearched != previous.recentlySearched ||
            current.searchResults != previous.searchResults ||
            current.isSearchLoading != previous.isSearchLoading ||
            current.searchError != previous.searchError ||
            current.trendingTerms != previous.trendingTerms ||
            current.popularTerms != previous.popularTerms ||
            current.recentlyViewed != previous.recentlyViewed;
      },
      builder: (context, state) {
        if (state is! HomeLoaded) {
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
            return UiUtils.emptyWidget(message: 'No results found');
          }
          return SearchResults(terms: state.searchResults!);
        }

        return DefaultView(
          recentlyViewed: state.recentlyViewed,
          recentlySearched: state.recentlySearched,
          popularTerms: state.popularTerms,
          trendingTerms: state.trendingTerms,
        );
      },
    );
  }
}
