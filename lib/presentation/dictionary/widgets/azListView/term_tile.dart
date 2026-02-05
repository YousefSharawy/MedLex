import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:transly/cubit/cubit/app_cubit.dart';
import 'package:transly/domain/models.dart';
import 'package:transly/presentation/home/widgets/recently_view_item.dart';
import 'package:transly/presentation/resources/routes.dart';

class TermTile extends StatelessWidget {
  final TermModel term;

  const TermTile({
    super.key,
    required this.term,
  });

  @override
  Widget build(BuildContext context) {
    return RecentlyViewedItem(
      term: term,
      onTap: () => _onTap(context),
    );
  }

  Future<void> _onTap(BuildContext context) async {
    context.read<AppCubit>().addToRecentlyViewed(term);
    await context.push(Routes.termDetails, extra: term);
  }
}