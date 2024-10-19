import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

part 'pop_generated.g.dart';

final GlobalKey<NavigatorState> _rootNavigatorKey = GlobalKey<NavigatorState>(debugLabel: 'root');
final GlobalKey<NavigatorState> _sectionANavigatorKey = GlobalKey<NavigatorState>(debugLabel: 'sectionANav');

void main() {
  runApp(NestedTabNavigationExampleApp());
}

class NestedTabNavigationExampleApp extends StatelessWidget {
  NestedTabNavigationExampleApp({super.key});

  final GoRouter _router = GoRouter(
    navigatorKey: _rootNavigatorKey,
    debugLogDiagnostics: true,
    initialLocation: '/a',
    routes: $appRoutes,
  );

  @override
  Widget build(BuildContext context) => MaterialApp.router(
        routerConfig: _router,
      );
}

class TabScreen extends StatelessWidget {
  const TabScreen({
    required this.text,
    this.onPressed,
    super.key,
  });

  final String text;
  final VoidCallback? onPressed;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              text,
              style: const TextStyle(fontSize: 24),
            ),
            ElevatedButton(
              onPressed: onPressed,
              child: const Text('Go'),
            ),
          ],
        ),
      ),
    );
  }
}

class ScaffoldWithNavBar extends StatefulWidget {
  const ScaffoldWithNavBar({
    required this.navigationShell,
    Key? key,
  }) : super(key: key ?? const ValueKey<String>('ScaffoldWithNavBar'));

  final StatefulNavigationShell navigationShell;

  @override
  State<ScaffoldWithNavBar> createState() => _ScaffoldWithNavBarState();
}

class _ScaffoldWithNavBarState extends State<ScaffoldWithNavBar> with TickerProviderStateMixin {
  late final TabController _tabController = TabController(length: 4, vsync: this);

  @override
  void dispose() {
    super.dispose();
    _tabController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: widget.navigationShell,
      bottomNavigationBar: TabBar(
        controller: _tabController,
        tabs: const <Tab>[
          Tab(icon: Icon(Icons.work), text: 'A'),
          Tab(icon: Icon(Icons.work), text: 'B'),
          Tab(icon: Icon(Icons.tab), text: 'C'),
          Tab(icon: Icon(Icons.settings), text: 'D'),
        ],
        onTap: (int index) async {
          widget.navigationShell.goBranch(
            index,
            initialLocation: index == widget.navigationShell.currentIndex,
          );
        },
      ),
    );
  }
}

// <-- Routes -->

@TypedGoRoute<SuccessRoute>(path: '/success')
class SuccessRoute extends GoRouteData {
  const SuccessRoute();

  @override
  Widget build(BuildContext context, GoRouterState state) {
    return TabScreen(
      text: 'Success route',
      onPressed: () {
        context.pop(true);
        context.pop(false);
      },
    );
  }
}

@TypedGoRoute<CategoriesRoute>(path: '/categories')
class CategoriesRoute extends GoRouteData {
  const CategoriesRoute();

  @override
  Widget build(BuildContext context, GoRouterState state) {
    return TabScreen(
      text: 'Categories route',
      onPressed: () => context.push<bool>('/success'),
    );
  }
}

// <-- Stateful Shell -->

@TypedStatefulShellRoute<MainShellRouteData>(
  branches: <TypedStatefulShellBranch<StatefulShellBranchData>>[
    TypedStatefulShellBranch<AShellBranchData>(
      routes: [
        TypedGoRoute<ARouteData>(path: '/a'),
      ],
    ),
    TypedStatefulShellBranch<BShellBranchData>(
      routes: [
        TypedGoRoute<BRouteData>(path: '/b', routes: [
          TypedGoRoute<BBRouteData>(path: '/bb'),
        ]),
      ],
    ),
    TypedStatefulShellBranch<CShellBranchData>(
      routes: [
        TypedGoRoute<CRouteData>(path: '/c'),
      ],
    ),
    TypedStatefulShellBranch<DShellBranchData>(
      routes: [
        TypedGoRoute<DRouteData>(path: '/d'),
      ],
    ),
  ],
)
class MainShellRouteData extends StatefulShellRouteData {
  const MainShellRouteData();

  @override
  Widget builder(
    BuildContext context,
    GoRouterState state,
    StatefulNavigationShell navigationShell,
  ) {
    return ScaffoldWithNavBar(
      navigationShell: navigationShell,
    );
  }
}

class AShellBranchData extends StatefulShellBranchData {
  static final GlobalKey<NavigatorState> $navigatorKey = _sectionANavigatorKey;

  const AShellBranchData();
}

class BShellBranchData extends StatefulShellBranchData {
  const BShellBranchData();
}

class CShellBranchData extends StatefulShellBranchData {
  const CShellBranchData();
}

class DShellBranchData extends StatefulShellBranchData {
  const DShellBranchData();
}

// <-- Stateful Routes -->

class ARouteData extends GoRouteData {
  const ARouteData();

  @override
  Widget build(BuildContext context, GoRouterState state) {
    return const TabScreen(text: 'A');
  }
}

class BRouteData extends GoRouteData {
  const BRouteData();

  @override
  Widget build(BuildContext context, GoRouterState state) {
    return TabScreen(
      text: 'B',
      onPressed: () => context.push<bool>('/b/bb'),
    );
  }
}

class BBRouteData extends GoRouteData {
  const BBRouteData();

  @override
  Widget build(BuildContext context, GoRouterState state) {
    return TabScreen(
      text: 'BB',
      onPressed: () => context.push('/categories'),
    );
  }
}

class CRouteData extends GoRouteData {
  const CRouteData();

  @override
  Widget build(BuildContext context, GoRouterState state) {
    return const TabScreen(text: 'C');
  }
}

class DRouteData extends GoRouteData {
  const DRouteData();

  @override
  Widget build(BuildContext context, GoRouterState state) {
    return const TabScreen(text: 'D');
  }
}
