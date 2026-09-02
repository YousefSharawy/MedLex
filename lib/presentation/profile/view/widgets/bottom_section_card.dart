import 'dart:io';
import 'dart:typed_data';

import 'package:feedback/feedback.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_email_sender/flutter_email_sender.dart';
import 'package:go_router/go_router.dart';
import 'package:path_provider/path_provider.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:medlex/app/resources/assets_manager.dart';
import 'package:medlex/app/resources/color_manager.dart';
import 'package:medlex/app/resources/font_manager.dart';
import 'package:medlex/app/resources/routes.dart';
import 'package:medlex/app/resources/style_manager.dart';
import 'package:medlex/app/resources/values_manager.dart';
import 'package:medlex/app/ui_utils.dart';
import 'package:medlex/cubit/favorites_cubit.dart';
import 'package:medlex/cubit/recently_viewed_cubit.dart';
import 'package:medlex/presentation/search/viewModel/cubit/search_cubit.dart';
import 'section_row.dart';
import 'package:medlex/app/widgets/toast_manager.dart';

const String _feedbackRecipient = 'youssifsharawy25@gmail.com';

Future<String> writeImageToStorage(Uint8List feedbackScreenshot) async {
  final Directory output = await getTemporaryDirectory();
  final String screenshotFilePath = '${output.path}/feedback.png';
  final File screenshotFile = File(screenshotFilePath);
  await screenshotFile.writeAsBytes(feedbackScreenshot);
  return screenshotFilePath;
}

Future<void> _openGmailForFeedback(String feedbackText) async {
  final subject = Uri.encodeComponent('App Feedback');
  final body = Uri.encodeComponent(feedbackText);
  final gmailAppUri = Uri.parse(
    'googlegmail://co?to=$_feedbackRecipient&subject=$subject&body=$body',
  );
  final gmailWebUri = Uri.parse(
    'https://mail.google.com/mail/?view=cm&fs=1&to=$_feedbackRecipient&su=$subject&body=$body',
  );

  // googlegmail:// only resolves when the Gmail app is installed (iOS Gmail
  // registers it; Android doesn't), so a false result or a thrown
  // PlatformException both just mean "fall back to the web compose page."
  bool openedGmailApp;
  try {
    openedGmailApp = await launchUrl(
      gmailAppUri,
      mode: LaunchMode.externalApplication,
    );
  } catch (_) {
    openedGmailApp = false;
  }
  if (!openedGmailApp) {
    await launchUrl(gmailWebUri, mode: LaunchMode.externalApplication);
  }
}

class BottomSectionCard extends StatelessWidget {
  const BottomSectionCard({super.key});
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: ColorManager.white,
        borderRadius: BorderRadius.circular(AppRadius.s16),
      ),
      child: InkWell(
        onTap: () => context.push(Routes.savedItems),
        borderRadius: BorderRadius.circular(AppRadius.s16),
        child: Column(
          children: [
            SizedBox(height: AppHeight.s16),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: AppWidth.s20),
              child: SectionRow(
                icon: IconAssets.feedback,
                label: 'Help & Feedback',
                onTap: () {
                  BetterFeedback.of(context).show((feedback) async {
                    try {
                      final screenshotFilePath = await writeImageToStorage(
                        feedback.screenshot,
                      );
                      final Email email = Email(
                        body: feedback.text,
                        subject: 'App Feedback',
                        recipients: ['youssifsharawy25@gmail.com'],
                        attachmentPaths: [screenshotFilePath],
                        isHTML: false,
                      );
                      await FlutterEmailSender.send(email);
                    } catch (e) {
                      debugPrint('Email not available: $e');
                      await _openGmailForFeedback(feedback.text);
                    }
                  });
                },
              ),
            ),
            SizedBox(height: AppHeight.s8),
            Divider(),
            SizedBox(height: AppHeight.s8),
            InkWell(
              onTap: () {
                UiUtils.confirmationDialog(
                  context: context,
    title: "Delete all saved data?",
    content: "This action will permanently remove all your saved terms. This cannot be undone.",
                  onConfirmed: () async {
                    // Read every cubit before the first await — reading from
                    // context after an async gap is what use_build_context_
                    // synchronously warns about.
                    final searchCubit = context.read<SearchCubit>();
                    final recentlyViewedCubit =
                        context.read<RecentlyViewedCubit>();
                    final favoritesCubit = context.read<FavoritesCubit>();

                    await searchCubit.clearRecentlySearched();
                    await recentlyViewedCubit.clearAll();
                    final cleared = await favoritesCubit.clearAllFavorites();
                    if (!context.mounted || cleared) return;
                    ToastManager.show(
                      context,
                      message:
                          "Couldn't reach the server, so your saved terms were kept. Try again when you're back online.",
                    );
                  },
                );
              },
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: AppWidth.s20),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Clear All Data",
                          style: getRegularStyle(
                            fontFamily: FontConstants.interFamily,
                            fontSize: FontSize.s15,
                            color: ColorManager.error,
                          ),
                        ),
                        Text(
                          "Remove all saved terms and history",
                          style: getRegularStyle(
                            fontFamily: FontConstants.interFamily,
                            fontSize: FontSize.s12,
                            color: ColorManager.secondaryText,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(height: AppHeight.s16),
          ],
        ),
      ),
    );
  }
}
