import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:transly/presentation/resources/color_manager.dart';
import 'package:transly/presentation/resources/font_manager.dart';
import 'package:transly/presentation/resources/style_manager.dart';
import 'package:transly/presentation/resources/values_manager.dart';
import 'package:transly/presentation/search/viewModel/cubit/search_cubit.dart';

void handleSearchItemClick(BuildContext context, String searchText) {
  context.read<SearchCubit>().setSearchTextAndActivate(searchText);
}

class EmptyHint extends StatelessWidget {
  const EmptyHint({required this.text, super.key});
  final String text;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: AppHeight.s8),
      child: Text(
        text,
        style: getRegularStyle(
          fontSize: FontSize.s12,
          color: ColorManager.secondaryText.withOpacity(0.7),
        ),
      ),
    );
  }
}

class PlaceHolderItem extends StatelessWidget {
  const PlaceHolderItem({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: AppHeight.s12),
      padding: EdgeInsets.symmetric(
        horizontal: AppWidth.s10,
        vertical: AppHeight.s7,
      ),
      decoration: BoxDecoration(
        color: ColorManager.white,
        border: Border.all(color: ColorManager.black.withAlpha(25)),
        borderRadius: BorderRadius.circular(AppRadius.s16),
      ),
      child: Row(
        children: [
          Container(
            width: AppWidth.s59,
            height: AppHeight.s66,
            decoration: BoxDecoration(
              color: ColorManager.grey.withOpacity(0.2),
              borderRadius: BorderRadius.circular(AppRadius.s8),
            ),
          ),
          SizedBox(width: AppWidth.s15),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'No recent terms',
                  style: getRegularStyle(
                    fontSize: FontSize.s15,
                    fontFamily: FontConstants.interFamily,
                    color: ColorManager.secondaryText,
                  ),
                ),
                SizedBox(height: AppHeight.s8),
                Text(
                  'Search to add terms',
                  style: getRegularStyle(
                    fontSize: FontSize.s12,
                    fontFamily: FontConstants.interFamily,
                    color: ColorManager.secondaryText.withOpacity(0.7),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class ClearRecentlySearchedDialog extends StatelessWidget {
  const ClearRecentlySearchedDialog({super.key});

  static Future<void> show(BuildContext context) {
    return showDialog(
      context: context,
      builder: (_) => const ClearRecentlySearchedDialog(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(AppRadius.s16),
      ),
      title: Text(
        'Clear Search History',
        style: getSemiBoldStyle(
          fontSize: FontSize.s16,
          fontFamily: FontConstants.interFamily,
          color: ColorManager.primaryText,
        ),
      ),
      content: Text(
        'Are you sure you want to clear all recently searched items?',
        style: getRegularStyle(
          fontSize: FontSize.s14,
          fontFamily: FontConstants.interFamily,
          color: ColorManager.secondaryText,
        ),
      ),
      actions: [
        TextButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          child: Text(
            'Cancel',
            style: getMediumStyle(
              fontSize: FontSize.s14,
              fontFamily: FontConstants.interFamily,
              color: ColorManager.grey,
            ),
          ),
        ),
        TextButton(
          onPressed: () {
            context.read<SearchCubit>().clearRecentlySearched();
            Navigator.of(context).pop();

            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(
                  'Search history cleared',
                  style: getRegularStyle(
                    fontSize: FontSize.s14,
                    fontFamily: FontConstants.interFamily,
                    color: ColorManager.white,
                  ),
                ),
                backgroundColor: ColorManager.primary,
                behavior: SnackBarBehavior.floating,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(AppRadius.s8),
                ),
                duration: const Duration(seconds: 2),
              ),
            );
          },
          child: Text(
            'Clear',
            style: getMediumStyle(
              fontSize: FontSize.s14,
              fontFamily: FontConstants.interFamily,
              color: ColorManager.error,
            ),
          ),
        ),
      ],
    );
  }
}
