import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:medlex/app/adds/viewModel/ad_repository.dart';

class AdViewModel {
  final AdRepository repository;

  AdViewModel(this.repository);

  String get bannerAdUnitId {
    if (kDebugMode) {
      return Platform.isAndroid
          ? 'ca-app-pub-3940256099942544/6300978111' 
          : 'ca-app-pub-3940256099942544/2934735716'; 
    }
    return Platform.isAndroid
        ? dotenv.env['ADMOB_ANDROID_BANNER_ID']!
        : dotenv.env['ADMOB_IOS_BANNER_ID']!;
  }

  Future<BannerAd> loadBanner() {
    return repository.loadBannerAd(bannerAdUnitId);
  }
}