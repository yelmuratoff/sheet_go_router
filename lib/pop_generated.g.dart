// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'pop_generated.dart';

// **************************************************************************
// GoRouterGenerator
// **************************************************************************

List<RouteBase> get $appRoutes => [
      $successRoute,
      $categoriesRoute,
      $mainShellRouteData,
    ];

RouteBase get $successRoute => GoRouteData.$route(
      path: '/success',
      factory: $SuccessRouteExtension._fromState,
    );

extension $SuccessRouteExtension on SuccessRoute {
  static SuccessRoute _fromState(GoRouterState state) => const SuccessRoute();

  String get location => GoRouteData.$location(
        '/success',
      );

  void go(BuildContext context) => context.go(location);

  Future<T?> push<T>(BuildContext context) => context.push<T>(location);

  void pushReplacement(BuildContext context) => context.pushReplacement(location);

  void replace(BuildContext context) => context.replace(location);
}

RouteBase get $categoriesRoute => GoRouteData.$route(
      path: '/categories',
      factory: $CategoriesRouteExtension._fromState,
    );

extension $CategoriesRouteExtension on CategoriesRoute {
  static CategoriesRoute _fromState(GoRouterState state) => const CategoriesRoute();

  String get location => GoRouteData.$location(
        '/categories',
      );

  void go(BuildContext context) => context.go(location);

  Future<T?> push<T>(BuildContext context) => context.push<T>(location);

  void pushReplacement(BuildContext context) => context.pushReplacement(location);

  void replace(BuildContext context) => context.replace(location);
}

RouteBase get $mainShellRouteData => StatefulShellRouteData.$route(
      factory: $MainShellRouteDataExtension._fromState,
      branches: [
        StatefulShellBranchData.$branch(
          navigatorKey: AShellBranchData.$navigatorKey,
          routes: [
            GoRouteData.$route(
              path: '/a',
              factory: $ARouteDataExtension._fromState,
            ),
          ],
        ),
        StatefulShellBranchData.$branch(
          routes: [
            GoRouteData.$route(
              path: '/b',
              factory: $BRouteDataExtension._fromState,
              routes: [
                GoRouteData.$route(
                  path: '/bb',
                  factory: $BBRouteDataExtension._fromState,
                ),
              ],
            ),
          ],
        ),
        StatefulShellBranchData.$branch(
          routes: [
            GoRouteData.$route(
              path: '/c',
              factory: $CRouteDataExtension._fromState,
            ),
          ],
        ),
        StatefulShellBranchData.$branch(
          routes: [
            GoRouteData.$route(
              path: '/d',
              factory: $DRouteDataExtension._fromState,
            ),
          ],
        ),
      ],
    );

extension $MainShellRouteDataExtension on MainShellRouteData {
  static MainShellRouteData _fromState(GoRouterState state) => const MainShellRouteData();
}

extension $ARouteDataExtension on ARouteData {
  static ARouteData _fromState(GoRouterState state) => const ARouteData();

  String get location => GoRouteData.$location(
        '/a',
      );

  void go(BuildContext context) => context.go(location);

  Future<T?> push<T>(BuildContext context) => context.push<T>(location);

  void pushReplacement(BuildContext context) => context.pushReplacement(location);

  void replace(BuildContext context) => context.replace(location);
}

extension $BRouteDataExtension on BRouteData {
  static BRouteData _fromState(GoRouterState state) => const BRouteData();

  String get location => GoRouteData.$location(
        '/b',
      );

  void go(BuildContext context) => context.go(location);

  Future<T?> push<T>(BuildContext context) => context.push<T>(location);

  void pushReplacement(BuildContext context) => context.pushReplacement(location);

  void replace(BuildContext context) => context.replace(location);
}

extension $BBRouteDataExtension on BBRouteData {
  static BBRouteData _fromState(GoRouterState state) => const BBRouteData();

  String get location => GoRouteData.$location(
        '/bb',
      );

  void go(BuildContext context) => context.go(location);

  Future<T?> push<T>(BuildContext context) => context.push<T>(location);

  void pushReplacement(BuildContext context) => context.pushReplacement(location);

  void replace(BuildContext context) => context.replace(location);
}

extension $CRouteDataExtension on CRouteData {
  static CRouteData _fromState(GoRouterState state) => const CRouteData();

  String get location => GoRouteData.$location(
        '/c',
      );

  void go(BuildContext context) => context.go(location);

  Future<T?> push<T>(BuildContext context) => context.push<T>(location);

  void pushReplacement(BuildContext context) => context.pushReplacement(location);

  void replace(BuildContext context) => context.replace(location);
}

extension $DRouteDataExtension on DRouteData {
  static DRouteData _fromState(GoRouterState state) => const DRouteData();

  String get location => GoRouteData.$location(
        '/d',
      );

  void go(BuildContext context) => context.go(location);

  Future<T?> push<T>(BuildContext context) => context.push<T>(location);

  void pushReplacement(BuildContext context) => context.pushReplacement(location);

  void replace(BuildContext context) => context.replace(location);
}
