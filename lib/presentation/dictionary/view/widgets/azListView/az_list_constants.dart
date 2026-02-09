class AzListConstants {
  AzListConstants._();

  static const allLetters = <String>[
    '#', 'A', 'B', 'C', 'D', 'E', 'F', 'G', 'H', 'I', 'J', 'K', 'L', 'M',
    'N', 'O', 'P', 'Q', 'R', 'S', 'T', 'U', 'V', 'W', 'X', 'Y', 'Z'
  ];

  static const scrollDuration = Duration(milliseconds: 300);
  static const loadDebounce = Duration(milliseconds: 300);
  static const loadThreshold = 0.85;

  static final letterRegex = RegExp(r'^[A-Z]$');
}