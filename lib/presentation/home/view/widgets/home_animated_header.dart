import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:medlex/presentation/auth/view/login_bottom_sheet.dart';
import 'package:medlex/presentation/auth/viewModel/cubit/auth_cubit.dart';
import 'package:medlex/app/resources/assets_manager.dart';
import 'package:medlex/app/resources/color_manager.dart';
import 'package:medlex/app/resources/font_manager.dart';
import 'package:medlex/app/resources/routes.dart';
import 'package:medlex/app/resources/style_manager.dart';
import 'package:medlex/app/resources/values_manager.dart';

class HomeAnimatedHeader extends StatelessWidget {
  final bool isSearching;

  const HomeAnimatedHeader({super.key, required this.isSearching});

  @override
  Widget build(BuildContext context) {
    const duration = Duration(milliseconds: 300);

    final homeHeader = AnimatedOpacity(
      duration: duration,
      opacity: isSearching ? 0.0 : 1.0,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Expanded(
                child: Text(
                  'Medlex',
                  style: getBoldStyle(
                    fontSize: FontSize.s24,
                    fontFamily: FontConstants.interFamily,
                    color: ColorManager.primaryText,
                  ),
                ),
              ),
              IconButton(
                onPressed: () async {
                  final authCubit = context.read<AuthCubit>();
                  if (authCubit.isAnonymous) {
                    final result = await LoginBottomSheet.show(context);
                    if (result != true) return;
                  }
                  if (!context.mounted) return;
                  context.push(Routes.profile);
                  context.pushReplacement(Routes.savedItems);
                },
                icon: Image.asset(IconAssets.bookmarkActive),
              ),
            ],
          ),
          SizedBox(height: AppHeight.s6),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: AppWidth.s2),
            child: Text(
              'Medical knowledge made visual',
              style: getRegularStyle(
                fontSize: FontSize.s15,
                fontFamily: FontConstants.interFamily,
                color: ColorManager.secondaryText,
              ),
            ),
          ),
          SizedBox(height: AppHeight.s8),
        ],
      ),
    );

    final searchHeader = AnimatedOpacity(
      duration: duration,
      opacity: isSearching ? 1.0 : 0.0,
      child: Column(
        children: [
          Text(
            'Search',
            style: getBoldStyle(
              fontSize: FontSize.s24,
              fontFamily: FontConstants.interFamily,
              color: ColorManager.primaryText,
            ),
          ),
          SizedBox(height: AppHeight.s12),
        ],
      ),
    );

    return AnimatedSize(
      duration: duration,
      curve: Curves.easeOut,
      child: isSearching ? searchHeader : homeHeader,
    );
  }
}
