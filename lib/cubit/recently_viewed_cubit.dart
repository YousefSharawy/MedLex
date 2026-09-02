import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:medlex/app/local_storage.dart';
import 'package:medlex/domain/models.dart';
part 'recently_viewed_state.dart';
part 'recently_viewed_cubit.freezed.dart';

/// The user's browsing history: a short recently-viewed list (shown on Home)
/// and the full history log (shown on the dedicated Recently Viewed screen).
///
/// Purely local — everything here comes from [LocalAppStorage], never the
/// network, so this cubit needs no [Repository].
class RecentlyViewedCubit extends Cubit<RecentlyViewedState> {
  List<TermModel> _recentlyViewed = [];
  List<TermModel> _recentlyViewedHistory = [];

  RecentlyViewedCubit() : super(const RecentlyViewedState.initial()) {
    _recentlyViewed = LocalAppStorage.getRecentlyViewed();
    _recentlyViewedHistory = LocalAppStorage.getRecentlyViewedHistory();

    Future.microtask(() {
      _safeEmit(
        RecentlyViewedState.recentlyViewedUpdated(
          recentlyViewed: List.from(_recentlyViewed),
        ),
      );
    });
  }

  void _safeEmit(RecentlyViewedState state) {
    if (!isClosed) emit(state);
  }

  List<TermModel> get recentlyViewed => _recentlyViewed;
  List<TermModel> get recentlyViewedHistory => _recentlyViewedHistory;

  Future<void> addToRecentlyViewed(TermModel term) async {
    await LocalAppStorage.addRecentlyViewed(term);
    _recentlyViewed = LocalAppStorage.getRecentlyViewed();
    _safeEmit(
      RecentlyViewedState.recentlyViewedUpdated(
        recentlyViewed: List.from(_recentlyViewed),
      ),
    );
  }

  Future<void> addToRecentlyViewedHistory(TermModel term) async {
    await LocalAppStorage.addRecentlyViewedHistory(term);
    _recentlyViewedHistory = LocalAppStorage.getRecentlyViewedHistory();
    _safeEmit(
      RecentlyViewedState.recentlyViewedHistoryUpdated(
        recentlyViewedHistory: List.from(_recentlyViewedHistory),
      ),
    );
  }

  /// Clears both the short recently-viewed list and the full history log.
  Future<void> clearAll() async {
    await LocalAppStorage.clearRecentlyViewed();
    _recentlyViewed = [];
    _recentlyViewedHistory = [];
    _safeEmit(
      const RecentlyViewedState.recentlyViewedUpdated(recentlyViewed: []),
    );
    _safeEmit(
      const RecentlyViewedState.recentlyViewedHistoryUpdated(
        recentlyViewedHistory: [],
      ),
    );
  }
}
