import 'package:flutter/material.dart';
import 'package:medlex/app/widgets/term_item.dart';
import 'package:medlex/domain/models.dart';

class TermTile extends StatelessWidget {
  final TermModel term;

  const TermTile({
    super.key,
    required this.term,
  });

  @override
  Widget build(BuildContext context) {
    return TermItem(
      term: term,
    );
  }


}