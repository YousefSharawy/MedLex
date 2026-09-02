
import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:medlex/app/widgets/custom_loading_indicator.dart';
import 'package:medlex/app/resources/assets_manager.dart';
import 'package:medlex/app/resources/color_manager.dart';
import 'package:medlex/app/resources/font_manager.dart';
import 'package:medlex/app/resources/style_manager.dart';
import 'package:medlex/app/resources/values_manager.dart';
import 'package:medlex/presentation/base/primary_elevated_button.dart';

class UiUtils {
  // ==================== TOAST MESSAGES ====================
  static void showMessage(String message) {
    Fluttertoast.showToast(
      msg: message,
      toastLength: Toast.LENGTH_SHORT,
      backgroundColor: ColorManager.primaryText,
      textColor: ColorManager.white,
    );
  }

  static void showErrorMessage(String message) {
    Fluttertoast.showToast(
      msg: message,
      toastLength: Toast.LENGTH_LONG,
      backgroundColor: ColorManager.error,
      textColor: ColorManager.white,
    );
  }

  static void showSuccessMessage(String message) {
    Fluttertoast.showToast(
      msg: message,
      toastLength: Toast.LENGTH_SHORT,
      backgroundColor: ColorManager.success,
      textColor: ColorManager.white,
    );
  }

  static void showInfoMessage(String message) {
    Fluttertoast.showToast(
      msg: message,
      toastLength: Toast.LENGTH_SHORT,
      backgroundColor: ColorManager.tealSoft,
      textColor: ColorManager.primaryText,
      fontSize: FontSize.s14,
    );
  }

  // ==================== LOADING DIALOG ====================

  static void showLoading(BuildContext context, {String? message}) {
    showDialog(
      context: context,
      barrierDismissible: false,
      useRootNavigator: true,
      builder:
          (_) => PopScope(
            canPop: false,
            child: Center(
              child: Container(
                padding: EdgeInsets.all(24.sp),
                decoration: BoxDecoration(
                  color: ColorManager.white,
                  borderRadius: BorderRadius.circular(AppRadius.s16),
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const CustomLoadingIndicator(),
                    SizedBox(height: AppHeight.s16),
                    Text(
                      "Loading",
                      style: getBoldStyle(
                        fontSize: FontSize.s20,
                        fontFamily: FontConstants.interFamily,
                        color: ColorManager.primaryText,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
    );
  }

  static void hideLoading(BuildContext context) {
    final navigator = Navigator.of(context, rootNavigator: true);
    if (navigator.canPop()) {
      navigator.pop();
    }
  }

  static Widget loadingWidget({double? size}) {
    return Center(
      child: SizedBox(
        width: size ?? AppWidth.s40,
        height: size ?? AppHeight.s40,
        child: const CustomLoadingIndicator(),
      ),
    );
  }

  static Widget loadingCard() {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.symmetric(vertical: AppHeight.s50),
      decoration: cardDecoration(),
      child: const Center(child: CustomLoadingIndicator()),
    );
  }

  static Widget shimmerLoading({
    required double width,
    required double height,
    double? borderRadius,
  }) {
    return Container(
      width: width,
      height: height,
      decoration: BoxDecoration(
        color: ColorManager.grey.withOpacity(0.3),
        borderRadius: BorderRadius.circular(borderRadius ?? AppRadius.s8),
      ),
    );
  }

  // ==================== ERROR WIDGETS ====================

  static Widget errorWidget({
    required String message,
    required VoidCallback onRetry,
    IconData? icon,
  }) {
    return Center(
      child: Padding(
        padding: EdgeInsets.all(16.sp),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              fit: BoxFit.contain,
              ImageAssets.issue,
              width: AppWidth.s119,
              height: AppHeight.s119,
            ),
            SizedBox(height: AppHeight.s52),
            Text(
              "Please check your internet connection\nand try again.",
              style: getRegularStyle(
                fontSize: FontSize.s12,
                fontFamily: FontConstants.interFamily,
                color: ColorManager.primaryText,
              ),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: AppHeight.s39),
            PrimaryElevatedButton(
              buttonRadius: AppRadius.s24,
              width: AppWidth.s163,
              height: AppHeight.s46,
              borderColor: ColorManager.white.withAlpha(25),
              backGroundColor: ColorManager.primaryTeal,
              title: "Retry",
              onPress: onRetry,
              textStyle: getBoldStyle(
                fontSize: FontSize.s12,
                color: ColorManager.white,
              ),
            ),
          ],
        ),
      ),
    );
  }

  static Widget errorCard({
    required String message,
    required VoidCallback onRetry,
  }) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.symmetric(
        vertical: AppHeight.s30,
        horizontal: AppWidth.s16,
      ),
      decoration: cardDecoration(),
      child: Column(
        children: [
          Image.asset(
            ImageAssets.issue,
            width: AppWidth.s60,
            height: AppHeight.s60,
          ),
          SizedBox(height: AppHeight.s5),
          Text(
            "No Internet Connection",
            style: getRegularStyle(
              fontSize: FontSize.s12,
              fontFamily: FontConstants.interFamily,
              color: ColorManager.primaryText,
            ),
            textAlign: TextAlign.center,
          ),
          SizedBox(height: AppHeight.s10),
          PrimaryElevatedButton(
            buttonRadius: AppRadius.s24,
            width: AppWidth.s163,
            height: AppHeight.s46,
            borderColor: ColorManager.white.withAlpha(25),
            backGroundColor: ColorManager.primaryTeal,
            title: "Retry",
            onPress: onRetry,
            textStyle: getBoldStyle(
              fontSize: FontSize.s12,
              color: ColorManager.white,
            ),
          ),
        ],
      ),
    );
  }

