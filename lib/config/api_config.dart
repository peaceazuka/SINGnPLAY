/// Connection settings for your backend API.
///
/// Nothing is hardcoded here on purpose: `baseUrl`/`authToken` are read
/// from `--dart-define` values at build/run time, so the URL and token
/// never sit in source control. Until `API_BASE_URL` is supplied, the app
/// falls back to [MockDashboardRepository] automatically (see
/// `services/dashboard_repository.dart`) so the dashboard keeps working
/// with sample data.
///
/// Once you have a base URL, run with e.g.:
///   flutter run \
///     --dart-define=API_BASE_URL=https://your-api.example.com \
///     --dart-define=API_AUTH_TOKEN=your-token
class ApiConfig {
  const ApiConfig._();

  static const String baseUrl =
      String.fromEnvironment('API_BASE_URL', defaultValue: '');

  static const String authToken =
      String.fromEnvironment('API_AUTH_TOKEN', defaultValue: '');

  static bool get isConfigured => baseUrl.isNotEmpty;
}
