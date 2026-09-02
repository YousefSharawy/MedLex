
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:medlex/app/adds/viewModel/ad_view_model.dart';
import 'package:medlex/app/adds/cubit/ad_cubit.dart';
import 'package:medlex/app/di.dart';
import 'package:medlex/app/widgets/custom_loading_indicator.dart';
import 'package:medlex/app/resources/values_manager.dart';

class BannerAdWidget extends StatelessWidget {
  const BannerAdWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => AdCubit(getIt<AdViewModel>())..loadBanner(),
      child: BlocBuilder<AdCubit, AdState>(
        builder: (context, state) {
          return state.when(
            initial: () => const SizedBox.shrink(),
            loading: () => SizedBox(
              height: AppHeight.s50,
              child: const Center(child: CustomLoadingIndicator()),
            ),
            loaded: (bannerAd) => SizedBox(
              width: bannerAd.size.width.toDouble(),
              height: bannerAd.size.height.toDouble(),
              child: AdWidget(ad: bannerAd),
            ),
            error: (_) => const SizedBox.shrink(),
          );
        },
      ),
    );
  }
}