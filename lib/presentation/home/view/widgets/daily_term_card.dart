import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:medlex/app/ui_utils.dart';
import 'package:medlex/presentation/home/view/widgets/daily_term_card_content.dart';
import 'package:medlex/presentation/home/viewModel/cubit/home_cubit.dart';

class DailyTermCard extends StatelessWidget {
  const DailyTermCard({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HomeCubit, HomeState>(
      buildWhen: (previous, current) => current is HomeLoaded,
      builder: (context, state) {
        if (state is! HomeLoaded) return UiUtils.loadingCard();
        if (state.isLoading) return UiUtils.loadingCard();
        if (state.errorMessage != null) {
          return UiUtils.errorCard(
            message: state.errorMessage!,
            onRetry: () => context.read<HomeCubit>().getDailyTerm(),
          );
        }
        if (state.dailyTerm != null) {
          return DailyTermCardContent(term: state.dailyTerm!);
        }
        return UiUtils.loadingCard();
      },
    );
  }
}
