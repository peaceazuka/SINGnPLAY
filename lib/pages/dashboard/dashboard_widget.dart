import 'package:flutter/material.dart';

import '../../flutter_flow/flutter_flow_theme.dart';
import '../../services/dashboard_repository.dart';
import 'dashboard_components.dart';
import 'dashboard_model.dart';

/// The SINGnPLAY WorshipTime home dashboard.
///
/// Mirrors the layout a Simply-Piano-style learning app uses for its home
/// tab: a family profile switcher, a "continue where you left off" hero
/// card, quick progress stats, browsable song categories, a daily
/// challenge banner, and a recommended-songs rail — all on top of a
/// bottom tab bar.
///
/// Data comes from [repository], which is either sample data
/// (`MockDashboardRepository`) or your live backend (`ApiDashboardRepository`)
/// depending on whether `ApiConfig.isConfigured` — see `main.dart`.
class DashboardWidget extends StatefulWidget {
  const DashboardWidget({super.key, required this.repository});

  final DashboardRepository repository;

  static const String routeName = 'Dashboard';
  static const String routePath = '/dashboard';

  @override
  State<DashboardWidget> createState() => _DashboardWidgetState();
}

class _DashboardWidgetState extends State<DashboardWidget> {
  DashboardData? _data;
  Object? _error;
  bool _initialLoading = true;
  bool _refreshing = false;
  String _activeProfileId = '';
  int _selectedNavIndex = 0;

  @override
  void initState() {
    super.initState();
    _loadInitial();
  }

  Future<void> _loadInitial() async {
    try {
      final data = await widget.repository.loadDashboard(profileId: '');
      if (!mounted) return;
      setState(() {
        _data = data;
        _activeProfileId = data.profiles.isNotEmpty ? data.profiles.first.id : '';
        _initialLoading = false;
      });
    } catch (e) {
      if (!mounted) return;
      setState(() {
        _error = e;
        _initialLoading = false;
      });
    }
  }

