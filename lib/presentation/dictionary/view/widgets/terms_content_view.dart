import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:medlex/cubit/terms_cubit.dart';
import 'package:medlex/presentation/dictionary/view/widgets/terms_list_with_sidebar.dart';
import 'package:medlex/app/ui_utils.dart';
import 'package:medlex/app/di.dart';
import 'package:medlex/presentation/dictionary/viewModel/cubit/az_list_cubit.dart';

class TermsContentView extends StatelessWidget {
  final String selectedCategory;

  const TermsContentView({
    super.key,
    required this.selectedCategory,
  });

  @override
  Widget build(BuildContext context) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _loadData(context);
    });

    return BlocBuilder<TermsCubit, TermsState>(
      buildWhen: (previous, current) {
        if (selectedCategory == 'All') {
          return current is AllTermsLoading ||
              current is AllTermsLoaded ||
              current is AllTermsError;
        } else {
          return current is TermsByCategoryLoading ||
              current is TermsByCategoryLoaded ||
              current is TermsByCategoryError;
        }
      },
      builder: (context, state) {
        if (selectedCategory == 'All') {
          return _buildAllTermsView(context, state);
        } else {
          return _buildCategoryView(context, state);
        }
      },
    );
  }

  Widget _buildAllTermsView(BuildContext context, TermsState state) {
    if (state is AllTermsLoading) {
      return UiUtils.loadingWidget();
    }

    if (state is AllTermsError) {
      return UiUtils.errorWidget(
        message: state.message,
        onRetry: () => _loadData(context),
      );
    }

    if (state is AllTermsLoaded) {
      if (state.terms.isEmpty) {
        return UiUtils.emptyWidget(message: 'No terms found',subMessage:  "Try searching with a different keyword or check spelling");
      }

      return BlocProvider(
        create: (_) => getIt<AzListCubit>(),
        child: TermsListWithSidebar(
          terms: state.terms,
          selectedCategory: selectedCategory,
          hasMore: state.hasMore,
          isLoadingMore: state.isLoadingMore,
          onLoadMore: () => context.read<TermsCubit>().loadMoreTerms(),
        ),
      );
    }

    return UiUtils.loadingWidget();
  }

  Widget _buildCategoryView(BuildContext context, TermsState state) {
    if (state is TermsByCategoryLoading) {
      return UiUtils.loadingWidget();
    }

    if (state is TermsByCategoryError) {
      return UiUtils.errorWidget(
        message: state.message,
        onRetry: () => _loadData(context),
      );
    }

    if (state is TermsByCategoryLoaded) {
      if (state.terms.isEmpty) {
        return UiUtils.emptyWidget(
          message: 'No terms found in $selectedCategory',
          subMessage:  "Try searching with a different keyword or check spelling",
        );
      }

      return BlocProvider(
        create: (_) => getIt<AzListCubit>(),
        child: TermsListWithSidebar(
          terms: state.terms,
          selectedCategory: selectedCategory,
          hasMore: false,
          isLoadingMore: false,
          onLoadMore: () {},
        ),
      );
    }

    return UiUtils.loadingWidget();
  }

  void _loadData(BuildContext context) {
    if (selectedCategory == 'All') {
      context.read<TermsCubit>().getAllTerms(refresh: true);
    } else {
      context.read<TermsCubit>().getTermsByCategory(selectedCategory);
    }
  }
}