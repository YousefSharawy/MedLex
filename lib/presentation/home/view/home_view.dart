import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:medlex/presentation/home/view/widgets/home_animated_body.dart';
import 'package:medlex/presentation/home/view/widgets/home_animated_header.dart';
import 'package:medlex/presentation/home/view/widgets/home_content.dart';
import 'package:medlex/presentation/search/view/widgets/persistent_search_bar.dart';
import 'package:medlex/app/resources/values_manager.dart';
import 'package:medlex/presentation/search/view/widgets/resettable_tab.dart';
import 'package:medlex/presentation/search/viewModel/cubit/search_cubit.dart';
import 'package:medlex/presentation/base/primary_teal_scaffold.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> with ResettableTabState {
  bool _isSearching = false;
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
    setState(() {
      _isSearching = true;
      _searchEverOpened = true;
    });
    context.read<SearchCubit>().setSearching(true);
  }

  void _onSearchClose() {
    setState(() {
      _isSearching = false;
    });
    context.read<SearchCubit>().setSearching(false);
  }

  @override
  Widget buildContent(BuildContext context) {
    return PrimaryTealScaffold(
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: AppHeight.s4),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: AppWidth.s14),
              child: HomeAnimatedHeader(isSearching: _isSearching),
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: AppWidth.s16),
              child: PersistentSearchBar(
                isSearching: _isSearching,
                onSearchStart: _onSearchStart,
                onSearchClose: _onSearchClose,
              ),
            ),
            SizedBox(height: AppHeight.s18),
            Expanded(
              child: HomeAnimatedBody(
                isSearching: _isSearching,
                searchEverOpened: _searchEverOpened,
                homeContent: HomeContent(scrollController: _scrollController),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
