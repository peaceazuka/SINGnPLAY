import 'package:flutter/material.dart';

/// Maps the string icon keys your API returns (e.g. `"church"`) to a
/// Flutter [IconData]. JSON has no icon type, so the backend sends a
/// short key instead — add new entries here as new categories/songs need
/// icons the app doesn't already have.
const Map<String, IconData> _iconsByKey = {
  'church': Icons.church_rounded,
  'child_care': Icons.child_care_rounded,
  'auto_stories': Icons.auto_stories_rounded,
  'menu_book': Icons.menu_book_rounded,
  'star': Icons.star_rounded,
  'celebration': Icons.celebration_rounded,
  'wb_sunny': Icons.wb_sunny_rounded,
  'music_note': Icons.music_note_rounded,
  'favorite': Icons.favorite_rounded,
  'piano': Icons.piano_rounded,
  'mic': Icons.mic_rounded,
  'library_music': Icons.library_music_rounded,
};

IconData resolveIcon(String? key, {IconData fallback = Icons.music_note_rounded}) {
  if (key == null) return fallback;
  return _iconsByKey[key] ?? fallback;
}
