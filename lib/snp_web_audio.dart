/// WorshipTime's piano sound in the browser.
///
/// One Web Audio context for the whole app; each key's recording is fetched
/// and decoded once, then played as a buffer through its own gain (so a
/// release can fade it like a damper). On Android and iOS apps this is a
/// stub: [SnpWebAudio.supported] is false and nothing plays.
///
/// Why not one HTML <audio> element per key: in iPhone Safari, dozens of
/// media elements each routed through their own AudioContext make the sound
/// double and lag (an echo). Buffers in one context do not.
library;

export 'src/stub.dart' if (dart.library.js_interop) 'src/web.dart';
