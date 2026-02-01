// lib/view_model/cubit/navigation_cubit.dart
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'navigation_state.dart';
part 'navigation_cubit.freezed.dart';

class NavigationCubit extends Cubit<NavigationState> {
  NavigationCubit() : super(const NavigationState.initial());

  void updateIndex(int newIndex) {
    state.maybeWhen(
      loaded: (currentIndex, previousIndex) {
        if (currentIndex != newIndex) {
          emit(NavigationState.loaded(
            currentIndex: newIndex,
            previousIndex: currentIndex,
          ));
        }
      },
      orElse: () {
        emit(NavigationState.loaded(
          currentIndex: newIndex,
          previousIndex: 0,
        ));
      },
    );
  }

  void reset() {
    emit(const NavigationState.initial());
  }
}