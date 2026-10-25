import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../features/alerts/presentation/alerts_screen.dart';
import '../../features/assistant/presentation/assistant_screen.dart';
import '../../features/lines/presentation/lines_screen.dart';
import '../../features/map/presentation/railway_map_screen.dart';
import '../../features/search/presentation/search_screen.dart';
import '../../features/settings/presentation/settings_screen.dart';
import '../../features/shell/presentation/app_scaffold.dart';

final _rootNavigatorKey = GlobalKey<NavigatorState>(debugLabel: 'root');

/// Provides the application's [GoRouter] configuration.
final appRouterProvider = Provider<GoRouter>((ref) {
  return GoRouter(
    navigatorKey: _rootNavigatorKey,
    initialLocation: '/search',
    debugLogDiagnostics: false,
    routes: [
      StatefulShellRoute.indexedStack(
        builder: (context, state, navigationShell) {
          return AppScaffold(navigationShell: navigationShell);
        },
        branches: [
          // Branch: Search & Timetables
          StatefulShellBranch(
            routes: [
              GoRoute(
                path: '/search',
                builder: (context, state) => const SearchScreen(),
              ),
            ],
          ),
          // Branch: Suburban Lines & Corridors
          StatefulShellBranch(
            routes: [
              GoRoute(
                path: '/lines',
                builder: (context, state) => const LinesScreen(),
                routes: [
                  GoRoute(
                    path: 'map',
                    builder: (context, state) {
                      final extra = state.extra as Map<String, String>?;
                      return RailwayMapScreen(
                        initialStationId: extra?['stationId'],
                        originStationId: extra?['originId'],
                        destinationStationId: extra?['destId'],
                      );
                    },
                  ),
                ],
              ),
            ],
          ),
          // Branch: Station Proximity Alerts
          StatefulShellBranch(
            routes: [
              GoRoute(
                path: '/alerts',
                builder: (context, state) => const AlertsScreen(),
              ),
            ],
          ),
          // Branch: Settings & Preferences
          StatefulShellBranch(
            routes: [
              GoRoute(
                path: '/settings',
                builder: (context, state) => const SettingsScreen(),
              ),
            ],
          ),
        ],
      ),
      GoRoute(
        path: '/assistant',
        builder: (context, state) => const AssistantScreen(),
      ),
    ],
  );
});
