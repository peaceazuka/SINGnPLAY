import '../pages/dashboard/dashboard_model.dart';
import 'api_client.dart';

/// Where the Dashboard screen gets its data from. Swappable so the UI code
/// never has to know whether it's talking to sample data or your live API.
abstract class DashboardRepository {
  /// Loads everything the dashboard needs for the given family profile.
  /// Pass an empty [profileId] to let the backend pick a default (e.g. the
  /// signed-in user's own profile) on first load.
  Future<DashboardData> loadDashboard({required String profileId});
}

/// Default repository: serves the static sample data from
/// `DashboardMockData` so the screen is fully functional with no backend
/// configured. Used automatically while `ApiConfig.isConfigured` is false.
class MockDashboardRepository implements DashboardRepository {
  @override
  Future<DashboardData> loadDashboard({required String profileId}) async {
    // Small artificial delay so loading states are exercised even with
    // sample data, instead of only showing up once a real API is wired in.
    await Future.delayed(const Duration(milliseconds: 400));
    return const DashboardData(
      profiles: DashboardMockData.profiles,
      categories: DashboardMockData.categories,
      recommended: DashboardMockData.recommended,
      summary: DashboardMockData.summary,
    );
  }
}

/// Talks to your real backend. Expects four endpoints under the configured
/// base URL:
///
///   GET /family-profiles
///     -> [ { "id", "name", "emoji", "colorHex" }, ... ]
///   GET /categories
///     -> [ { "title", "icon", "colorHex" }, ... ]
///   GET /songs/recommended?profileId=...
///     -> [ { "title", "subtitle", "icon", "difficulty", "duration" }, ... ]
///   GET /dashboard-summary?profileId=...
///     -> { "streak": { "dayStreak", "songsLearned", "minutesToday" },
///          "continuePracticing": { "songTitle", "progress" },
///          "challenge": { "title", "description" } }
///
/// `icon` values are string keys resolved via `services/icon_mapping.dart`
/// (JSON can't carry Flutter's IconData directly) — add new keys there as
/// your backend introduces new icons.
class ApiDashboardRepository implements DashboardRepository {
  ApiDashboardRepository(this._client);

  final ApiClient _client;

  @override
  Future<DashboardData> loadDashboard({required String profileId}) async {
    final query = profileId.isEmpty ? null : {'profileId': profileId};
    final results = await Future.wait([
      _client.get('/family-profiles'),
      _client.get('/categories'),
      _client.get('/songs/recommended', query: query),
      _client.get('/dashboard-summary', query: query),
    ]);

    final profiles = (results[0] as List)
        .map((e) => FamilyProfile.fromJson(e as Map<String, dynamic>))
        .toList();
    final categories = (results[1] as List)
        .map((e) => SongCategory.fromJson(e as Map<String, dynamic>))
        .toList();
    final recommended = (results[2] as List)
        .map((e) => SongItem.fromJson(e as Map<String, dynamic>))
        .toList();
    final summary = DashboardSummary.fromJson(results[3] as Map<String, dynamic>);

    return DashboardData(
      profiles: profiles,
      categories: categories,
      recommended: recommended,
      summary: summary,
    );
  }
}
