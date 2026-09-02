import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:medlex/domain/models.dart';
import 'package:medlex/app/resources/values_manager.dart';
import 'bookmark_button.dart';

class TermDetailsAppBar extends StatelessWidget {
  const TermDetailsAppBar({required this.term, super.key});
  final TermModel term;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: AppWidth.s16),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          GestureDetector(
            onTap: () => Navigator.pop(context),
            child: Icon(Icons.chevron_left, color: Colors.black87, size: 24.sp),
          ),
          BookmarkButton(term: term),
        ],
      ),
    );
  }
}
