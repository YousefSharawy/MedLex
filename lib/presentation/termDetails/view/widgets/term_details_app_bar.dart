import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:transly/cubit/cubit/app_cubit.dart';
import 'package:transly/domain/models.dart';
import 'package:transly/presentation/resources/assets_manager.dart';
import 'package:transly/presentation/resources/values_manager.dart';

class TermDetailsAppBar extends StatelessWidget {
  TermDetailsAppBar({required this.term, super.key});
  TermModel term;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: AppWidth.s16),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          GestureDetector(
            onTap: () => Navigator.pop(context),
            child: Icon(Icons.chevron_left, color: Colors.black87, size: 24.sp),
          ),
          BookmarButton(term: term),
        ],
      ),
    );
    ;
  }
}

class BookmarButton extends StatelessWidget {
  BookmarButton({required this.term, super.key});
  TermModel term;
  @override
  Widget build(BuildContext context) {
    return BlocSelector<AppCubit, AppState, bool>(
      selector: (state) {
        if (state is HomeLoaded) {
          return state.favoriteIds.contains(term.id);
        }
        return context.read<AppCubit>().isFavorite(term.id);
      },
      builder: (context, isFavorite) {
        return GestureDetector(
          onTap: () => context.read<AppCubit>().toggleFavorite(term),
          child: Padding(
            padding: EdgeInsets.all(8.sp),
            child: Image.asset(
              isFavorite ? IconAssets.bookmarkActive : IconAssets.bookmark,
            ),
          ),
        );
      },
    );
  }
}
