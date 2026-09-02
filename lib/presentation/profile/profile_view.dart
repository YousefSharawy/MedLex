import 'package:flutter/material.dart';
import 'package:medlex/presentation/profile/view/widgets/bottom_section_card.dart';
import 'package:medlex/presentation/profile/view/widgets/profile_card.dart';
import 'package:medlex/presentation/profile/view/widgets/top_section_card.dart';
import 'package:medlex/presentation/profile/view/widgets/section_header.dart';
import 'package:medlex/app/resources/color_manager.dart';
import 'package:medlex/app/resources/font_manager.dart';
import 'package:medlex/app/resources/style_manager.dart';
import 'package:medlex/app/resources/values_manager.dart';
import 'package:medlex/presentation/base/primary_teal_scaffold.dart';

class ProfileView extends StatelessWidget {
  const ProfileView({super.key});

  @override
  Widget build(BuildContext context) {
    return PrimaryTealScaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          padding: EdgeInsets.symmetric(horizontal: AppWidth.s16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Profile & Settings',
                style: getBoldStyle(
                  fontSize: FontSize.s24,
                  fontFamily: FontConstants.interFamily,
                  color: ColorManager.primaryText,
                ),
              ),
              SizedBox(height: AppHeight.s9),
              const ProfileCard(),
              SizedBox(height: AppHeight.s9),
              SectionHeader(label: "Learning"),
              SizedBox(height: AppHeight.s8),
              TopSectionCard(),
              SizedBox(height: AppHeight.s28),
              SectionHeader(label: "App"),
              SizedBox(height: AppHeight.s8),
              BottomSectionCard(),
              SizedBox(height: AppHeight.s60),
            ],
          ),
        ),
      ),
    );
  }
}
