import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:transly/app/di.dart';
import 'package:transly/app/local_storage.dart';

import 'app/bloc_observer.dart';
import 'app/my_app.dart';
import 'presentation/resources/constants_manager.dart';
import 'translation/codegen_loader.g.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await EasyLocalization.ensureInitialized();
  await dotenv.load(fileName: '.env');
  await MobileAds.instance.initialize();

  await Supabase.initialize(
    url: "${dotenv.env['SUPABASE_URL']}",
    anonKey: "${dotenv.env['SUPABASE_ANON_KEY']}"
  );
  await LocalAppStorage.init();

  await initAppModule();

  Bloc.observer = MyBlocObserver();
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);

  await Future.delayed(const Duration(milliseconds: 500));
  runApp(
    EasyLocalization(
      supportedLocales: const [
        // ConstantsManager.arLocale,
        ConstantsManager.enLocale,
      ],
      path: 'assets/translation',
      fallbackLocale: ConstantsManager.enLocale,
      startLocale: ConstantsManager.enLocale,

      assetLoader: const CodegenLoader(),
      child: const MyApp(),
    ),
  );
}
// dart run easy_localization:generate -S "assets/translation" -O "lib/translation" 
// dart run easy_localization:generate -S "assets/translation" -O "lib/translation" -o "locale_keys.g.dart" -f keys