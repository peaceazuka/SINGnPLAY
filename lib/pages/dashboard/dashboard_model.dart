import 'package:flutter/material.dart';

/// A member of the family who can be selected on the dashboard, similar to
/// profile switching in Simply Piano / Netflix-style family apps.
class FamilyProfile {
  const FamilyProfile({
    required this.name,
    required this.emoji,
    required this.color,
  });

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

  final String title;
  final String subtitle;
  final IconData icon;
  /// 1-3 stars of difficulty.
  final int difficulty;
  final String duration;
}

/// Holds the mock data and small pieces of derived state the Dashboard
/// screen needs. In a full FlutterFlow export this would be the generated
/// `DashboardModel`, wired up to backend queries instead of static data.
class DashboardModel {
  final List<FamilyProfile> familyProfiles = const [
    FamilyProfile(name: 'Mom', emoji: '👩', color: Color(0xFFFF6B9D)),
    FamilyProfile(name: 'Dad', emoji: '👨', color: Color(0xFF4ECDC4)),
    FamilyProfile(name: 'Noah', emoji: '🧒', color: Color(0xFFFFC857)),
    FamilyProfile(name: 'Ava', emoji: '👧', color: Color(0xFF5B3DF5)),
  ];

  final List<SongCategory> categories = const [
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

  final List<SongItem> recommended = const [
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

  // Current progress snapshot for the "Continue Practicing" hero card.
  final String continueSongTitle = 'Amazing Grace';
  final double continueProgress = 0.62;

  // Streak / stats shown near the top of the dashboard.
  final int dayStreak = 12;
  final int songsLearned = 28;
  final int minutesToday = 15;

  // Daily challenge banner copy.
  final String challengeTitle = "Today's Challenge";
  final String challengeDescription =
      "Learn 'Jesus Loves Me' in 10 minutes and earn a gold star!";
}
