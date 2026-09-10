import 'package:flutter/material.dart';

import '../../services/icon_mapping.dart';

/// Parses a `"#RRGGBB"` / `"RRGGBB"` string from the API into a [Color].
Color colorFromHex(String hex, {Color fallback = const Color(0xFF5B3DF5)}) {
  final cleaned = hex.replaceFirst('#', '');
  if (cleaned.length != 6) return fallback;
  final value = int.tryParse('ff$cleaned', radix: 16);
  return value == null ? fallback : Color(value);
}

/// A member of the family who can be selected on the dashboard, similar to
/// profile switching in Simply Piano / Netflix-style family apps.
class FamilyProfile {
  const FamilyProfile({
    required this.id,
    required this.name,
    required this.emoji,
    required this.color,
  });

  factory FamilyProfile.fromJson(Map<String, dynamic> json) => FamilyProfile(
        id: json['id'] as String,
        name: json['name'] as String,
        emoji: json['emoji'] as String? ?? '🙂',
        color: colorFromHex(json['colorHex'] as String? ?? ''),
      );

  final String id;
  final String name;
  final String emoji;
  final Color color;
}

/// A browsable category of songs (worship, kids, hymns, etc).
class SongCategory {
  const SongCategory({
    required this.title,
    required this.icon,
    required this.color,
  });

  factory SongCategory.fromJson(Map<String, dynamic> json) => SongCategory(
        title: json['title'] as String,
        icon: resolveIcon(json['icon'] as String?),
        color: colorFromHex(json['colorHex'] as String? ?? ''),
      );

  final String title;
  final IconData icon;
  final Color color;
}

/// A single song/lesson shown in a recommendation list.
class SongItem {
  const SongItem({
    required this.title,
    required this.subtitle,
    required this.icon,
    required this.difficulty,
    required this.duration,
  });

  factory SongItem.fromJson(Map<String, dynamic> json) => SongItem(
        title: json['title'] as String,
        subtitle: json['subtitle'] as String? ?? '',
        icon: resolveIcon(json['icon'] as String?),
        difficulty: json['difficulty'] as int? ?? 1,
        duration: json['duration'] as String? ?? '',
      );

  final String title;
  final String subtitle;
  final IconData icon;
  /// 1-3 stars of difficulty.
  final int difficulty;
  final String duration;
}

/// Streak/progress numbers plus the "continue practicing" and daily
/// challenge copy shown near the top of the dashboard.
class DashboardSummary {
  const DashboardSummary({
    required this.dayStreak,
    required this.songsLearned,
    required this.minutesToday,
    required this.continueSongTitle,
    required this.continueProgress,
    required this.challengeTitle,
    required this.challengeDescription,
  });

  factory DashboardSummary.fromJson(Map<String, dynamic> json) {
    final streak = json['streak'] as Map<String, dynamic>? ?? const {};
    final continuePracticing =
        json['continuePracticing'] as Map<String, dynamic>? ?? const {};
    final challenge = json['challenge'] as Map<String, dynamic>? ?? const {};
    return DashboardSummary(
      dayStreak: streak['dayStreak'] as int? ?? 0,
      songsLearned: streak['songsLearned'] as int? ?? 0,
      minutesToday: streak['minutesToday'] as int? ?? 0,
      continueSongTitle: continuePracticing['songTitle'] as String? ?? '',
      continueProgress:
          (continuePracticing['progress'] as num?)?.toDouble() ?? 0,
      challengeTitle: challenge['title'] as String? ?? '',
      challengeDescription: challenge['description'] as String? ?? '',
    );
  }

  final int dayStreak;
  final int songsLearned;
  final int minutesToday;
  final String continueSongTitle;
  final double continueProgress;
  final String challengeTitle;
  final String challengeDescription;
}

/// Everything the dashboard screen needs for one family profile, as
/// returned by [DashboardRepository.loadDashboard].
class DashboardData {
  const DashboardData({
    required this.profiles,
    required this.categories,
    required this.recommended,
    required this.summary,
  });

  final List<FamilyProfile> profiles;
  final List<SongCategory> categories;
  final List<SongItem> recommended;
  final DashboardSummary summary;
}

/// Sample data used by `MockDashboardRepository` until a real API base URL
/// is configured (see `config/api_config.dart`).
class DashboardMockData {
  const DashboardMockData._();

  static const List<FamilyProfile> profiles = [
    FamilyProfile(id: 'mom', name: 'Mom', emoji: '👩', color: Color(0xFFFF6B9D)),
    FamilyProfile(id: 'dad', name: 'Dad', emoji: '👨', color: Color(0xFF4ECDC4)),
    FamilyProfile(id: 'noah', name: 'Noah', emoji: '🧒', color: Color(0xFFFFC857)),
    FamilyProfile(id: 'ava', name: 'Ava', emoji: '👧', color: Color(0xFF5B3DF5)),
  ];

  static const List<SongCategory> categories = [
    SongCategory(
        title: 'Worship Songs',
        icon: Icons.church_rounded,
        color: Color(0xFF5B3DF5)),
    SongCategory(
        title: 'Kids & Rhymes',
        icon: Icons.child_care_rounded,
        color: Color(0xFFFF6B9D)),
    SongCategory(
        title: 'Classic Hymns',
        icon: Icons.auto_stories_rounded,
        color: Color(0xFF4ECDC4)),
    SongCategory(
        title: 'Scripture Songs',
        icon: Icons.menu_book_rounded,
        color: Color(0xFFFFA726)),
    SongCategory(
        title: 'Christmas',
        icon: Icons.star_rounded,
        color: Color(0xFFE5525A)),
    SongCategory(
        title: 'Just for Fun',
        icon: Icons.celebration_rounded,
        color: Color(0xFFFFC857)),
  ];

  static const List<SongItem> recommended = [
    SongItem(
      title: 'This Little Light of Mine',
      subtitle: 'Kids & Rhymes',
      icon: Icons.wb_sunny_rounded,
      difficulty: 1,
      duration: '4 min',
    ),
    SongItem(
      title: 'Amazing Grace',
      subtitle: 'Classic Hymns',
      icon: Icons.music_note_rounded,
      difficulty: 2,
      duration: '6 min',
    ),
    SongItem(
      title: 'Jesus Loves Me',
      subtitle: 'Scripture Songs',
      icon: Icons.favorite_rounded,
      difficulty: 1,
      duration: '3 min',
    ),
    SongItem(
      title: 'Oh Happy Day',
      subtitle: 'Worship Songs',
      icon: Icons.piano_rounded,
      difficulty: 3,
      duration: '7 min',
    ),
  ];

  static const DashboardSummary summary = DashboardSummary(
    dayStreak: 12,
    songsLearned: 28,
    minutesToday: 15,
    continueSongTitle: 'Amazing Grace',
    continueProgress: 0.62,
    challengeTitle: "Today's Challenge",
    challengeDescription:
        "Learn 'Jesus Loves Me' in 10 minutes and earn a gold star!",
  );
}
