import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:transly/cubit/cubit/app_cubit.dart';
import 'package:transly/domain/models.dart';
import 'package:transly/presentation/home/view/widgets/recently_view_item.dart';
import 'package:transly/presentation/resources/routes.dart';

class SearchResults extends StatelessWidget {
  const SearchResults({super.key, required this.terms});

  final List<TermModel> terms;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      padding: EdgeInsets.zero,
      itemCount: terms.length,
      itemBuilder: (_, index) {
        final term = terms[index];
        return RecentlyViewedItem(
          term: term,
          onTap: () {
            context.read<AppCubit>().addToRecentlyViewed(term);
            context.push(Routes.termDetails, extra: term);
          },
        );
      },
    );
  }
}
