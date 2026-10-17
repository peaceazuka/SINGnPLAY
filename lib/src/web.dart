import 'dart:js_interop';
import 'dart:js_interop_unsafe';

import 'package:web/web.dart' as web;

/// One sounding note: its source and the gain that fades it.
class _Voice {
  _Voice(this.source, this.gain);
  final web.AudioBufferSourceNode source;
  final web.GainNode gain;
}

/// The browser's piano: one AudioContext, decoded buffers, a gain per note.
class SnpWebAudio {
  SnpWebAudio._();

  static web.AudioContext? _ctx;
  static final Map<int, web.AudioBuffer> _buffers = <int, web.AudioBuffer>{};
  static final Map<int, _Voice> _voices = <int, _Voice>{};
  static bool _unlockArmed = false;

  /// The damper, matched to the tablet: a released note falls 40 dB in
  /// 260 ms. As an exponential approach, that is a time constant of
  /// 260 / ln(100) ≈ 56 ms.
  static const double _releaseTimeConstant = 0.0565;

  /// A note struck again while still sounding is cut this fast first.
  static const double _restrikeTimeConstant = 0.008;

  static bool get supported {
    try {
      return web.window.has('AudioContext') ||
          web.window.has('webkitAudioContext');
    } catch (_) {
      return false;
    }
  }

  static web.AudioContext get _context {
    final existing = _ctx;
    if (existing != null) return existing;
    // iPhone: Web Audio follows the ring/silent switch unless the page asks
    // to be "playback" (Safari 16.4+). Ask, so the piano is heard like media.
    try {
      final session = web.window.navigator.getProperty<JSObject?>('audioSession'.toJS);
      session?.setProperty('type'.toJS, 'playback'.toJS);
    } catch (_) {/* older browsers: nothing to set */}
    final ctx = web.AudioContext();
    _ctx = ctx;
    _armUnlock();
    return ctx;
  }

  /// Browsers start a context suspended until the person touches the page.
  /// Resume it on the first touch, click or key (and on later ones, cheaply,
  /// in case the phone suspended it in the background).
  static void _armUnlock() {
    if (_unlockArmed) return;
    _unlockArmed = true;
    void resume(web.Event _) {
      final ctx = _ctx;
      if (ctx != null && ctx.state != 'running') {
        ctx.resume();
      }
    }
    final listener = resume.toJS;
    for (final type in const ['pointerdown', 'touchstart', 'touchend', 'keydown', 'click']) {
      web.document.addEventListener(type, listener);
    }
  }

  static bool has(int id) => _buffers.containsKey(id);

  static Future<bool> load(int id, String url) async {
    if (_buffers.containsKey(id)) return true;
    try {
      final ctx = _context;
      final response = await web.window.fetch(url.toJS).toDart;
      if (!response.ok) return false;
      final bytes = await response.arrayBuffer().toDart;
      final buffer = await ctx.decodeAudioData(bytes).toDart;
      _buffers[id] = buffer;
      return true;
    } catch (_) {
      return false;
    }
  }

  static void play(int id, double gain) {
    final buffer = _buffers[id];
    if (buffer == null) return;
    final ctx = _context;
    if (ctx.state != 'running') ctx.resume();
    final now = ctx.currentTime;
    // Struck again while sounding: cut the old one quickly (no click).
    final old = _voices.remove(id);
    if (old != null) _fadeAndStop(old, now, _restrikeTimeConstant);
    final source = ctx.createBufferSource();
    source.buffer = buffer;
    final g = ctx.createGain();
    g.gain.value = gain.clamp(0.0, 1.0);
    source.connect(g);
    g.connect(ctx.destination);
    source.start();
    final voice = _Voice(source, g);
    _voices[id] = voice;
    source.onended = ((web.Event _) {
      if (identical(_voices[id], voice)) _voices.remove(id);
      try {
        g.disconnect();
      } catch (_) {}
    }).toJS;
  }

  static void release(int id) {
    final voice = _voices.remove(id);
    final ctx = _ctx;
    if (voice == null || ctx == null) return;
    _fadeAndStop(voice, ctx.currentTime, _releaseTimeConstant);
  }

  static void _fadeAndStop(_Voice v, double now, double timeConstant) {
    try {
      final p = v.gain.gain;
      p.cancelScheduledValues(now);
      p.setValueAtTime(p.value, now);
      p.setTargetAtTime(0.0, now, timeConstant);
      // Silent (below -60 dB) after about 7 time constants.
      v.source.stop(now + timeConstant * 7 + 0.02);
    } catch (_) {/* already stopped */}
  }

  static Future<void> dispose() async {
    for (final id in _voices.keys.toList()) {
      release(id);
    }
    _buffers.clear();
  }
}
