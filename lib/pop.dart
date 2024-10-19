import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

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
    routes: <RouteBase>[
      GoRoute(
        path: '/success',
        builder: (BuildContext context, GoRouterState state) => TabScreen(
          text: 'Success',
          onPressed: () {
            context.pop(true);
            context.pop(false);
          },
        ),
      ),
      GoRoute(
        path: '/categories',
        builder: (BuildContext context, GoRouterState state) => TabScreen(
          text: 'Categories',
          onPressed: () => context.push<bool>('/success'),
        ),
      ),
      StatefulShellRoute.indexedStack(
        builder: (BuildContext context, GoRouterState state, StatefulNavigationShell navigationShell) {
          return ScaffoldWithNavBar(
            navigationShell: navigationShell,
          );
        },
        branches: <StatefulShellBranch>[
          StatefulShellBranch(
            navigatorKey: _sectionANavigatorKey,
            routes: <RouteBase>[
              GoRoute(
                path: '/a',
                builder: (BuildContext context, GoRouterState state) => const TabScreen(
                  text: 'A',
                ),
              ),
            ],
          ),
          StatefulShellBranch(
            routes: <RouteBase>[
              GoRoute(
                path: '/b',
                builder: (BuildContext context, GoRouterState state) => TabScreen(
                  text: 'B',
                  onPressed: () => GoRouter.of(context).push<bool>('/b/bb'),
                ),
                routes: [
                  GoRoute(
                    path: 'bb',
                    builder: (BuildContext context, GoRouterState state) => TabScreen(
                      text: 'BB',
                      onPressed: () => GoRouter.of(context).push('/categories'),
                    ),
                  ),
                ],
              ),
            ],
          ),
          StatefulShellBranch(
            routes: <RouteBase>[
              GoRoute(
                path: '/c',
                builder: (BuildContext context, GoRouterState state) => const TabScreen(
                  text: 'C',
                ),
              ),
            ],
          ),
          StatefulShellBranch(
            routes: <RouteBase>[
              GoRoute(
                path: '/d',
                builder: (BuildContext context, GoRouterState state) => const TabScreen(
                  text: 'D',
                ),
              ),
            ],
          ),
        ],
      ),
    ],
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
