part of 'terms_cubit.dart';

@freezed
class TermsState with _$TermsState {
  const factory TermsState.initial() = _TermsInitial;

  // ==================== ALL TERMS ====================

  const factory TermsState.allTermsLoading() = AllTermsLoading;

  const factory TermsState.allTermsLoaded({
    required List<TermModel> terms,
    required bool hasMore,
    required int currentPage,
    required int totalCount,
    @Default(false) bool isLoadingMore,
    String? pendingLetter,
    String? letterJustLoaded,
    @Default(false) bool isLetterLoading,
    @Default({}) Map<String, List<TermModel>> groupedTerms,
  }) = AllTermsLoaded;

  const factory TermsState.allTermsError(String message) = AllTermsError;

  // ==================== CATEGORY ====================

  const factory TermsState.termsByCategoryLoading() = TermsByCategoryLoading;

  const factory TermsState.termsByCategoryLoaded(List<TermModel> terms) =
      TermsByCategoryLoaded;

  const factory TermsState.termsByCategoryError(String message) =
      TermsByCategoryError;
}
