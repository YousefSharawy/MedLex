part of 'az_list_cubit.dart';

@freezed
class AzListState with _$AzListState {
  const factory AzListState({
    @Default([]) List<AzItem> azItems,
    @Default({}) Set<String> availableLetters,
    @Default(false) bool isNavigating,
  }) = _Initial;
}