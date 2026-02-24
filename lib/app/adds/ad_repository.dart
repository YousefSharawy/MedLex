import 'dart:async';
import 'package:google_mobile_ads/google_mobile_ads.dart';

abstract class AdRepository {
  Future<BannerAd> loadBannerAd(String adUnitId);
}

class AdRepositoryImpl implements AdRepository {
  @override
  Future<BannerAd> loadBannerAd(String adUnitId) {
    final completer = Completer<BannerAd>();

    BannerAd(
      adUnitId: adUnitId,
      size: AdSize.banner,
      request: const AdRequest(),
      listener: BannerAdListener(
        onAdLoaded: (ad) => completer.complete(ad as BannerAd),
        onAdFailedToLoad: (ad, error) {
          ad.dispose();
          completer.completeError(error.message);
        },
      ),
    ).load();

    return completer.future;
  }
}