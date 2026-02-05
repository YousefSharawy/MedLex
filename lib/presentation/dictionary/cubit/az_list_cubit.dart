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
  
  AzListCubit() : super(const AzListState.initial());

  void initialize({
    required List<TermModel> terms,
    required String selectedCategory,
    required bool hasMore,
    required bool isAllCategory,
  }) {
    if (isAllCategory) {
      _cachedAllTerms = List.from(terms);
    }
    
    _buildAzData(
      terms: isAllCategory ? (_cachedAllTerms ?? terms) : terms,
      selectedCategory: selectedCategory,
      hasMore: isAllCategory && hasMore,
    );
  }

  void updateTerms({
    required List<TermModel> terms,
    required String selectedCategory,
    required bool hasMore,
    required bool isAllCategory,
  }) {
    if (isAllCategory) {
      _cachedAllTerms = List.from(terms);
    }
    
    _buildAzData(
      terms: isAllCategory ? (_cachedAllTerms ?? terms) : terms,
      selectedCategory: selectedCategory,
      hasMore: isAllCategory && hasMore,
    );
  }

  void _buildAzData({
    required List<TermModel> terms,
    required String selectedCategory,
    required bool hasMore,
  }) {
    final result = AzBuildResult.build(
      terms,
      addLoadingIndicator: hasMore,
    );

    if (result.items.isNotEmpty) {
      SuspensionUtil.setShowSuspensionStatus(result.items);
    }

    emit(AzListState.loaded(
      azItems: result.items,
      availableLetters: result.availableLetters,
      selectedCategory: selectedCategory,
    ));
  }

  void requestScrollToLetter(String letter) {
    state.maybeWhen(
      loaded: (azItems, availableLetters, selectedCategory, _) {
        if (availableLetters.contains(letter)) {
          final index = azItems.indexWhere(
            (item) => item.getSuspensionTag() == letter && !item.isLoadingIndicator,
          );
          
          if (index != -1) {
            emit(AzListState.scrollToLetter(
              azItems: azItems,
              availableLetters: availableLetters,
              selectedCategory: selectedCategory,
              letter: letter,
              targetIndex: index,
            ));
            
            // Reset back to loaded state
            Future.microtask(() {
              if (!isClosed) {
                emit(AzListState.loaded(
                  azItems: azItems,
                  availableLetters: availableLetters,
                  selectedCategory: selectedCategory,
                ));
              }
            });
          }
        } else {
          // Letter not available
          emit(AzListState.loaded(
            azItems: azItems,
            availableLetters: availableLetters,
            selectedCategory: selectedCategory,
            pendingScrollLetter: letter,
          ));
        }
      },
      orElse: () {},
    );
  }

  void clearPendingScroll() {
    state.maybeWhen(
      loaded: (azItems, availableLetters, selectedCategory, pendingScrollLetter) {
        if (pendingScrollLetter != null) {
          emit(AzListState.loaded(
            azItems: azItems,
            availableLetters: availableLetters,
            selectedCategory: selectedCategory,
          ));
        }
      },
      orElse: () {},
    );
  }

  void updateCache(List<TermModel> terms) {
    _cachedAllTerms = List.from(terms);
  }

  List<TermModel>? get cachedTerms => _cachedAllTerms;
}