  // ==================== EMPTY STATE WIDGETS ====================

  static Widget emptyWidget({
    required String message,
    required String subMessage,
    String? actionText,
    VoidCallback? onAction,
  }) {
    return Center(
      child: Padding(
        padding: EdgeInsets.all(16.sp),
        child: Column(
          children: [
            SizedBox(height: AppHeight.s150),

            Image.asset(IconAssets.noResult),
            SizedBox(height: AppHeight.s16),
            Text(
              message,
              style: getRegularStyle(
                fontSize: FontSize.s24,
                fontFamily: FontConstants.interFamily,
                color: ColorManager.primaryText,
              ),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: AppHeight.s10),

            Text(
              subMessage,
              style: getRegularStyle(
                fontSize: FontSize.s15,
                fontFamily: FontConstants.interFamily,
                color: ColorManager.secondaryText,
              ),
              textAlign: TextAlign.center,
            ),
            if (actionText != null && onAction != null) ...[
              SizedBox(height: AppHeight.s10),
              TextButton(onPressed: onAction, child: Text(actionText)),
            ],
          ],
        ),
      ),
    );
  }

  static Widget termItemNoImagePlaceholder({double? height}) {
    return Center(
      child: SvgPicture.asset(
        IconAssets.contentsen1,
        width: AppWidth.s24,
        height: AppHeight.s24,
        fit: BoxFit.contain,
      ),
    );
  }

  static Widget dailyTermNoImagePlaceholder({double? height}) {
    return Container(
      margin: EdgeInsets.only(top: AppHeight.s27, bottom: AppHeight.s8),
      width: double.infinity,
      clipBehavior: Clip.none,
      child: Align(
        alignment: Alignment.topCenter,
        heightFactor: 0.5,
        child: Image.asset(IconAssets.frame),
      ),
    );
  }

