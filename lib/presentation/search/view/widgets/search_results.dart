import 'package:flutter/material.dart';
import 'package:medlex/app/widgets/term_item.dart';
import 'package:medlex/domain/models.dart';

class SearchResults extends StatelessWidget {
  const SearchResults({super.key, required this.terms});

  final List<TermModel> terms;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      padding: EdgeInsets.zero,
      itemCount: terms.length,
      itemBuilder: (_, index) {
        final term = terms[index];
        return TermItem(
          term: term,
        
        );
      },
    );
  }
}
