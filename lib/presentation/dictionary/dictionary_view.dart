import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:transly/cubit/cubit/app_cubit.dart';
import 'package:transly/presentation/base/components.dart';
import 'package:transly/presentation/dictionary/widgets/category_chip_list.dart';
import 'package:transly/presentation/dictionary/widgets/dictionary_header.dart';
import 'package:transly/presentation/dictionary/widgets/terms_content_view.dart';
import 'package:transly/presentation/resources/values_manager.dart';
import 'package:transly/presentation/search/search_view.dart';
import 'package:transly/presentation/search/view_model/cubit/navigation_cubit.dart';

class DictionaryView extends StatefulWidget {
  const DictionaryView({super.key});

  @override
  State<DictionaryView> createState() => _DictionaryViewState();
}

class _DictionaryViewState extends State<DictionaryView>
    with AutomaticKeepAliveClientMixin {
  bool _isSearching = false;
  bool _searchEverOpened = false;
  String _selectedCategory = 'All';

  @override
  bool get wantKeepAlive => true;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _loadInitialData();
    });
  }

  void _loadInitialData() {
    context.read<AppCubit>().getAllTerms(refresh: true);
  }

  void _onSearchStart() {
    scheduleMicrotask(() {
      if (!mounted) return;
      setState(() {
        _isSearching = true;
        _searchEverOpened = true;
      });
      context.read<AppCubit>().setSearching(true);
    });
  }

  void _onSearchClose() {
    scheduleMicrotask(() {
      if (!mounted) return;
      setState(() {
        _isSearching = false;
      });
      context.read<AppCubit>().setSearching(false);
    });
  }

  void _onCategorySelected(String category) {
    if (_selectedCategory == category) return;
    setState(() => _selectedCategory = category);
  }

  void _resetState() {
    if (!mounted) return;
    setState(() {
      _isSearching = false;
      _selectedCategory = 'All';
    });
    context.read<AppCubit>().clearSearchResults();
    context.read<AppCubit>().getAllTerms(refresh: true);
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);

    return BlocListener<NavigationCubit, NavigationState>(
      listenWhen: (previous, current) {
        return previous.maybeWhen(
          loaded: (prevCurrent, prevPrevious) {
            return current.maybeWhen(
              loaded: (currCurrent, currPrevious) {
                // User navigated away from dictionary (index 1) and came back
                return prevCurrent != 1 && currCurrent == 1;
              },
              orElse: () => false,
            );
          },
          orElse: () => false,
        );
      },
      listener: (context, state) {
        // Refresh data when user returns to dictionary tab
        _resetState();
      },
      child: PrimaryScaffold(
        body: SafeArea(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: AppHeight.s4),
              DictionaryHeader(
                isSearching: _isSearching,
                onSearchStart: _onSearchStart,
                onSearchClose: _onSearchClose,
              ),
              SizedBox(height: AppHeight.s12),
              Expanded(child: _buildAnimatedBody()),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildAnimatedBody() {
    const duration = Duration(milliseconds: 300);
    return Stack(
      children: [
        // Dictionary content (with categories and terms list)
        AnimatedOpacity(
          duration: duration,
          opacity: _isSearching ? 0.0 : 1.0,
          child: IgnorePointer(
            ignoring: _isSearching,
            child: _buildDictionaryContent(),
          ),
        ),
        // Search overlay
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

  Widget _buildDictionaryContent() {
    return Column(
      children: [
        // Category filter chips
        CategoryChipsList(
          selectedCategory: _selectedCategory,
          onCategorySelected: _onCategorySelected,
        ),
        SizedBox(height: AppHeight.s12),
        Expanded(
          child: TermsContentView(
            selectedCategory: _selectedCategory,
          ),
        ),
        SizedBox(height: AppHeight.s80),
      ],
    );
  }
}