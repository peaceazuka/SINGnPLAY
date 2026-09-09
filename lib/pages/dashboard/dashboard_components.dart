import 'package:flutter/material.dart';

import '../../flutter_flow/flutter_flow_theme.dart';
import 'dashboard_model.dart';

/// Small circular avatar used in the family-profile switcher row.
class ProfileAvatar extends StatelessWidget {
  const ProfileAvatar({
    super.key,
    required this.profile,
    required this.selected,
    required this.onTap,
  });

  final FamilyProfile profile;
  final bool selected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final theme = FlutterFlowTheme.of(context);
    return GestureDetector(
      onTap: onTap,
      behavior: HitTestBehavior.opaque,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          AnimatedContainer(
            duration: const Duration(milliseconds: 200),
            width: 56,
            height: 56,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: profile.color.withOpacity(selected ? 1 : 0.55),
              border: selected
                  ? Border.all(color: theme.primaryBackground, width: 3)
                  : null,
              boxShadow: selected
                  ? [
                      BoxShadow(
                        color: profile.color.withOpacity(0.45),
                        blurRadius: 12,
                        offset: const Offset(0, 6),
                      ),
                    ]
                  : null,
            ),
            alignment: Alignment.center,
            child: Text(profile.emoji, style: const TextStyle(fontSize: 24)),
          ),
          const SizedBox(height: 6),
          Text(
            profile.name,
            style: selected
                ? theme.labelSmall.copyWith(color: theme.primaryText)
                : theme.labelSmall,
          ),
        ],
      ),
    );
  }
}

/// A single stat pill (streak, songs learned, minutes practiced today).
class StatTile extends StatelessWidget {
  const StatTile({
    super.key,
    required this.icon,
    required this.value,
    required this.label,
    required this.color,
  });

  final IconData icon;
  final String value;
  final String label;
  final Color color;

  @override
  Widget build(BuildContext context) {
    final theme = FlutterFlowTheme.of(context);
    return Expanded(
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 14),
        decoration: BoxDecoration(
          color: theme.secondaryBackground,
          borderRadius: BorderRadius.circular(18),
          boxShadow: [
            BoxShadow(
              color: theme.primaryText.withOpacity(0.05),
              blurRadius: 10,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Column(
          children: [
            Icon(icon, color: color, size: 22),
            const SizedBox(height: 6),
            Text(value, style: theme.headlineSmall),
            const SizedBox(height: 2),
            Text(label, style: theme.labelSmall, textAlign: TextAlign.center),
          ],
        ),
      ),
    );
  }
}

/// Rounded, colored category card used in the "Explore" grid.
class CategoryCard extends StatelessWidget {
  const CategoryCard({super.key, required this.category, required this.onTap});

  final SongCategory category;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final theme = FlutterFlowTheme.of(context);
    return GestureDetector(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          color: category.color.withOpacity(0.12),
          borderRadius: BorderRadius.circular(18),
        ),
        padding: const EdgeInsets.all(14),
        child: Row(
          children: [
            Container(
              width: 40,
              height: 40,
              decoration: BoxDecoration(
                color: category.color,
                borderRadius: BorderRadius.circular(12),
              ),
              alignment: Alignment.center,
              child: Icon(category.icon, color: Colors.white, size: 20),
            ),
            const SizedBox(width: 10),
            Expanded(
              child: Text(
                category.title,
                style: theme.titleMedium,
                maxLines: 2,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

/// Horizontal card for a recommended song / lesson.
class SongCard extends StatelessWidget {
  const SongCard({super.key, required this.song, required this.onTap});

  final SongItem song;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final theme = FlutterFlowTheme.of(context);
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 168,
        padding: const EdgeInsets.all(14),
        decoration: BoxDecoration(
          color: theme.secondaryBackground,
          borderRadius: BorderRadius.circular(20),
          boxShadow: [
            BoxShadow(
              color: theme.primaryText.withOpacity(0.06),
              blurRadius: 12,
              offset: const Offset(0, 6),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: 44,
              height: 44,
              decoration: BoxDecoration(
                color: theme.alternate,
                borderRadius: BorderRadius.circular(12),
              ),
              alignment: Alignment.center,
              child: Icon(song.icon, color: theme.primary, size: 22),
            ),
            const SizedBox(height: 10),
            Text(
              song.title,
              style: theme.titleMedium,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            ),
            const SizedBox(height: 4),
            Text(song.subtitle, style: theme.bodySmall),
            const Spacer(),
            Row(
              children: [
                Row(
                  children: List.generate(
                    3,
                    (i) => Icon(
                      Icons.star_rounded,
                      size: 14,
                      color: i < song.difficulty
                          ? theme.tertiary
                          : theme.alternate,
                    ),
                  ),
                ),
                const Spacer(),
                Text(song.duration, style: theme.labelSmall),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

/// Bottom navigation bar item metadata + the bar itself.
class DashboardBottomNavBar extends StatelessWidget {
  const DashboardBottomNavBar({
    super.key,
    required this.currentIndex,
    required this.onTap,
  });

  final int currentIndex;
  final ValueChanged<int> onTap;

  static const _items = [
    (icon: Icons.home_rounded, label: 'Home'),
    (icon: Icons.school_rounded, label: 'Learn'),
    (icon: Icons.mic_rounded, label: 'Practice'),
    (icon: Icons.library_music_rounded, label: 'Library'),
    (icon: Icons.person_rounded, label: 'Profile'),
  ];

  @override
  Widget build(BuildContext context) {
    final theme = FlutterFlowTheme.of(context);
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 10),
      decoration: BoxDecoration(
        color: theme.secondaryBackground,
        boxShadow: [
          BoxShadow(
            color: theme.primaryText.withOpacity(0.08),
            blurRadius: 16,
            offset: const Offset(0, -4),
          ),
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: List.generate(_items.length, (index) {
          final item = _items[index];
          final selected = index == currentIndex;
          final color = selected ? theme.primary : theme.secondaryText;
          return GestureDetector(
            behavior: HitTestBehavior.opaque,
            onTap: () => onTap(index),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(item.icon, color: color, size: 24),
                const SizedBox(height: 2),
                Text(
                  item.label,
                  style: theme.labelSmall.copyWith(
                    color: color,
                    fontWeight: selected ? FontWeight.w800 : FontWeight.w600,
                  ),
                ),
              ],
            ),
          );
        }),
      ),
    );
  }
}
