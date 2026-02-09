part of 'term_details_cubit.dart';

@freezed
class TermDetailsState with _$TermDetailsState {
  const factory TermDetailsState.initial() = _TermDetailsInitial;
  const factory TermDetailsState.loading() = TermDetailsLoading;
  const factory TermDetailsState.loaded(TermModel term) = TermDetailsLoaded;
  const factory TermDetailsState.error(String message) = TermDetailsError;
}