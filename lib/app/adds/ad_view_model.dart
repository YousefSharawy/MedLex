import 'package:flutter/foundation.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:transly/app/adds/ad_repository.dart';

class AdViewModel {
  final AdRepository repository;

  AdViewModel(this.repository);

  String get bannerAdUnitId {
    if (kDebugMode) {
      return 'ca-app-pub-3940256099942544/6300978111';
    }
    // Production — reads from .env
    return dotenv.env['ADMOB_ANDROID_BANNER_ID']!;
  }

  Future<BannerAd> loadBanner() {
    return repository.loadBannerAd(bannerAdUnitId);
  }
}