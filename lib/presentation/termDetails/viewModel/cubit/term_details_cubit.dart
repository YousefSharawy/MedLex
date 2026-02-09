import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:transly/domain/models.dart';
import 'package:transly/domain/repository.dart';

part 'term_details_state.dart';
part 'term_details_cubit.freezed.dart';

class TermDetailsCubit extends Cubit<TermDetailsState> {
  final Repository _repository;

  TermDetailsCubit(this._repository) : super(const TermDetailsState.initial());

  /// Safe emit that checks if cubit is still open
  void _safeEmit(TermDetailsState state) {
    if (!isClosed) emit(state);
  }

  // ==================== TERM DETAILS ====================

  Future<void> getTermById(int id) async {
    _safeEmit(const TermDetailsState.loading());

    final result = await _repository.getTermById(id);
    if (isClosed) return;

    result.fold(
      (failure) => _safeEmit(TermDetailsState.error(failure.message)),
      (term) => _safeEmit(TermDetailsState.loaded(term)),
    );
  }
}