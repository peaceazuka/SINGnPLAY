import 'package:flutter/material.dart';

import '../../flutter_flow/flutter_flow_theme.dart';
import 'dashboard_components.dart';
import 'dashboard_model.dart';

/// The SINGnPLAY WorshipTime home dashboard.
///
/// Mirrors the layout a Simply-Piano-style learning app uses for its home
/// tab: a family profile switcher, a "continue where you left off" hero
/// card, quick progress stats, browsable song categories, a daily
/// challenge banner, and a recommended-songs rail — all on top of a
/// bottom tab bar.
class DashboardWidget extends StatefulWidget {
  const DashboardWidget({super.key});

  static const String routeName = 'Dashboard';
  static const String routePath = '/dashboard';

  @override
  State<DashboardWidget> createState() => _DashboardWidgetState();
}

class _DashboardWidgetState extends State<DashboardWidget> {
  final DashboardModel _model = DashboardModel();

  int _selectedProfileIndex = 2; // Defaults to the first child profile.
  int _selectedNavIndex = 0;

  @override
  Widget build(BuildContext context) {
    final theme = FlutterFlowTheme.of(context);
    final activeProfile = _model.familyProfiles[_selectedProfileIndex];

    return Scaffold(
      backgroundColor: theme.primaryBackground,
      body: SafeArea(
        child: CustomScrollView(
          slivers: [
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.fromLTRB(20, 16, 20, 0),
                child: _buildHeader(theme, activeProfile),
              ),
            ),
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.fromLTRB(20, 20, 20, 0),
                child: _buildFamilySwitcher(theme),
              ),
            ),
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.fromLTRB(20, 20, 20, 0),
                child: _buildContinuePracticingCard(theme, activeProfile),
              ),
            ),
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.fromLTRB(20, 16, 20, 0),
                child: _buildStatsRow(theme),
              ),
            ),
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.fromLTRB(20, 24, 20, 0),
                child: _buildSectionHeader(theme, 'Explore', onSeeAll: () {}),
              ),
            ),
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.fromLTRB(20, 12, 20, 0),
                child: _buildCategoryGrid(theme),
              ),
            ),
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.fromLTRB(20, 24, 20, 0),
                child: _buildChallengeBanner(theme),
              ),
            ),
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.fromLTRB(20, 24, 20, 0),
                child: _buildSectionHeader(
                  theme,
                  'Recommended for you',
                  onSeeAll: () {},
                ),
              ),
            ),
            SliverToBoxAdapter(
              child: SizedBox(
                height: 190,
                child: ListView.separated(
                  padding: const EdgeInsets.fromLTRB(20, 12, 20, 0),
                  scrollDirection: Axis.horizontal,
                  itemCount: _model.recommended.length,
                  separatorBuilder: (_, __) => const SizedBox(width: 14),
                  itemBuilder: (context, index) => SongCard(
                    song: _model.recommended[index],
                    onTap: () {},
                  ),
                ),
              ),
            ),
            const SliverToBoxAdapter(child: SizedBox(height: 24)),
          ],
        ),
      ),
      bottomNavigationBar: DashboardBottomNavBar(
        currentIndex: _selectedNavIndex,
        onTap: (index) => setState(() => _selectedNavIndex = index),
      ),
    );
  }

  Widget _buildHeader(FlutterFlowTheme theme, FamilyProfile activeProfile) {
    return Row(
      children: [
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Good morning,', style: theme.bodyMedium),
              Text('${activeProfile.name}! 👋', style: theme.displaySmall),
            ],
          ),
        ),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
          decoration: BoxDecoration(
            color: theme.tertiary.withOpacity(0.18),
            borderRadius: BorderRadius.circular(20),
          ),
          child: Row(
            children: [
              const Text('🔥', style: TextStyle(fontSize: 16)),
              const SizedBox(width: 4),
              Text(
                '${_model.dayStreak}',
                style: theme.titleMedium.copyWith(color: theme.warning),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildFamilySwitcher(FlutterFlowTheme theme) {
    return SizedBox(
      height: 88,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        itemCount: _model.familyProfiles.length,
        separatorBuilder: (_, __) => const SizedBox(width: 16),
        itemBuilder: (context, index) {
          final profile = _model.familyProfiles[index];
          return ProfileAvatar(
            profile: profile,
            selected: index == _selectedProfileIndex,
            onTap: () => setState(() => _selectedProfileIndex = index),
          );
        },
      ),
    );
  }

  Widget _buildContinuePracticingCard(
    FlutterFlowTheme theme,
    FamilyProfile activeProfile,
  ) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [theme.primary, activeProfile.color],
        ),
        borderRadius: BorderRadius.circular(24),
        boxShadow: [
          BoxShadow(
            color: theme.primary.withOpacity(0.35),
            blurRadius: 20,
            offset: const Offset(0, 10),
          ),
        ],
      ),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'CONTINUE PRACTICING',
                  style: theme.labelSmall.copyWith(
                    color: Colors.white.withOpacity(0.8),
                    letterSpacing: 1.1,
                  ),
                ),
                const SizedBox(height: 6),
                Text(
                  _model.continueSongTitle,
                  style: theme.headlineSmall.copyWith(color: Colors.white),
                ),
                const SizedBox(height: 14),
                ClipRRect(
                  borderRadius: BorderRadius.circular(8),
                  child: LinearProgressIndicator(
                    value: _model.continueProgress,
                    minHeight: 8,
                    backgroundColor: Colors.white.withOpacity(0.25),
                    valueColor:
                        AlwaysStoppedAnimation<Color>(theme.tertiary),
                  ),
                ),
                const SizedBox(height: 14),
                ElevatedButton(
                  onPressed: () {},
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.white,
                    foregroundColor: theme.primary,
                    padding: const EdgeInsets.symmetric(
                      horizontal: 20,
                      vertical: 10,
                    ),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30),
                    ),
                    elevation: 0,
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        'Resume',
                        style: theme.titleMedium.copyWith(color: theme.primary),
                      ),
                      const SizedBox(width: 4),
                      Icon(Icons.play_arrow_rounded, color: theme.primary),
                    ],
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(width: 12),
          Container(
            width: 64,
            height: 64,
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.2),
              shape: BoxShape.circle,
            ),
            alignment: Alignment.center,
            child: const Icon(
              Icons.music_note_rounded,
              color: Colors.white,
              size: 32,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildStatsRow(FlutterFlowTheme theme) {
    return Row(
      children: [
        StatTile(
          icon: Icons.local_fire_department_rounded,
          value: '${_model.dayStreak}',
          label: 'Day streak',
          color: theme.warning,
        ),
        const SizedBox(width: 12),
        StatTile(
          icon: Icons.library_music_rounded,
          value: '${_model.songsLearned}',
          label: 'Songs learned',
          color: theme.accent1,
        ),
        const SizedBox(width: 12),
        StatTile(
          icon: Icons.timer_rounded,
          value: '${_model.minutesToday}m',
          label: 'Today',
          color: theme.secondary,
        ),
      ],
    );
  }

  Widget _buildSectionHeader(
    FlutterFlowTheme theme,
    String title, {
    required VoidCallback onSeeAll,
  }) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(title, style: theme.headlineSmall),
        GestureDetector(
          onTap: onSeeAll,
          child: Text(
            'See all',
            style: theme.bodyMedium.copyWith(color: theme.primary),
          ),
        ),
      ],
    );
  }

  Widget _buildCategoryGrid(FlutterFlowTheme theme) {
    return GridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: _model.categories.length,
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        mainAxisSpacing: 12,
        crossAxisSpacing: 12,
        childAspectRatio: 2.6,
      ),
      itemBuilder: (context, index) => CategoryCard(
        category: _model.categories[index],
        onTap: () {},
      ),
    );
  }

  Widget _buildChallengeBanner(FlutterFlowTheme theme) {
    return Container(
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: theme.tertiary.withOpacity(0.16),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: theme.tertiary.withOpacity(0.4)),
      ),
      child: Row(
        children: [
          Container(
            width: 44,
            height: 44,
            decoration: BoxDecoration(
              color: theme.tertiary,
              shape: BoxShape.circle,
            ),
            alignment: Alignment.center,
            child: const Icon(Icons.emoji_events_rounded,
                color: Colors.white, size: 24),
          ),
          const SizedBox(width: 14),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(_model.challengeTitle, style: theme.titleLarge),
                const SizedBox(height: 2),
                Text(_model.challengeDescription, style: theme.bodyMedium),
              ],
            ),
          ),
          Icon(Icons.chevron_right_rounded, color: theme.secondaryText),
        ],
      ),
    );
  }
}
