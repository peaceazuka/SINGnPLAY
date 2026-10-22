/// Not a browser: no Web Audio. Every call does nothing.
class SnpWebAudio {
  SnpWebAudio._();

  /// False here: the caller keeps its own sound engine.
  static bool get supported => false;

  /// Whether a sound is loaded for [id].
  static bool has(int id) => false;

  /// Fetches and decodes [url] as the sound for [id]. False here.
  static Future<bool> load(int id, String url) async => false;

  /// Plays the sound for [id] at [gain] (0-1).
  static void play(int id, double gain) {}

  /// Fades the sound for [id] out like a piano damper, then stops it.
  static void release(int id) {}

  /// Stops everything and frees the decoded sounds.
  static Future<void> dispose() async {}
}

/// Not a browser: no share menu here (the app copies the link instead).
class SnpShare {
  SnpShare._();

  /// "unsupported" here.
  static Future<String> share(String text, {String title = ''}) async =>
      'unsupported';
}
