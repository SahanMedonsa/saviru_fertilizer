import 'package:fertilizerapp/login/login.dart';
import 'package:fertilizerapp/navbar/NavigationBar.dart';
import 'package:fertilizerapp/pages/Home.dart';
import 'package:fertilizerapp/pages/Profile.dart';
import 'package:fertilizerapp/pages/Stock.dart';
import 'package:fertilizerapp/pages/billing.dart';

import 'package:flutter/widgets.dart';
import 'package:go_router/go_router.dart';

class AppNavigation {
  AppNavigation._();

  static String initRoute = '/login'; // Set the initial route to the login page

  // Private navigation keys for each branch
  static final GlobalKey<NavigatorState> _rootNavigationHome =
      GlobalKey<NavigatorState>(debugLabel: 'shellHome');
  static final GlobalKey<NavigatorState> _rootNavigationVegestat =
      GlobalKey<NavigatorState>(debugLabel: 'shellVegestat');
  static final GlobalKey<NavigatorState> _rootNavigationProfile =
      GlobalKey<NavigatorState>(debugLabel: 'shellProfile');

  // Define the routes for GoRouter
  static final GoRouter router = GoRouter(
    initialLocation: initRoute,
    debugLogDiagnostics: true,
    routes: <RouteBase>[
      GoRoute(
        path: '/login',
        name: 'Login',
        builder: (context, state) {
          return LoginPage(
            key: state.pageKey,
            // Set any callbacks or parameters needed for successful login
          );
        },
        // Optional: Define redirect if the user is already logged in
      
      ),

      // Main navbar
      StatefulShellRoute.indexedStack(
        builder: (context, state, navigationShell) {
          return CustomBottomNavigationBar(
            navigationShell: navigationShell,
          );
        },
        branches: <StatefulShellBranch>[
          // Home
          StatefulShellBranch(navigatorKey: _rootNavigationHome, routes: [
            GoRoute(
              path: '/home',
              name: 'Home',
              builder: (context, state) {
                return Homepage(
                  key: state.pageKey,
                );
              },
            ),
          ]),

          // Stock
          StatefulShellBranch(navigatorKey: _rootNavigationVegestat, routes: [
            GoRoute(
              path: '/stock',
              name: 'Stock',
              builder: (context, state) {
                return Stockpage(
                  key: state.pageKey,
                );
              },
              routes: [
                GoRoute(
                  path: 'billing/:id/:name',
                  name: 'billing',
                  builder: (context, state) {
                    final id = state.pathParameters['id']!;
                    final name = state.pathParameters['name']!;
                    return BillingScreen(
                      key: state.pageKey,
                      farmerId: id,
                      farmerName: name,
                    );
                  },
                ),
              ],
            ),
          ]),

          // Profile
          StatefulShellBranch(navigatorKey: _rootNavigationProfile, routes: [
            GoRoute(
              path: '/profile',
              name: 'Profile',
              builder: (context, state) {
                return FertilizerOutletDetails(
                  key: state.pageKey,
                );
              },
            ),
          ]),
        ],
      ),
    ],
  );
}
