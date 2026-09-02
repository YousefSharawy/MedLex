import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:medlex/cubit/favorites_cubit.dart';
import 'package:medlex/presentation/profile/view/screens/savedTerms/widgets/saved_terms_empty_state.dart';
import 'package:medlex/presentation/profile/view/screens/savedTerms/widgets/saved_terms_list.dart';
import 'package:medlex/app/resources/color_manager.dart';
import 'package:medlex/app/resources/font_manager.dart';
import 'package:medlex/app/resources/style_manager.dart';
import 'package:medlex/app/resources/values_manager.dart';
import 'package:medlex/presentation/base/primary_teal_scaffold.dart';

class SavedTermsView extends StatefulWidget {
  const SavedTermsView({super.key});

  @override
  State<SavedTermsView> createState() => _SavedTermsViewState();
}

class _SavedTermsViewState extends State<SavedTermsView> {
  @override
  void initState() {
    super.initState();
    final cubit = context.read<FavoritesCubit>();
    cubit.loadFavorites();
  }
  @override
  Widget build(BuildContext context) {
    return PrimaryTealScaffold(
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: AppHeight.s21),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: AppWidth.s16),
              child: Row(
                children: [
                  GestureDetector(
                    onTap: () => context.pop(),
                    child: Icon(
                      Icons.arrow_back_ios_new,
                      color: ColorManager.primaryText,
                      size: 24.sp,
                    ),
                  ),
                  SizedBox(width: AppWidth.s66),
                  Text(
                    'Saved Terms',
                    style: getBoldStyle(
                      fontSize: FontSize.s24,
                      fontFamily: FontConstants.interFamily,
                      color: ColorManager.primaryText,
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: AppHeight.s17),
            Expanded(child: _buildContent()),
          ],
        ),
      ),
    );
  }

  Widget _buildContent() {
    return BlocBuilder<FavoritesCubit, FavoritesState>(
      buildWhen:
          (_, state) => state is FavoritesLoading || state is FavoritesLoaded,
      builder: (context, state) {
        if (state is FavoritesLoading) {
          return const Center(child: CircularProgressIndicator());
        }

        if (state is! FavoritesLoaded) {
          return const Center(child: CircularProgressIndicator());
        }

        if (state.favorites.isEmpty) {
          return const SavedTermsEmptyState();
        }

        return TermsList(
          terms: state.favorites,
        );
      },
    );
  }
}