  static Widget zoomCardNoImagePlaceholder({double? height}) {
    return Padding(
      padding: EdgeInsets.only(top: AppHeight.s27, bottom: AppHeight.s19),
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Align(
              alignment: Alignment.topCenter,
              heightFactor: 0.6,
              child: Image.asset(IconAssets.frame),
            ),
            Text(
              "This term is camera-shy 😅",
              style: getBoldStyle(
                fontFamily: FontConstants.interFamily,
                fontSize: FontSize.s12,
                color: ColorManager.primaryText,
              ),
            ),
            SizedBox(height: AppHeight.s5),
            Text(
              "A medical illustration is coming soon!",
              style: getRegularStyle(
                fontFamily: FontConstants.interFamily,
                fontSize: FontSize.s10,
                color: ColorManager.primaryText,
              ),
            ),
          ],
        ),
      ),
    );
  }

  static Widget noImagePlaceholder({double? height}) {
    return Container(
      height: height ?? AppHeight.s144,
      width: double.infinity,
      decoration: BoxDecoration(
        color: ColorManager.tealSoft.withOpacity(0.3),
        borderRadius: BorderRadius.circular(AppRadius.s12),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.now_wallpaper_outlined,
            size: 50.sp,
            color: ColorManager.graySecondaryText.withOpacity(0.5),
          ),
          SizedBox(height: AppHeight.s8),
          Text(
            'No image available',
            style: getRegularStyle(
              fontSize: FontSize.s12,
              fontFamily: FontConstants.interFamily,
              color: ColorManager.secondaryText.withOpacity(0.7),
            ),
          ),
        ],
      ),
    );
  }

  // ==================== DIALOGS ====================

  static void confirmationDialog({
    required BuildContext context,
    required String title,
    required String content,
    required VoidCallback onConfirmed,
    VoidCallback? onCancelled,
    String confirmText = 'Yes',
    String cancelText = 'No',
  }) {
    showDialog(
      barrierDismissible: false,
      context: context,
      builder: (BuildContext dialogContext) {
        return AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(AppRadius.s16),
          ),
          title: Text(
            title,
            style: getSemiBoldStyle(
              fontSize: FontSize.s18,
              fontFamily: FontConstants.interFamily,
              color: ColorManager.primaryText,
            ),
          ),
          content: Text(
            content,
            style: getRegularStyle(
              fontSize: FontSize.s14,
              fontFamily: FontConstants.interFamily,
              color: ColorManager.secondaryText,
            ),
          ),
          actions: [
            TextButton(
              child: Text(
                cancelText,
                style: getRegularStyle(
                  fontSize: FontSize.s14,
                  fontFamily: FontConstants.interFamily,
                  color: ColorManager.secondaryText,
                ),
              ),
              onPressed: () {
                Navigator.of(dialogContext).pop();
                onCancelled?.call();
              },
            ),
            TextButton(
              child: Text(
                confirmText,
                style: getSemiBoldStyle(
                  fontSize: FontSize.s14,
                  fontFamily: FontConstants.interFamily,
                  color: ColorManager.primaryTeal,
                ),
              ),
              onPressed: () {
                Navigator.of(dialogContext).pop();
                onConfirmed();
              },
            ),
          ],
        );
      },
    );
  }

  static void successDialog({
    required BuildContext context,
    required String title,
    required String message,
    VoidCallback? onDismiss,
  }) {
    showDialog(
      context: context,
      barrierDismissible: true,
      builder: (context) {
        return Dialog(
          backgroundColor: Colors.transparent,
          child: Container(
            padding: EdgeInsets.all(24.sp),
            decoration: BoxDecoration(
              color: ColorManager.white,
              borderRadius: BorderRadius.circular(AppRadius.s16),
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(
                  Icons.check_circle_outline,
                  color: ColorManager.success,
                  size: 80.sp,
                ),
                SizedBox(height: AppHeight.s16),
                Text(
                  title,
                  textAlign: TextAlign.center,
                  style: getSemiBoldStyle(
                    fontSize: FontSize.s18,
                    fontFamily: FontConstants.interFamily,
                    color: ColorManager.primaryText,
                  ),
                ),
                SizedBox(height: AppHeight.s8),
                Text(
                  message,
                  textAlign: TextAlign.center,
                  style: getRegularStyle(
                    fontSize: FontSize.s14,
                    fontFamily: FontConstants.interFamily,
                    color: ColorManager.secondaryText,
                  ),
                ),
                SizedBox(height: AppHeight.s16),
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                      onDismiss?.call();
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: ColorManager.primaryTeal,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(AppRadius.s8),
                      ),
                    ),
                    child: const Text('OK'),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  // ==================== NETWORK IMAGE (NON-CACHED) ====================

  static Widget networkImage({
    required String? imageUrl,
    required double height,
    BoxFit fit = BoxFit.contain,
    Widget? placeholder,
    Widget? errorWidget,
  }) {
    if (imageUrl == null || imageUrl.isEmpty) {
      return placeholder ?? noImagePlaceholder(height: height);
    }

    return Image.network(
      imageUrl,
      height: height,
      fit: fit,
      loadingBuilder: (context, child, loadingProgress) {
        if (loadingProgress == null) return child;
        return SizedBox(
          height: height,
          child: const Center(child: CircularProgressIndicator()),
        );
      },
      errorBuilder: (context, error, stackTrace) {
        return errorWidget ?? noImagePlaceholder(height: height);
      },
    );
  }

  // ==================== CACHED NETWORK IMAGE ====================

  static Widget cachedNetworkImage({
    required String? imageUrl,
    required double height,
    double? width,
    BoxFit fit = BoxFit.contain,
    Widget? placeholder,
    Widget? errorWidget,
    BorderRadius? borderRadius,
  }) {
    if (imageUrl == null || imageUrl.isEmpty) {
      return placeholder ?? noImagePlaceholder(height: height);
    }

    Widget imageWidget = CachedNetworkImage(
      imageUrl: imageUrl,
      height: height,
      width: width,
      fit: fit,
      placeholder:
          (context, url) => SizedBox(
            height: height,
            width: width,
            child: const Center(child: CircularProgressIndicator()),
          ),
      errorWidget:
          (context, url, error) =>
              errorWidget ?? noImagePlaceholder(height: height),
    );

    if (borderRadius != null) {
      return ClipRRect(borderRadius: borderRadius, child: imageWidget);
    }

    return imageWidget;
  }

  // ==================== DECORATIONS ====================

  static BoxDecoration cardDecoration({Color? color}) {
    return BoxDecoration(
      color: color ?? ColorManager.white,
      borderRadius: BorderRadius.circular(AppRadius.s16),
      boxShadow: [
        BoxShadow(
          color: ColorManager.black.withAlpha(63),
          blurRadius: 4,
          offset: const Offset(0, 2),
        ),
      ],
    );
  }

  // ==================== SNACKBARS ==================
}
