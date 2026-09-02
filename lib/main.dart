import 'package:easy_localization/easy_localization.dart';
import 'package:feedback/feedback.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:medlex/app/di.dart';
import 'package:medlex/app/local_storage.dart';
import 'package:medlex/app/resources/color_manager.dart';
import 'package:medlex/app/resources/font_manager.dart';
import 'package:medlex/app/resources/style_manager.dart';

import 'app/bloc_observer.dart';
import 'app/my_app.dart';
import 'app/notification_service.dart';
import 'app/resources/constants_manager.dart';
import 'translation/codegen_loader.g.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await EasyLocalization.ensureInitialized();
  await dotenv.load(fileName: '.env');
  await MobileAds.instance.initialize();

  await Supabase.initialize(
    url: "${dotenv.env['SUPABASE_URL']}",
    anonKey: "${dotenv.env['SUPABASE_ANON_KEY']}",
  );
  await LocalAppStorage.init();

  await initAppModule();
  try {
    await NotificationService.init();
  } catch (e) {
    debugPrint('Notification init failed: $e');
  }

  Bloc.observer = MyBlocObserver();
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);

  await Future.delayed(const Duration(milliseconds: 500));
  runApp(
    EasyLocalization(
      supportedLocales: const [
        ConstantsManager.arLocale,
        ConstantsManager.enLocale,
      ],
      path: 'assets/translation',
      fallbackLocale: ConstantsManager.enLocale,
      startLocale: ConstantsManager.enLocale,

      assetLoader: const CodegenLoader(),
      child: BetterFeedback(
        localizationsDelegates: [CustomFeedbackLocalizationsDelegate()],
        theme: FeedbackThemeData(
          background: ColorManager.warmLightGray,
          feedbackSheetColor: ColorManager.white,
          drawColors: [ColorManager.primaryTeal],
          activeFeedbackModeColor: ColorManager.primaryTeal,

          bottomSheetDescriptionStyle: getBoldStyle(
            color: ColorManager.primaryText,
            fontSize: 16,
            fontFamily: FontConstants.interFamily,
          ),
          bottomSheetTextInputStyle: getBoldStyle(
            color: ColorManager.primaryTeal,
            fontSize: 15,
            fontFamily: FontConstants.interFamily,
          ),
          colorScheme: ColorScheme.fromSeed(seedColor: ColorManager.primaryTeal),
        ),

        localeOverride: Locale('en'),
        child: const MyApp(),
      ),
    ),
  );
}

class CustomFeedbackLocalizations extends FeedbackLocalizations {
  @override
  String get submitButtonText => 'Send Feedback';

  @override
  String get feedbackDescriptionText =>
      'Share your thoughts or report a bug 💬';

  @override
  String get draw => 'Annotate';

  @override
  String get navigate => 'Navigate';
}
class CustomFeedbackLocalizationsDelegate
    extends LocalizationsDelegate<FeedbackLocalizations> {
  @override
  bool isSupported(Locale locale) => true;

  @override
  Future<FeedbackLocalizations> load(Locale locale) async =>
      CustomFeedbackLocalizations();

  @override
  bool shouldReload(covariant LocalizationsDelegate old) => false;
}
// dart run easy_localization:generate -S "assets/translation" -O "lib/translation" 
// dart run easy_localization:generate -S "assets/translation" -O "lib/translation" -o "locale_keys.g.dart" -f keys