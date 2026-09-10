import 'package:flutter/material.dart';

import 'config/api_config.dart';
import 'flutter_flow/flutter_flow_theme.dart';
import 'pages/dashboard/dashboard_widget.dart';
import 'services/api_client.dart';
import 'services/dashboard_repository.dart';

void main() {
  runApp(const SingnplayWorshipTimeApp());
}

/// Live API once `API_BASE_URL` is provided via `--dart-define`, sample
/// data otherwise. See `config/api_config.dart` for how to set it.
DashboardRepository _buildDashboardRepository() {
  if (!ApiConfig.isConfigured) return MockDashboardRepository();
  return ApiDashboardRepository(
    ApiClient(baseUrl: ApiConfig.baseUrl, authToken: ApiConfig.authToken),
  );
}

class SingnplayWorshipTimeApp extends StatelessWidget {
  const SingnplayWorshipTimeApp({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = WorshipTimeTheme();
    return MaterialApp(
      title: 'SINGnPLAY WorshipTime',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        useMaterial3: true,
        scaffoldBackgroundColor: theme.primaryBackground,
        colorScheme: ColorScheme.fromSeed(
          seedColor: theme.primary,
          primary: theme.primary,
          secondary: theme.secondary,
          tertiary: theme.tertiary,
        ),
      ),
      home: DashboardWidget(repository: _buildDashboardRepository()),
    );
  }
}
