import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:transly/app/local_storage.dart';
import 'package:transly/cubit/terms_cubit.dart';
import 'package:transly/domain/models.dart';
import 'package:transly/presentation/base/components.dart';
import 'package:transly/presentation/base/primary_widgets.dart';
import 'package:transly/presentation/profile/view/widgets/saved_term_item.dart';
import 'package:transly/presentation/resources/assets_manager.dart';
import 'package:transly/presentation/resources/color_manager.dart';
import 'package:transly/presentation/resources/font_manager.dart';
import 'package:transly/presentation/resources/routes.dart';
import 'package:transly/presentation/resources/style_manager.dart';
import 'package:transly/presentation/resources/values_manager.dart';

class SavedTermsView extends StatefulWidget {
  const SavedTermsView({super.key});

  @override
  State<SavedTermsView> createState() => _SavedTermsViewState();
}

class _SavedTermsViewState extends State<SavedTermsView> {
  List<TermModel> _favorites = [];
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _loadFavorites();
  }

  void _loadFavorites() {
    setState(() {
      _favorites = LocalAppStorage.getFavorites();
      _isLoading = false;
    });
  }

  void _toggleFavorite(TermModel term) {
    setState(() {
      LocalAppStorage.removeFavorite(term.id);
      _favorites = LocalAppStorage.getFavorites();
    });
    context.read<TermsCubit>().removeFromFavorites(term.id);
  }

  Future<void> _navigateToDetails(TermModel term) async {
    context.read<TermsCubit>().addToRecentlyViewed(term);
    await context.push(Routes.termDetails, extra: term);
    _loadFavorites();
  }

  @override
  Widget build(BuildContext context) {
    return PrimaryScaffold(
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
    if (_isLoading) {
      return const Center(child: CircularProgressIndicator());
    }

    if (_favorites.isEmpty) {
      return _buildEmptyState();
    }

    return ListView.separated(
      padding: EdgeInsets.symmetric(horizontal: AppWidth.s16),
      itemCount: _favorites.length,
      separatorBuilder: (_, __) => SizedBox(height: AppHeight.s10),
      itemBuilder: (context, index) {
        final term = _favorites[index];
        return SavedTermItem(
          term: term,
          onTap: () {
            _navigateToDetails(term);
          },
          onBookmarkTap: () => _toggleFavorite(term),
        );
      },
    );
  }

  Widget _buildEmptyState() {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: AppWidth.s32),
      child: Column(
        children: [
          SizedBox(height: AppHeight.s158),
          Container(
            width: AppWidth.s68,
            height: AppHeight.s68,
            decoration: BoxDecoration(
              color: ColorManager.tealSoft,
              shape: BoxShape.circle,
            ),
            child: Center(
              child: Image.asset(
                IconAssets.bookmark,
                width: 24.sp,
                height: 24.sp,
                color: ColorManager.primary,
              ),
            ),
          ),
          SizedBox(height: AppHeight.s43),
          // Title
          Text(
            'No saved terms yet',
            style: getBoldStyle(
              fontSize: FontSize.s24,
              fontFamily: FontConstants.interFamily,
              color: ColorManager.primaryText,
            ),
          ),
          SizedBox(height: AppHeight.s10),
          // Subtitle
          Text(
            'Bookmark terms to build your personal study list',
            textAlign: TextAlign.center,
            style: getRegularStyle(
              fontSize: FontSize.s15,
              fontFamily: FontConstants.interFamily,
              color: ColorManager.secondaryText,
            ),
          ),
          SizedBox(height: AppHeight.s32),
          PrimaryElevatedButton(
            title: "Browse Dictionary",
            onPress: () {
              context.pop();
              context.go(Routes.dictionary);
            },
            width: AppWidth.s163,
            height: AppHeight.s48,
            buttonRadius: AppRadius.s16,
            textStyle: getBoldStyle(
              fontSize: FontSize.s12,
              color: ColorManager.white,
            ),
          ),
        ],
      ),
    );
  }
}
