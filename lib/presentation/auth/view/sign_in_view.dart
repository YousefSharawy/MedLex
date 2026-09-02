import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:medlex/presentation/auth/viewModel/cubit/auth_cubit.dart';
import 'package:medlex/app/resources/color_manager.dart';
import 'package:medlex/app/resources/font_manager.dart';
import 'package:medlex/app/resources/style_manager.dart';
import 'package:medlex/app/resources/values_manager.dart';
import 'google_sign_in_button.dart';
import 'error_message.dart';
import 'terms_text.dart';

class SignInView extends StatelessWidget {
  final String? errorMsg;
  final VoidCallback onGoogleSignIn;
  final VoidCallback onClose;

  const SignInView({
    super.key,
    required this.errorMsg,
    required this.onGoogleSignIn,
    required this.onClose,
  });

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AuthCubit, AuthState>(
      key: const ValueKey('signin'),
      builder: (context, state) {
        final isLoading = state is AuthSigningIn;
        return Padding(
          padding: EdgeInsets.symmetric(horizontal: AppWidth.s24),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              SizedBox(height: AppHeight.s8),
              Container(
                width: AppWidth.s64,
                height: AppHeight.s64,
                decoration: BoxDecoration(
                  color: ColorManager.tealSoft,
                  borderRadius: BorderRadius.circular(AppRadius.s18),
                ),
                child: Icon(
                  Icons.person_outline_rounded,
                  size: 30.sp,
                  color: ColorManager.primaryTeal,
                ),
              ),
              SizedBox(height: AppHeight.s20),
              Text(
                'Welcome to Medlex',
                style: getExtraBoldStyle(
                  fontSize: FontSize.s22,
                  color: ColorManager.primaryText,
                ),
                textAlign: TextAlign.center,
              ),
              SizedBox(height: AppHeight.s8),
              // Description
              Text(
                'Sign in to save your favorite terms, sync\nacross devices, and track your progress.',
                style: getRegularStyle(
                  fontSize: FontSize.s14,
                  color: ColorManager.secondaryText,
                ),
                textAlign: TextAlign.center,
              ),
              SizedBox(height: AppHeight.s28),

              // Google Button
              GoogleSignInButton(
                isLoading: isLoading,
                onPressed: onGoogleSignIn,
              ),
              // Error
              if (errorMsg != null) ...[
                SizedBox(height: AppHeight.s14),
                ErrorMessage(message: "Canceled"),
              ],
              SizedBox(height: AppHeight.s10),
              const TermsText(),
              SizedBox(height: AppHeight.s24),
            ],
          ),
        );
      },
    );
  }
}
