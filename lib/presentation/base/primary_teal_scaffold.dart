import 'package:flutter/material.dart';
import 'package:medlex/app/resources/color_manager.dart';

class PrimaryTealScaffold extends StatefulWidget {
  const PrimaryTealScaffold({
    super.key,
    required this.body,
    this.appBar,
    this.showBannerAd = false,
    this.drawer,
    this.backgroundColor,
  });
  final Widget body;
  final AppBar? appBar;
  final bool showBannerAd;
  final Drawer? drawer;
  final Color? backgroundColor;
  @override
  State<PrimaryTealScaffold> createState() => _PrimaryTealScaffoldState();
}

class _PrimaryTealScaffoldState extends State<PrimaryTealScaffold> {
  // BannerAd? _bannerAd;
  // bool _isLoadingAd = false;
  // String? _adLoadError;

  void _loadAd() async {
    // if (_isLoadingAd) return;

    // _isLoadingAd = true;
    // setState(() {});

    // try {
    //   final size =
    //       await AdSize.getCurrentOrientationAnchoredAdaptiveBannerAdSize(
    //         MediaQuery.sizeOf(context).width.truncate(),
    //       );

    //   if (size == null) {
    //     debugPrint("Unable to get width of anchored banner.");
    //     _isLoadingAd = false;
    //     setState(() {});
    //     return;
    //   }

    //   final ad = BannerAd(
    //     adUnitId: AppAdsHelper.bannerAdUnitId,
    //     request: const AdRequest(),
    //     size: size,
    //     listener: BannerAdListener(
    //       onAdLoaded: (ad) {
    //         debugPrint("Banner ad loaded successfully.");
    //         _isLoadingAd = false;
    //         _adLoadError = null;
    //         setState(() {
    //           _bannerAd = ad as BannerAd;
    //         });
    //       },
    //       onAdFailedToLoad: (ad, error) {
    //         debugPrint("Banner ad failed to load: $error");
    //         _isLoadingAd = false;
    //         _adLoadError = error.message;
    //         ad.dispose();
    //         setState(() {});
    //       },
    //       onAdImpression: (ad) {
    //         debugPrint("Banner ad impression recorded.");
    //       },
    //     ),
    //   );

    //   await ad.load();
    // } catch (e) {
    //   debugPrint("Error loading banner ad: $e");
    //   _isLoadingAd = false;
    //   _adLoadError = e.toString();
    //   setState(() {});
    // }
  }

  @override
  void initState() {
    super.initState();
    if (widget.showBannerAd) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        _loadAd();
      });
    }
  }

  @override
  void dispose() {
    // _bannerAd?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: widget.appBar,
      drawer: widget.drawer,
      backgroundColor: widget.backgroundColor ?? ColorManager.background,
      // The one screen with a text field (the home search bar) sits near the
      // top and its results scroll independently, so nothing needs the
      // keyboard-avoidance resize. Left on, it forces a full-body relayout on
      // every frame of the keyboard's slide-in animation — directly competing
      // with this screen's own transition animations for the frame budget.
      resizeToAvoidBottomInset: false,
      body: widget.body,
      bottomNavigationBar: _buildBottomAdContainer(),
    );
  }

  Widget _buildBottomAdContainer() {
    // if (_isLoadingAd) {
    //   return Container(
    //     height: AdSize.banner.height.toDouble(),
    //     color: Colors.transparent,
    //     child: const Center(
    //       child: SizedBox(
    //         width: 20,
    //         height: 20,
    //         child: CircularProgressIndicator(strokeWidth: 2),
    //       ),
    //     ),
    //   );
    // }

    // if (_bannerAd != null) {
    //   return Container(
    //     height: _bannerAd!.size.height.toDouble(),
    //     width: double.infinity,
    //     alignment: Alignment.center,
    //     child: AdWidget(ad: _bannerAd!),
    //   );
    // }

    // if (_adLoadError != null) {
    //   return Container(
    //     height: AdSize.banner.height.toDouble(),
    //     color: Colors.transparent,
    //     child: Center(
    //       child: Text(
    //         'Ad failed to load',
    //         style: TextStyle(fontSize: 12, color: Colors.grey[600]),
    //       ),
    //     ),
    //   );
    // }

    return const SizedBox.shrink();
  }
}
