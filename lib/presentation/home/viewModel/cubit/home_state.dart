part of 'home_cubit.dart';

@freezed
class HomeState with _$HomeState {
  const factory HomeState.initial() = _HomeInitial;

  const factory HomeState.loaded({
    TermModel? dailyTerm,
    @Default(false) bool isLoading,
    String? errorMessage,
    @Default([]) List<TermModel> popularTerms,
    @Default([]) List<TermModel> trendingTerms,
  }) = HomeLoaded;
}