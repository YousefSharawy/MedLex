import 'package:flutter_dotenv/flutter_dotenv.dart';

/// Static utility for generating Cloudinary image URLs.
/// Cloud name comes from .env key `CLOUDINARY_CLOUD_NAME`.
class CloudinaryHelper {
  CloudinaryHelper._();

  static String get _cloudName =>
      dotenv.env['CLOUDINARY_CLOUD_NAME'] ?? 'medlex';

  static String _url(String publicId, String transform) =>
      'https://res.cloudinary.com/$_cloudName/image/upload/$transform/$publicId';

  /// 120px wide thumbnail — for list rows.
  static String termThumb(String publicId) =>
      _url(publicId, 'w_120,f_auto,q_auto');

  /// 800px wide hero — for term detail screen.
  static String termHero(String publicId) =>
      _url(publicId, 'w_800,f_auto,q_auto');

  /// 600px wide — for clinical case header image.
  static String caseImage(String publicId) =>
      _url(publicId, 'w_600,f_auto,q_auto');
}
