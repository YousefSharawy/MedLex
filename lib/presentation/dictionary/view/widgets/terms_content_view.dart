import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:transly/cubit/cubit/app_cubit.dart';
import 'package:transly/presentation/dictionary/view/widgets/terms_list_with_sidebar.dart';
import 'package:transly/app/ui_utiles.dart';

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

    return BlocBuilder<AppCubit, AppState>(
      buildWhen: (previous, current) {
        // Only rebuild for relevant state changes
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

  Widget _buildAllTermsView(BuildContext context, AppState state) {
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
        return UiUtils.emptyWidget(message: 'No terms found');
      }

      return TermsListWithSidebar(
        terms: state.terms,
        selectedCategory: selectedCategory,
        hasMore: state.hasMore,
        isLoadingMore: state.isLoadingMore,
        onLoadMore: () => context.read<AppCubit>().loadMoreTerms(),
      );
    }

    return UiUtils.loadingWidget();
  }

  Widget _buildCategoryView(BuildContext context, AppState state) {
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
        );
      }

      return TermsListWithSidebar(
        terms: state.terms,
        selectedCategory: selectedCategory,
        hasMore: false,
        isLoadingMore: false,
        onLoadMore: () {},
      );
    }

    return UiUtils.loadingWidget();
  }

  void _loadData(BuildContext context) {
    if (selectedCategory == 'All') {
      context.read<AppCubit>().getAllTerms(refresh: true);
    } else {
      context.read<AppCubit>().getTermsByCategory(selectedCategory);
    }
  }
}