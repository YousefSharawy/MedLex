import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:transly/app/adds/ad_view_model.dart';

part 'ad_state.dart';
part 'ad_cubit.freezed.dart';

class AdCubit extends Cubit<AdState> {
  final AdViewModel viewModel;
  BannerAd? _bannerAd;

  AdCubit(this.viewModel) : super(const AdState.initial());

  Future<void> loadBanner() async {
    emit(const AdState.loading());
    try {
      _bannerAd = await viewModel.loadBanner();
      emit(AdState.loaded(_bannerAd!));
    } catch (e) {
      emit(AdState.error(e.toString()));
    }
  }

  @override
  Future<void> close() {
    _bannerAd?.dispose();
    return super.close();
  }
}