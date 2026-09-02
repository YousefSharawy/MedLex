import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:medlex/cubit/terms_cubit.dart';
import 'package:medlex/presentation/dictionary/view/widgets/dictionary_animated_body.dart';
import 'package:medlex/presentation/dictionary/view/widgets/dictionary_content.dart';
import 'package:medlex/presentation/dictionary/view/widgets/dictionary_header.dart';
import 'package:medlex/app/resources/values_manager.dart';
import 'package:medlex/presentation/search/viewModel/cubit/navigation_cubit.dart';
import 'package:medlex/presentation/search/viewModel/cubit/search_cubit.dart';
import 'package:medlex/presentation/base/primary_teal_scaffold.dart';

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
    context.read<TermsCubit>().getAllTerms(refresh: true);
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
    context.read<SearchCubit>().clearSearchResults();
    context.read<TermsCubit>().getAllTerms(refresh: true);
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
                return prevCurrent != 1 && currCurrent == 1;
              },
              orElse: () => false,
            );
          },
          orElse: () => false,
        );
      },
      listener: (context, state) {
        _resetState();
      },
      child: PrimaryTealScaffold(
        body: SafeArea(
          bottom: false,
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
              Expanded(
                child: DictionaryAnimatedBody(
                  isSearching: _isSearching,
                  searchEverOpened: _searchEverOpened,
                  dictionaryContent: DictionaryContent(
                    selectedCategory: _selectedCategory,
                    onCategorySelected: _onCategorySelected,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
