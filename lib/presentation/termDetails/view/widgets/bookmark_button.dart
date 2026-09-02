import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:medlex/app/widgets/toast_manager.dart';
import 'package:medlex/cubit/favorites_cubit.dart';
import 'package:medlex/domain/models.dart';
import 'package:medlex/app/resources/assets_manager.dart';

class BookmarkButton extends StatelessWidget {
  const BookmarkButton({required this.term, super.key});
  final TermModel term;

  @override
  Widget build(BuildContext context) {
    return BlocSelector<FavoritesCubit, FavoritesState, bool>(
      selector: (state) {
        if (state is FavoritesUpdated) {
          return state.favoriteIds.contains(term.id);
        }
        return context.read<FavoritesCubit>().isFavorite(term.id);
      },
      builder: (context, isFavorite) {
        return GestureDetector(
          onTap: () {
            context.read<FavoritesCubit>().toggleFavorite(term);
            ToastManager.show(
              onAction: () {
                context.read<FavoritesCubit>().toggleFavorite(term);
              },
              context,
              icon: IconAssets.check,
              message:
                  !isFavorite ? "Added to bookmarks" : "Removed from bookmarks",
              actionLabel: "Undo",
            );
          },
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
