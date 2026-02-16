import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:transly/presentation/auth/view/sign_in_view.dart';
import 'package:transly/presentation/auth/view/success_view.dart';
import 'package:transly/presentation/auth/viewModel/cubit/auth_cubit.dart';
import 'package:transly/presentation/resources/color_manager.dart';
import 'package:transly/presentation/resources/values_manager.dart';

class LoginBottomSheet extends StatefulWidget {
  const LoginBottomSheet({super.key});

  static Future<bool?> show(BuildContext context) {
    return showModalBottomSheet<bool>(
      context: context,
      isScrollControlled: true,
      backgroundColor: ColorManager.trasnparent,
      isDismissible: true,
      enableDrag: true,
      builder: (_) => BlocProvider.value(
        value: context.read<AuthCubit>(),
        child: const LoginBottomSheet(),
      ),
    );
  }

  @override
  State<LoginBottomSheet> createState() => _LoginBottomSheetState();
}

class _LoginBottomSheetState extends State<LoginBottomSheet>
    with SingleTickerProviderStateMixin {
  bool _showSuccess = false;
  String? _errorMsg;

  late AnimationController _successController;

  @override
  void initState() {
    super.initState();
    _successController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 500),
    );
  }

  @override
  void dispose() {
    _successController.dispose();
    super.dispose();
  }

  Future<void> _handleGoogleSignIn() async {
    setState(() => _errorMsg = null);

    final authCubit = context.read<AuthCubit>();
    await authCubit.signInWithGoogle();

    if (!mounted) return;

    final state = authCubit.state;
    if (state is AuthAuthenticated) {
      setState(() => _showSuccess = true);
      _successController.forward();
      await Future.delayed(const Duration(milliseconds: 1800));
      if (mounted) Navigator.pop(context, true);
    } else if (state is AuthError) {
      setState(() => _errorMsg = state.message);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: ColorManager.white,
        borderRadius: BorderRadius.vertical(top: Radius.circular(AppRadius.s32)),
      ),
      child: SafeArea(
        top: false,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            // Handle
            SizedBox(height: AppHeight.s11),
            Container(
              width: AppWidth.s40,
              height: AppHeight.s4,
              decoration: BoxDecoration(
                color: ColorManager.warmLightGray,
                borderRadius: BorderRadius.circular(AppRadius.s2),
              ),
            ),
            SizedBox(height: AppHeight.s20),
            // Body
            AnimatedSwitcher(
              duration: const Duration(milliseconds: 400),
              switchInCurve: Curves.easeOutCubic,
              switchOutCurve: Curves.easeInCubic,
              child: _showSuccess
                  ? SuccessView(
                      controller: _successController,
                      onStartLearning: () => Navigator.pop(context, true),
                    )
                  : SignInView(
                      errorMsg: _errorMsg,
                      onGoogleSignIn: _handleGoogleSignIn,
                      onClose: () => Navigator.pop(context, false),
                    ),
            ),
          ],
        ),
      ),
    );
  }
}