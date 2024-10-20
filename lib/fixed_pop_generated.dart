// // GENERATED CODE - DO NOT MODIFY BY HAND

// part of 'pop_generated.dart';

// // **************************************************************************
// // GoRouterGenerator
// // **************************************************************************

// List<RouteBase> get $appRoutes => [
//       $successRoute,
//       $categoriesRoute,
//       $mainShellRouteData,
//     ];

// RouteBase get $successRoute => GoRoute(
//       path: '/success',
//       builder: (context, state) => const SuccessRoute().build(context, state),
//     );

// extension $SuccessRouteExtension on SuccessRoute {
//   String get location => GoRouteData.$location(
//         '/success',
//       );

//   void go(BuildContext context) => context.go(location);

//   Future<T?> push<T>(BuildContext context) => context.push<T>(location);

//   void pushReplacement(BuildContext context) => context.pushReplacement(location);

//   void replace(BuildContext context) => context.replace(location);
// }

// RouteBase get $categoriesRoute => GoRoute(
//       path: '/categories',
//       builder: (context, state) => const CategoriesRoute().build(context, state),
//     );

// extension $CategoriesRouteExtension on CategoriesRoute {
//   String get location => GoRouteData.$location(
//         '/categories',
//       );

//   void go(BuildContext context) => context.go(location);

//   Future<T?> push<T>(BuildContext context) => context.push<T>(location);

//   void pushReplacement(BuildContext context) => context.pushReplacement(location);

//   void replace(BuildContext context) => context.replace(location);
// }

// RouteBase get $mainShellRouteData => StatefulShellRoute.indexedStack(
//       builder: (context, state, navigationShell) => const MainShellRouteData().builder(context, state, navigationShell),
//       branches: [
//         StatefulShellBranch(
//           navigatorKey: AShellBranchData.$navigatorKey,
//           routes: [
//             GoRoute(
//               path: '/a',
//               builder: (context, state) => const ARouteData().build(context, state),
//             ),
//           ],
//         ),
//         StatefulShellBranch(
//           routes: [
//             GoRoute(
//               path: '/b',
//               builder: (context, state) => const BRouteData().build(context, state),
//               routes: [
//                 GoRoute(
//                   path: '/bb',
//                   builder: (context, state) => const BBRouteData().build(context, state),
//                 ),
//               ],
//             ),
//           ],
//         ),
//         StatefulShellBranch(
//           routes: [
//             GoRoute(
//               path: '/c',
//               builder: (context, state) => const CRouteData().build(context, state),
//             ),
//           ],
//         ),
//         StatefulShellBranch(
//           routes: [
//             GoRoute(
//               path: '/d',
//               builder: (context, state) => const DRouteData().build(context, state),
//             ),
//           ],
//         ),
//       ],
//     );

// extension $MainShellRouteDataExtension on MainShellRouteData {
//   static MainShellRouteData _fromState(GoRouterState state) => const MainShellRouteData();
// }

// extension $ARouteDataExtension on ARouteData {
//   static ARouteData _fromState(GoRouterState state) => const ARouteData();

//   String get location => GoRouteData.$location(
//         '/a',
//       );

//   void go(BuildContext context) => context.go(location);

//   Future<T?> push<T>(BuildContext context) => context.push<T>(location);

//   void pushReplacement(BuildContext context) => context.pushReplacement(location);

//   void replace(BuildContext context) => context.replace(location);
// }

// extension $BRouteDataExtension on BRouteData {
//   static BRouteData _fromState(GoRouterState state) => const BRouteData();

//   String get location => GoRouteData.$location(
//         '/b',
//       );

//   void go(BuildContext context) => context.go(location);

//   Future<T?> push<T>(BuildContext context) => context.push<T>(location);

//   void pushReplacement(BuildContext context) => context.pushReplacement(location);

//   void replace(BuildContext context) => context.replace(location);
// }

// extension $BBRouteDataExtension on BBRouteData {
//   static BBRouteData _fromState(GoRouterState state) => const BBRouteData();

//   String get location => GoRouteData.$location(
//         '/bb',
//       );

//   void go(BuildContext context) => context.go(location);

//   Future<T?> push<T>(BuildContext context) => context.push<T>(location);

//   void pushReplacement(BuildContext context) => context.pushReplacement(location);

//   void replace(BuildContext context) => context.replace(location);
// }

// extension $CRouteDataExtension on CRouteData {
//   static CRouteData _fromState(GoRouterState state) => const CRouteData();

//   String get location => GoRouteData.$location(
//         '/c',
//       );

//   void go(BuildContext context) => context.go(location);

//   Future<T?> push<T>(BuildContext context) => context.push<T>(location);

//   void pushReplacement(BuildContext context) => context.pushReplacement(location);

//   void replace(BuildContext context) => context.replace(location);
// }

// extension $DRouteDataExtension on DRouteData {
//   static DRouteData _fromState(GoRouterState state) => const DRouteData();

//   String get location => GoRouteData.$location(
//         '/d',
//       );

//   void go(BuildContext context) => context.go(location);

//   Future<T?> push<T>(BuildContext context) => context.push<T>(location);

//   void pushReplacement(BuildContext context) => context.pushReplacement(location);

//   void replace(BuildContext context) => context.replace(location);
// }
