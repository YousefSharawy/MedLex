// lib/view_model/cubit/resettable_tab_state.dart
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:transly/presentation/search/view_model/cubit/navigation_cubit.dart';

mixin ResettableTabState<T extends StatefulWidget> on State<T> {
  int get tabIndex;

  void resetState();

  @override
  Widget build(BuildContext context) {
    return BlocListener<NavigationCubit, NavigationState>(
      listenWhen: (previous, current) {
        return previous.maybeWhen(
          loaded: (prevCurrent, prevPrevious) {
            return current.maybeWhen(
              loaded: (currCurrent, currPrevious) {
                return prevCurrent == tabIndex && currCurrent != tabIndex;
              },
              orElse: () => false,
            );
          },
          orElse: () => false,
        );
      },
      listener: (context, state) {
        resetState();
      },
      child: buildContent(context),
    );
  }

  Widget buildContent(BuildContext context);
}
