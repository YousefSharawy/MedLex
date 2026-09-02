import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:medlex/presentation/search/viewModel/cubit/search_cubit.dart';

void activateSearchTerm(BuildContext context, String searchText) {
  context.read<SearchCubit>().setSearchTextAndActivate(searchText);
}