  Future<void> _switchProfile(String profileId) async {
    setState(() {
      _activeProfileId = profileId;
      _refreshing = true;
      _error = null;
    });
    try {
      final data = await widget.repository.loadDashboard(profileId: profileId);
      if (!mounted) return;
      setState(() {
        _data = data;
        _refreshing = false;
      });
    } catch (e) {
      if (!mounted) return;
      setState(() {
        _error = e;
        _refreshing = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = FlutterFlowTheme.of(context);

    if (_initialLoading) {
      return Scaffold(
        backgroundColor: theme.primaryBackground,
        body: Center(
          child: CircularProgressIndicator(color: theme.primary),
        ),
      );
    }

    if (_data == null) {
      return Scaffold(
        backgroundColor: theme.primaryBackground,
        body: _buildError(theme, _error, onRetry: _loadInitial),
      );
    }

    final data = _data!;
    final activeProfile = data.profiles.firstWhere(
      (p) => p.id == _activeProfileId,
      orElse: () => data.profiles.first,
    );

    return Scaffold(
      backgroundColor: theme.primaryBackground,
      body: SafeArea(
        child: Stack(
          children: [
            CustomScrollView(
              slivers: [
                SliverToBoxAdapter(
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(20, 16, 20, 0),
                    child: _buildHeader(theme, activeProfile, data.summary),
                  ),
                ),
                SliverToBoxAdapter(
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(20, 20, 20, 0),
                    child: _buildFamilySwitcher(theme, data.profiles),
                  ),
                ),
                SliverToBoxAdapter(
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(20, 20, 20, 0),
                    child: _buildContinuePracticingCard(
                      theme,
                      activeProfile,
                      data.summary,
                    ),
                  ),
                ),
                SliverToBoxAdapter(
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(20, 16, 20, 0),
                    child: _buildStatsRow(theme, data.summary),
                  ),
                ),
                if (_error != null)
                  SliverToBoxAdapter(
                    child: Padding(
                      padding: const EdgeInsets.fromLTRB(20, 16, 20, 0),
                      child: _buildInlineError(theme, _error!),
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
                    child: _buildCategoryGrid(theme, data.categories),
                  ),
                ),
                SliverToBoxAdapter(
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(20, 24, 20, 0),
                    child: _buildChallengeBanner(theme, data.summary),
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
                      itemCount: data.recommended.length,
                      separatorBuilder: (_, __) => const SizedBox(width: 14),
                      itemBuilder: (context, index) => SongCard(
                        song: data.recommended[index],
                        onTap: () {},
                      ),
                    ),
                  ),
                ),
                const SliverToBoxAdapter(child: SizedBox(height: 24)),
              ],
            ),
            if (_refreshing)
              Positioned(
                top: 8,
                right: 20,
                child: SizedBox(
                  width: 18,
                  height: 18,
                  child: CircularProgressIndicator(
                    strokeWidth: 2,
                    color: theme.primary,
                  ),
                ),
              ),
          ],
        ),
      ),
      bottomNavigationBar: DashboardBottomNavBar(
        currentIndex: _selectedNavIndex,
        onTap: (index) => setState(() => _selectedNavIndex = index),
      ),
    );
  }

  Widget _buildError(FlutterFlowTheme theme, Object? error, {required VoidCallback onRetry}) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(32),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(Icons.cloud_off_rounded, color: theme.secondaryText, size: 40),
            const SizedBox(height: 12),
            Text(
              "Couldn't load your dashboard",
              style: theme.titleLarge,
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 6),
            Text(
              '$error',
              style: theme.bodyMedium,
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: onRetry,
              style: ElevatedButton.styleFrom(
                backgroundColor: theme.primary,
                foregroundColor: Colors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30),
                ),
              ),
              child: const Text('Try again'),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildInlineError(FlutterFlowTheme theme, Object error) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: theme.error.withOpacity(0.1),
        borderRadius: BorderRadius.circular(14),
      ),
      child: Row(
        children: [
          Icon(Icons.error_outline_rounded, color: theme.error, size: 18),
          const SizedBox(width: 8),
          Expanded(
            child: Text(
              "Couldn't refresh that profile's data. Showing the last loaded data.",
              style: theme.bodySmall,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildHeader(
    FlutterFlowTheme theme,
    FamilyProfile activeProfile,
    DashboardSummary summary,
  ) {
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
                '${summary.dayStreak}',
                style: theme.titleMedium.copyWith(color: theme.warning),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildFamilySwitcher(FlutterFlowTheme theme, List<FamilyProfile> profiles) {
    return SizedBox(
      height: 88,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        itemCount: profiles.length,
        separatorBuilder: (_, __) => const SizedBox(width: 16),
        itemBuilder: (context, index) {
          final profile = profiles[index];
          return ProfileAvatar(
            profile: profile,
            selected: profile.id == _activeProfileId,
            onTap: () => _switchProfile(profile.id),
          );
        },
      ),
    );
  }

  Widget _buildContinuePracticingCard(
    FlutterFlowTheme theme,
    FamilyProfile activeProfile,
    DashboardSummary summary,
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
                  summary.continueSongTitle,
                  style: theme.headlineSmall.copyWith(color: Colors.white),
                ),
                const SizedBox(height: 14),
                ClipRRect(
                  borderRadius: BorderRadius.circular(8),
                  child: LinearProgressIndicator(
                    value: summary.continueProgress,
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

  Widget _buildStatsRow(FlutterFlowTheme theme, DashboardSummary summary) {
    return Row(
      children: [
        StatTile(
          icon: Icons.local_fire_department_rounded,
          value: '${summary.dayStreak}',
          label: 'Day streak',
          color: theme.warning,
        ),
        const SizedBox(width: 12),
        StatTile(
          icon: Icons.library_music_rounded,
          value: '${summary.songsLearned}',
          label: 'Songs learned',
          color: theme.accent1,
        ),
        const SizedBox(width: 12),
        StatTile(
          icon: Icons.timer_rounded,
          value: '${summary.minutesToday}m',
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

  Widget _buildCategoryGrid(FlutterFlowTheme theme, List<SongCategory> categories) {
    return GridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: categories.length,
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        mainAxisSpacing: 12,
        crossAxisSpacing: 12,
        childAspectRatio: 2.6,
      ),
      itemBuilder: (context, index) => CategoryCard(
        category: categories[index],
        onTap: () {},
      ),
    );
  }

  Widget _buildChallengeBanner(FlutterFlowTheme theme, DashboardSummary summary) {
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
                Text(summary.challengeTitle, style: theme.titleLarge),
                const SizedBox(height: 2),
                Text(summary.challengeDescription, style: theme.bodyMedium),
              ],
            ),
          ),
          Icon(Icons.chevron_right_rounded, color: theme.secondaryText),
        ],
      ),
    );
  }
}
