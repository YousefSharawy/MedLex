import 'package:flutter_tts/flutter_tts.dart';

class TtsService {
  static final TtsService _instance = TtsService._internal();
  factory TtsService() => _instance;
  TtsService._internal();

  final FlutterTts _flutterTts = FlutterTts();
  bool _isInitialized = false;

  Future<void> init() async {
    if (_isInitialized) return;

    await _flutterTts.setLanguage('en-US');
    await _flutterTts.setSpeechRate(0.4); // Slower for medical terms
    await _flutterTts.setVolume(1.0);
    await _flutterTts.setPitch(1.0);

    _isInitialized = true;
  }

  Future<void> speak(String text) async {
    await init();
    await _flutterTts.stop();
    await _flutterTts.speak(text);
  }

  Future<void> speakPronunciation(String pronunciation, String term) async {
    await init();
    await _flutterTts.stop();
    
    // Clean pronunciation text (remove slashes and special characters)
    String cleanPronunciation = pronunciation
        .replaceAll('/', '')
        .replaceAll('ˌ', '')
        .replaceAll('ˈ', '')
        .replaceAll('.', ' ')
        .trim();

    // Speak the term followed by pronunciation
    await _flutterTts.speak('$term. $cleanPronunciation');
  }

  Future<void> stop() async {
    await _flutterTts.stop();
  }

  void dispose() {
    _flutterTts.stop();
  }
}