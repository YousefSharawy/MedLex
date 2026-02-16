import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:transly/presentation/resources/color_manager.dart';
import 'package:transly/presentation/resources/font_manager.dart';
import 'package:transly/presentation/resources/values_manager.dart';

class ErrorMessage extends StatelessWidget {
  final String message;

  const ErrorMessage({super.key, required this.message});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: AppWidth.s14,
        vertical: AppHeight.s10,
      ),
      decoration: BoxDecoration(
        color: ColorManager.lightError,
        borderRadius: BorderRadius.circular(AppRadius.s10),
      ),
      child: Row(
        children: [
          Icon(
            Icons.error_outline_rounded,
            size: 16.sp,
            color: ColorManager.error,
          ),
          SizedBox(width: AppWidth.s8),
          Expanded(
            child: Text(
              message,
              style: TextStyle(
                fontSize: FontSize.s13,
                color: ColorManager.error,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
