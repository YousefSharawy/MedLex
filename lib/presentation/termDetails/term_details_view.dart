import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:transly/presentation/base/components.dart';
import 'package:transly/presentation/resources/assets_manager.dart';
import 'package:transly/presentation/resources/color_manager.dart';
import 'package:transly/presentation/resources/font_manager.dart';
import 'package:transly/presentation/resources/style_manager.dart';
import 'package:transly/presentation/resources/values_manager.dart';
import 'package:transly/presentation/termDetails/term_bullet_point.dart';
import 'package:transly/presentation/termDetails/term_section_header.dart';

class TermDetailsView extends StatefulWidget {
  const TermDetailsView({super.key});

  @override
  State<TermDetailsView> createState() => _ItemDetailsState();
}

class _ItemDetailsState extends State<TermDetailsView> {
  bool _isSimpleMode = true;

  @override
  Widget build(BuildContext context) {
    return PrimaryScaffold(
      body: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: EdgeInsets.symmetric(horizontal: AppWidth.s16),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  GestureDetector(
                    onTap: () => Navigator.pop(context),
                    child: Icon(
                      Icons.chevron_left,
                      color: Colors.black87,
                      size: 24.sp,
                    ),
                  ),
                  GestureDetector(
                    onTap: () {},
                    child: Image.asset(IconAssets.bookmark),
                  ),
                ],
              ),
            ),
            SizedBox(height: AppHeight.s22),
            Expanded(
              child: SingleChildScrollView(
                padding: EdgeInsets.symmetric(horizontal: AppWidth.s16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Zoomable Image Card
                    Container(
                      width: double.infinity,
                      padding: EdgeInsets.all(AppWidth.s20),
                      decoration: BoxDecoration(
                        color: ColorManager.white,
                        borderRadius: BorderRadius.circular(AppRadius.s16),
                        boxShadow: [
                          BoxShadow(
                            color: ColorManager.black.withAlpha(63),
                            blurRadius: 4,
                            spreadRadius: 0,
                            offset: Offset(0, 2),
                          ),
                        ],
                      ),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(AppRadius.s12),
                        child: InteractiveViewer(
                          minScale: 1.0,
                          maxScale: 4.0,
                          child: Image.asset(
                            ImageAssets.heart,
                            height: AppHeight.s155,
                            fit: BoxFit.contain,
                          ),
                        ),
                      ),
                    ),
                    SizedBox(height: AppHeight.s4),
                    Align(
                      alignment: Alignment.center,
                      child: Text(
                        'Medical illustration • Pinch to zoom',
                        style: getRegularStyle(
                          fontSize: FontSize.s12,
                          fontFamily: FontConstants.interFamily,
                          color: ColorManager.graySecondaryText,
                        ),
                      ),
                    ),
                    SizedBox(height: AppHeight.s19),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text(
                          'Myocardium',
                          style: getSemiBoldStyle(
                            fontSize: FontSize.s16,
                            fontFamily: FontConstants.interFamily,
                            color: ColorManager.primaryText,
                          ),
                        ),
                        SizedBox(width: AppWidth.s16),
                        GestureDetector(
                          onTap: () {},
                          child: Image.asset(IconAssets.volumeUp),
                        ),
                        const Spacer(),
                        Container(
                          padding: EdgeInsets.symmetric(
                            horizontal: AppWidth.s10,
                            vertical: AppHeight.s7,
                          ),
                          decoration: BoxDecoration(
                            color: ColorManager.tealSoft,
                            borderRadius: BorderRadius.circular(AppRadius.s32),
                          ),
                          child: Text(
                            'Cardiology',
                            style: getRegularStyle(
                              fontSize: FontSize.s12,
                              fontFamily: FontConstants.interFamily,
                              color: ColorManager.primaryText,
                            ),
                          ),
                        ),
                      ],
                    ),

                    SizedBox(height: AppHeight.s4),
                    Text(
                      '/ˌmaɪ.oʊˈkɑːr.di.əm/',
                      style: getRegularStyle(
                        fontSize: FontSize.s14,
                        fontFamily: FontConstants.interFamily,
                        color: ColorManager.secondaryText,
                      ),
                    ),
                    SizedBox(height: AppHeight.s15),

                    // Toggle with animation
                    Container(
                      height: AppHeight.s58,
                      padding: EdgeInsets.all(AppWidth.s4),
                      decoration: BoxDecoration(
                        color: const Color(0xFFF5F5F5),
                        borderRadius: BorderRadius.circular(AppRadius.s32),
                      ),
                      child: Stack(
                        children: [
                          // Animated sliding background
                          AnimatedAlign(
                            duration: const Duration(milliseconds: 250),
                            curve: Curves.easeInOut,
                            alignment:
                                _isSimpleMode
                                    ? Alignment.centerLeft
                                    : Alignment.centerRight,
                            child: FractionallySizedBox(
                              widthFactor: 0.5,
                              heightFactor: 1,
                              child: Container(
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(
                                    AppRadius.s28,
                                  ),
                                  boxShadow: [
                                    BoxShadow(
                                      color: Colors.black.withOpacity(0.05),
                                      blurRadius: 4,
                                      offset: const Offset(0, 2),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                          // Buttons
                          Row(
                            children: [
                              Expanded(
                                child: GestureDetector(
                                  onTap:
                                      () =>
                                          setState(() => _isSimpleMode = true),
                                  behavior: HitTestBehavior.opaque,
                                  child: Center(
                                    child: Text(
                                      'Simple',
                                      style: getMediumStyle(
                                        fontSize: FontSize.s14,
                                        fontFamily: FontConstants.interFamily,
                                        color:
                                            _isSimpleMode
                                                ? ColorManager.primaryText
                                                : ColorManager.secondaryText,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                              Expanded(
                                child: GestureDetector(
                                  onTap:
                                      () =>
                                          setState(() => _isSimpleMode = false),
                                  behavior: HitTestBehavior.opaque,
                                  child: Center(
                                    child: Text(
                                      'Academic',
                                      style: getMediumStyle(
                                        fontSize: FontSize.s14,
                                        fontFamily: FontConstants.interFamily,
                                        color:
                                            !_isSimpleMode
                                                ? ColorManager.primary
                                                : ColorManager.secondaryText,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),

                    SizedBox(height: AppHeight.s15),

                    // Animated content
                    AnimatedSwitcher(
                      duration: const Duration(milliseconds: 300),
                      child: Column(
                        key: ValueKey(_isSimpleMode),
                        children: [
                          TermSectionHeader(
                            title: 'Definition',
                            child: Text(
                              _isSimpleMode
                                  ? 'Commonly known as a heart attack. Occurs when blood flow to part of the heart muscle is blocked.'
                                  : 'Acute coronary syndrome resulting from myocardial necrosis secondary to prolonged ischemia, typically caused by thrombotic occlusion of a coronary artery due to atherosclerotic plaque rupture. Diagnosed via elevated cardiac biomarkers (troponin) and ECG changes.',
                              style: getRegularStyle(
                                fontSize: FontSize.s14,
                                fontFamily: FontConstants.interFamily,
                                color: ColorManager.darkGrey,
                                height: 1.4,
                              ),
                            ),
                          ),

                          SizedBox(height: AppHeight.s16),

                          TermSectionHeader(
                            title: 'Causes',
                            child: Column(
                              children: [
                                TermBulletPoint(
                                  text: 'Coronary artery atherosclerosis',
                                ),
                                TermBulletPoint(
                                  text: 'Plaque rupture with thrombosis',
                                ),
                                TermBulletPoint(text: 'Coronary artery spasm'),
                                TermBulletPoint(text: 'Cocaine use'),
                                TermBulletPoint(text: 'Coronary embolism'),
                              ],
                            ),
                          ),

                          SizedBox(height: AppHeight.s16),

                          TermSectionHeader(
                            title: 'Symptoms',
                            child: Column(
                              children: [
                                TermBulletPoint(text: 'Chest pain or pressure'),
                                TermBulletPoint(text: 'Shortness of breath'),
                                TermBulletPoint(
                                  text: 'Pain radiating to arm, jaw, or back',
                                ),
                                TermBulletPoint(text: 'Nausea and sweating'),
                                TermBulletPoint(text: 'Lightheadedness'),
                              ],
                            ),
                          ),

                          SizedBox(height: AppHeight.s16),

                          TermSectionHeader(
                            title: 'Treatment',
                            child: Column(
                              children: [
                                TermBulletPoint(
                                  text: 'Aspirin and antiplatelet therapy',
                                ),
                                TermBulletPoint(
                                  text:
                                      'Percutaneous coronary intervention (PCI)',
                                ),
                                TermBulletPoint(text: 'Thrombolytic therapy'),
                                TermBulletPoint(text: 'Beta-blockers'),
                                TermBulletPoint(text: 'ACE inhibitors'),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),

                    SizedBox(height: AppHeight.s100),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}