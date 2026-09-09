import 'package:flutter/material.dart';

import 'flutter_flow/flutter_flow_theme.dart';
import 'pages/dashboard/dashboard_widget.dart';

void main() {
  runApp(const SingnplayWorshipTimeApp());
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
      home: const DashboardWidget(),
    );
  }
}
