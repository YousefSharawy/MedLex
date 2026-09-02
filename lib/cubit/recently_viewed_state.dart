part of 'recently_viewed_cubit.dart';

@freezed
class RecentlyViewedState with _$RecentlyViewedState {
  const factory RecentlyViewedState.initial() = _RecentlyViewedInitial;

  const factory RecentlyViewedState.recentlyViewedUpdated({
    @Default([]) List<TermModel> recentlyViewed,
  }) = RecentlyViewedUpdated;

  const factory RecentlyViewedState.recentlyViewedHistoryLoading() =
      RecentlyViewedHistoryLoading;
  const factory RecentlyViewedState.recentlyViewedHistoryLoaded(
    List<TermModel> recentlyViewedHistory,
  ) = RecentlyViewedHistoryLoaded;
  const factory RecentlyViewedState.recentlyViewedHistoryUpdated({
    @Default([]) List<TermModel> recentlyViewedHistory,
  }) = RecentlyViewedHistoryUpdated;
}
