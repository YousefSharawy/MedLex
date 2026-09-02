import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:medlex/app/resources/color_manager.dart';
import 'package:medlex/app/resources/font_manager.dart';
import 'package:medlex/app/resources/style_manager.dart';
import 'package:medlex/app/resources/values_manager.dart';
import 'package:medlex/presentation/search/viewModel/cubit/search_cubit.dart';

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
                backgroundColor: ColorManager.primaryTeal,
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
