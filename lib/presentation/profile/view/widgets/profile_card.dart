import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:medlex/presentation/auth/viewModel/cubit/auth_cubit.dart';
import 'package:medlex/app/resources/assets_manager.dart';
import 'package:medlex/app/resources/color_manager.dart';
import 'package:medlex/app/resources/font_manager.dart';
import 'package:medlex/app/resources/style_manager.dart';
import 'package:medlex/app/resources/values_manager.dart';

class ProfileCard extends StatelessWidget {
  const ProfileCard({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AuthCubit, AuthState>(
      builder: (context, state) {
        final userName = state is AuthAuthenticated ? state.displayName : null;
        final photoUrl = state is AuthAuthenticated ? state.photoUrl : null;

        return Container(
          width: double.infinity,
          height: AppHeight.s167,
          padding: EdgeInsets.only(
            top: AppHeight.s12,
            bottom: AppHeight.s19,
          ),
          decoration: BoxDecoration(
            color: ColorManager.white,
            borderRadius: BorderRadius.circular(AppRadius.s16),
          ),
          child: Column(
            children: [
              Container(
                width: AppWidth.s64,
                height: AppHeight.s64,
                decoration: BoxDecoration(
                  color: ColorManager.lightTealSoft,
                  shape: BoxShape.circle,
                ),
                child: ClipOval(
                  child: photoUrl != null
                      ? Image.network(
                          photoUrl,
                          fit: BoxFit.cover,
                          errorBuilder: (_, __, ___) =>
                              Image.asset(IconAssets.person),
                        )
                      : Image.asset(IconAssets.person),
                ),
              ),
              SizedBox(height: AppHeight.s12),
              Text(
                userName ?? 'Medical Student',
                style: getBoldStyle(
                  fontSize: FontSize.s20,
                  fontFamily: FontConstants.interFamily,
                  color: ColorManager.primaryText,
                ),
              ),
              SizedBox(height: AppHeight.s12),
              Text(
                'Learning progress & settings',
                style: getRegularStyle(
                  fontSize: FontSize.s15,
                  fontFamily: FontConstants.interFamily,
                  color: ColorManager.graySecondaryText,
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
