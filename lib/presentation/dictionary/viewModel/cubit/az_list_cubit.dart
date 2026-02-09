import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:transly/domain/models.dart';
import 'package:transly/presentation/dictionary/view/widgets/azListView/az_build_result.dart';
import 'package:azlistview/azlistview.dart';

part 'az_list_state.dart';
part 'az_list_cubit.freezed.dart';

class AzListCubit extends Cubit<AzListState> {
  AzBuildResult? _cachedResult;
  int _cachedTermsLength = 0;
  String? _lastCategory;
  bool _lastHasMore = false;

  AzListCubit() : super(const AzListState.initial());

  AzBuildResult buildAzItems({
    required List<TermModel> terms,
    required String selectedCategory,
    required bool hasMore,
    required bool isAllCategory,
  }) {
    // Return cached result if nothing changed
    if (_cachedResult != null &&
        _lastCategory == selectedCategory &&
        _cachedTermsLength == terms.length &&
        _lastHasMore == hasMore) {
      return _cachedResult!;
    }

    final result = AzBuildResult.build(
      terms,
      addLoadingIndicator: isAllCategory && hasMore,
    );

    if (result.items.isNotEmpty) {
      SuspensionUtil.setShowSuspensionStatus(result.items);
    }

    _cachedResult = result;
    _cachedTermsLength = terms.length;
    _lastCategory = selectedCategory;
    _lastHasMore = hasMore;

    return result;
  }

  void invalidateCache() {
    _cachedResult = null;
    _cachedTermsLength = 0;
    _lastHasMore = false;
    _lastCategory = null;
  }

  bool shouldRebuildData(String newCategory) {
    return _lastCategory != newCategory;
  }

  @override
  Future<void> close() {
    // Clear cache to free memory
    invalidateCache();
    return super.close();
  }
}