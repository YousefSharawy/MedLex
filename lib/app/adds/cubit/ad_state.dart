part of 'ad_cubit.dart';

@freezed
class AdState with _$AdState {
  const factory AdState.initial() = _Initial;
  const factory AdState.loading() = _Loading;
  const factory AdState.loaded(BannerAd bannerAd) = _Loaded;
  const factory AdState.error(String message) = _Error;
}