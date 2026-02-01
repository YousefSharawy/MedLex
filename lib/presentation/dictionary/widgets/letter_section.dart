import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:transly/cubit/cubit/app_cubit.dart';
import 'package:transly/domain/models.dart';
import 'package:transly/presentation/home/widgets/recently_view_item.dart';
import 'package:transly/presentation/resources/color_manager.dart';
import 'package:transly/presentation/resources/font_manager.dart';
import 'package:transly/presentation/resources/routes.dart';
import 'package:transly/presentation/resources/style_manager.dart';
import 'package:transly/presentation/resources/values_manager.dart';

class LetterSection extends StatelessWidget {
  final String letter;
  final List<TermModel> terms;

  const LetterSection({
    super.key,
    required this.letter,
    required this.terms,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildLetterHeader(),
        SizedBox(height: AppHeight.s8),
        ...terms.map((term) => _buildTermItem(context, term)),
        SizedBox(height: AppHeight.s16),
      ],
    );
  }

  Widget _buildLetterHeader() {
    return Padding(
      padding: EdgeInsets.only(top: AppHeight.s8),
      child: Text(
        letter == '#' ? 'Prefixes/Suffixes' : letter,
        style: getBoldStyle(
          fontSize: FontSize.s20,
          fontFamily: FontConstants.interFamily,
          color: ColorManager.primaryText,
        ),
      ),
    );
  }

  Widget _buildTermItem(BuildContext context, TermModel term) {
    return RecentlyViewedItem(
      term: term,
      onTap: () => _onTermTap(context, term),
    );
  }

  Future<void> _onTermTap(BuildContext context, TermModel term) async {
    context.read<AppCubit>().addToRecentlyViewed(term);
    await context.push(Routes.termDetails, extra: term);
  }
}