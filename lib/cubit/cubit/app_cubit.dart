import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:transly/domain/models.dart';
import 'package:transly/domain/repository.dart';

part 'app_state.dart';
part 'app_cubit.freezed.dart';

class AppCubit extends Cubit<AppState> {
  final Repository _repository;
  
  TermModel? _dailyTerm;
  bool _isSearching = false;

  AppCubit(this._repository) : super(const AppState.initial());

  // Getters
  bool get isSearching => _isSearching;
  TermModel? get dailyTerm => _dailyTerm;

  // Search state management
  void setSearching(bool value) {
    _isSearching = value;
    _emitHomeState();
  }

  void resetHomeState() {
    _isSearching = false;
    _emitHomeState();
  }

  void _emitHomeState({bool isLoading = false, String? errorMessage}) {
    emit(AppState.homeLoaded(
      dailyTerm: _dailyTerm,
      isSearching: _isSearching,
      isLoading: isLoading,
      errorMessage: errorMessage,
    ));
  }

  Future<void> getDailyTerm() async {
    _emitHomeState(isLoading: true);
    
    final result = await _repository.getDailyTerm();
    
    result.fold(
      (failture) {
        _dailyTerm = null;
        _emitHomeState(errorMessage: failture.message);
      },
      (term) {
        _dailyTerm = term;
        _emitHomeState();
      },
    );
  }

  Future<void> searchTerms(String query) async {
    if (query.trim().isEmpty) {
      emit(const AppState.searchEmpty());
      return;
    }
    
    emit(const AppState.searchLoading());
    
    final result = await _repository.searchTerms(query);
    
    result.fold(
      (failture) => emit(AppState.searchError(failture.message)),
      (terms) {
        if (terms.isEmpty) {
          emit(const AppState.searchEmpty());
        } else {
          emit(AppState.searchLoaded(terms));
        }
      },
    );
  }

  Future<void> getCategories() async {
    emit(const AppState.categoriesLoading());
    
    final result = await _repository.getCategories();
    
    result.fold(
      (failture) => emit(AppState.categoriesError(failture.message)),
      (categories) => emit(AppState.categoriesLoaded(categories)),
    );
  }

  // Get Terms by Category
  Future<void> getTermsByCategory(String category) async {
    emit(const AppState.termsByCategoryLoading());
    
    final result = await _repository.getTermsByCategory(category);
    
    result.fold(
      (failture) => emit(AppState.termsByCategoryError(failture.message)),
      (terms) => emit(AppState.termsByCategoryLoaded(terms)),
    );
  }

  // Get Term by ID
  Future<void> getTermById(int id) async {
    emit(const AppState.termDetailsLoading());
    
    final result = await _repository.getTermById(id);
    
    result.fold(
      (failture) => emit(AppState.termDetailsError(failture.message)),
      (term) => emit(AppState.termDetailsLoaded(term)),
    );
  }
}