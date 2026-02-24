import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:transly/app/adds/ad_view_model.dart';
import 'package:transly/app/adds/cubit/ad_cubit.dart';
import 'package:transly/app/di.dart';
import 'package:transly/presentation/resources/values_manager.dart';

class BannerAdWidget extends StatelessWidget {
  const BannerAdWidget({super.key});

  @override
  Widget build(BuildContext context) {
    if (!Platform.isAndroid) return const SizedBox.shrink();

    return BlocProvider(
      create: (_) => AdCubit(getIt<AdViewModel>())..loadBanner(),
      child: BlocBuilder<AdCubit, AdState>(
        builder: (context, state) {
          return state.when(
            initial: () => const SizedBox.shrink(),
            loading:
                () => SizedBox(
                  height: AppHeight.s30,
                  child: const Center(child: CircularProgressIndicator()),
                ),
            loaded:
                (bannerAd) => SizedBox(
                  width: bannerAd.size.width.toDouble(),
                  height: bannerAd.size.height.toDouble(),
                  child: AdWidget(ad: bannerAd),
                ),
            error: (_) => const SizedBox.shrink(), // hide on error
          );
        },
      ),
    );
  }
}
