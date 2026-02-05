import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:transly/domain/models.dart';
import 'package:transly/presentation/dictionary/widgets/azListView/az_build_result.dart';
import 'package:transly/presentation/dictionary/widgets/azListView/az_item.dart';
import 'package:azlistview/azlistview.dart';

part 'az_list_state.dart';
part 'az_list_cubit.freezed.dart';

class AzListCubit extends Cubit<AzListState> {
  List<TermModel>? _cachedAllTerms;
  String? _lastCategory;
  
  AzListCubit() : super(const AzListState.initial());

  AzBuildResult buildAzItems({
    required List<TermModel> terms,
    required String selectedCategory,
    required bool hasMore,
    required bool isAllCategory,
  }) {
    final termsToUse = isAllCategory ? (_cachedAllTerms ?? terms) : terms;
    
    final result = AzBuildResult.build(
      termsToUse,
      addLoadingIndicator: isAllCategory && hasMore,
    );

    if (result.items.isNotEmpty) {
      SuspensionUtil.setShowSuspensionStatus(result.items);
    }

    return result;
  }

  void initializeCache({
    required List<TermModel> terms,
    required String selectedCategory,
    required bool isAllCategory,
  }) {
    if (isAllCategory && _cachedAllTerms == null) {
      _cachedAllTerms = List.from(terms);
    }
    _lastCategory = selectedCategory;
  }

  void updateCache({
    required List<TermModel> terms,
    required String selectedCategory,
    required bool isAllCategory,
  }) {
    if (isAllCategory) {
      _cachedAllTerms = List.from(terms);
    }
    _lastCategory = selectedCategory;
  }

  bool shouldRebuildData(String newCategory) {
    return _lastCategory != newCategory;
  }

  List<TermModel>? get cachedTerms => _cachedAllTerms;
}