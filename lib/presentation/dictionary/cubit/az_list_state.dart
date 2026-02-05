part of 'az_list_cubit.dart';

@freezed
class AzListState with _$AzListState {
  const factory AzListState.initial() = _Initial;
   const factory AzListState.loaded({
    required List<AzItem> azItems,
    required Set<String> availableLetters,
    required String selectedCategory,
    String? pendingScrollLetter,
  }) = _Loaded;
  const factory AzListState.scrollToLetter({
    required List<AzItem> azItems,
    required Set<String> availableLetters,
    required String selectedCategory,
    required String letter,
    required int targetIndex,
  }) = _ScrollToLetter;
}
