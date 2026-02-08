import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:transly/presentation/base/components.dart';
import 'package:transly/presentation/resources/values_manager.dart';

class StudyView extends StatelessWidget {
  const StudyView({super.key});

  @override
  Widget build(BuildContext context) {
    return PrimaryScaffold(
      body: Center(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: AppWidth.s24),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(
                Icons.auto_stories_outlined,
                size: 64.sp,
                color: Colors.grey.shade400,
              ),
              SizedBox(height: AppHeight.s16),
              Text(
                'Study Mode',
                style: Theme.of(
                  context,
                ).textTheme.titleLarge?.copyWith(fontWeight: FontWeight.w600),
              ),
              SizedBox(height: AppHeight.s8),
              Text(
                'This feature is coming soon.\nWe’re building something great for learning.',
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  color: Colors.grey.shade600,
                  height: 1.4.sp,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
