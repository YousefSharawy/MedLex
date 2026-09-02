import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:medlex/app/adds/view/ad_container.dart';
import 'package:medlex/presentation/auth/view/login_bottom_sheet.dart';
import 'package:medlex/presentation/auth/viewModel/cubit/auth_cubit.dart';
import 'package:medlex/presentation/base/nav_bar_item.dart';
import 'package:medlex/presentation/search/viewModel/cubit/navigation_cubit.dart';
import 'package:medlex/app/resources/assets_manager.dart';
import 'package:medlex/app/resources/values_manager.dart';

class ScaffoldWithNavBar extends StatelessWidget {
  const ScaffoldWithNavBar({required this.navigationShell, Key? key})
    : super(key: key ?? const ValueKey<String>('ScaffoldWithNavBar'));

  final StatefulNavigationShell navigationShell;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        
        children: [
          
          Expanded(
          child: navigationShell),
           const BannerAdWidget(),
        ],
      ),
      extendBody: false,
      bottomNavigationBar: Container(
        margin: EdgeInsets.only(
          left: AppWidth.s16,
          right: AppWidth.s16,
          bottom: AppHeight.s24,
        ),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(AppRadius.s32),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.25),
              blurRadius: 4,
              offset: const Offset(0, 4),
              spreadRadius: 0,
            ),
          ],
        ),
        child: Padding(
          padding: EdgeInsets.symmetric(
            horizontal: AppWidth.s9,
            vertical: AppHeight.s10,
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              NavBarItem(
                iconPath: IconAssets.homeIcon,
                label: 'Home',
                isSelected: navigationShell.currentIndex == 0,
                onTap: () => _onTap(context, 0),
              ),
              NavBarItem(
                iconPath: IconAssets.dictionaryIcon,
                label: 'Dictionary',
                isSelected: navigationShell.currentIndex == 1,
                onTap: () => _onTap(context, 1),
              ),
              NavBarItem(
                iconPath: IconAssets.profileIcon,
                label: 'Profile',
                isSelected: navigationShell.currentIndex == 2,
                onTap: () async {
                  final authCubit = context.read<AuthCubit>();
                  if (authCubit.isAnonymous) {
                    final result = await LoginBottomSheet.show(context);
                    if (result != true) return;
                  }
                  _onTap(context, 2);
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _onTap(BuildContext context, int index) {
    if (index == navigationShell.currentIndex) return;
    context.read<NavigationCubit>().updateIndex(index);

    navigationShell.goBranch(
      index,
      initialLocation: index == navigationShell.currentIndex,
    );
  }
}
