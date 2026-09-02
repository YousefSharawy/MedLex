import 'package:flutter/material.dart';
import 'package:medlex/app/widgets/term_item.dart';
import 'package:medlex/domain/models.dart';
import 'package:medlex/app/resources/values_manager.dart';

class TermsList extends StatelessWidget {
  final List<TermModel> terms;

  const TermsList({
    super.key,
    required this.terms,
  });

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      padding: EdgeInsets.symmetric(horizontal: AppWidth.s16),
      itemCount: terms.length,
      separatorBuilder: (_, __) => SizedBox.shrink(),
      itemBuilder: (context, index) {
        final term = terms[index];
        return TermItem(term: term);
      },
    );
  }
}
