import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

final GlobalKey<NavigatorState> _rootNavigatorKey = GlobalKey<NavigatorState>(debugLabel: 'root');
final GlobalKey<NavigatorState> _sectionANavigatorKey = GlobalKey<NavigatorState>(debugLabel: 'sectionANav');
final GlobalKey<NavigatorState> menuKey = GlobalKey();

void main() {
  runApp(NestedTabNavigationExampleApp());
}

class NestedTabNavigationExampleApp extends StatelessWidget {
  NestedTabNavigationExampleApp({super.key});

  final GoRouter _router = GoRouter(
    navigatorKey: _rootNavigatorKey,
    initialLocation: '/a',
    routes: <RouteBase>[
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
                builder: (BuildContext context, GoRouterState state) => Scaffold(
                  body: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      ElevatedButton(
                        onPressed: () {
                          context.go('/b');
                        },
                        child: const Text('Go to /b'),
                      ),
                      ElevatedButton(
                        onPressed: () {
                          context.go('/menu/events');
                        },
                        child: const Text('Go to /menu/events'),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
          StatefulShellBranch(
            routes: <RouteBase>[
              GoRoute(
                path: '/b',
                builder: (BuildContext context, GoRouterState state) => const TabScreen(
                  text: 'B',
                ),
              ),
            ],
          ),
          StatefulShellBranch(
            routes: <RouteBase>[
              GoRoute(path: '/menu', builder: (context, state) => const SizedBox(), routes: [
                GoRoute(
                  path: 'events',
                  builder: (context, state) => const TabScreen(
                    text: 'Events',
                  ),
                ),
                GoRoute(
                  path: 'vacancies',
                  builder: (context, state) => const TabScreen(
                    text: 'Vacancies',
                  ),
                ),
              ]),
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
    super.key,
  });

  final String text;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text(
          text,
          style: const TextStyle(fontSize: 24),
        ),
      ),
    );
  }
}

class _MenuBottomSheetBody extends StatelessWidget {
  const _MenuBottomSheetBody({
    required this.navigationShell,
    required this.tabController,
  });

  final StatefulNavigationShell navigationShell;
  final TabController tabController;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: DecoratedBox(
        decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(16),
            topRight: Radius.circular(16),
          ),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            ListTile(
              title: const Text('Push to events'),
              onTap: () {
                context.pop(true);
                context.go('/menu/events');
              },
            ),
            ListTile(
              title: const Text('Go to vacancies'),
              onTap: () {
                context.pop(true);
                context.go('/menu/vacancies');
              },
            ),
            _BottomNavigationBar(
              navigationShell: navigationShell,
              tabController: tabController,
              isFromMenu: true,
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
  late final TabController _tabController = TabController(length: 5, vsync: this);
  final GlobalKey<State> _menuNavigatorKey = GlobalKey<State>();

  @override
  void dispose() {
    super.dispose();
    _tabController.dispose();
  }

  @override
  void didUpdateWidget(covariant ScaffoldWithNavBar oldWidget) {
    if (widget.navigationShell.currentIndex != _tabController.index) {
      _tabController.animateTo(widget.navigationShell.currentIndex);
    }
    super.didUpdateWidget(oldWidget);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _menuNavigatorKey,
      body: widget.navigationShell,
      bottomNavigationBar: _BottomNavigationBar(
        navigationShell: widget.navigationShell,
        tabController: _tabController,
      ),
    );
  }
}

class _BottomNavigationBar extends StatefulWidget {
  const _BottomNavigationBar({
    required this.navigationShell,
    required this.tabController,
    this.isFromMenu = false,
  });

  final StatefulNavigationShell navigationShell;

  final TabController tabController;

  final bool isFromMenu;

  @override
  State<_BottomNavigationBar> createState() => __BottomNavigationBarState();
}

class __BottomNavigationBarState extends State<_BottomNavigationBar> {
  @override
  Widget build(BuildContext context) {
    return TabBar(
      controller: widget.tabController,
      indicator: TopIndicator(),
      tabs: const <Tab>[
        Tab(icon: Icon(Icons.work), text: 'A'),
        Tab(icon: Icon(Icons.work), text: 'B'),
        Tab(icon: Icon(Icons.menu), text: 'Menu'),
        Tab(icon: Icon(Icons.tab), text: 'C'),
        Tab(icon: Icon(Icons.settings), text: 'D'),
      ],
      onTap: (int index) async {
        if (index == 2) {
          showModalBottomSheet(
            context: context,
            builder: (context) => _MenuBottomSheetBody(
              navigationShell: widget.navigationShell,
              tabController: widget.tabController,
            ),
          ).then((value) {
            if (widget.tabController.index == 2 && value != true) {
              widget.tabController.animateTo(widget.navigationShell.currentIndex);
            }
          });
        } else {
          widget.navigationShell.goBranch(
            index,
            initialLocation: index == widget.navigationShell.currentIndex,
          );
          if (widget.isFromMenu) {
            Navigator.of(context).pop();
            widget.tabController.animateTo(index);
          }
        }
      },
    );
  }
}

class TopIndicator extends Decoration {
  @override
  BoxPainter createBoxPainter([VoidCallback? onChanged]) => _TopIndicatorBox();
}

class _TopIndicatorBox extends BoxPainter {
  @override
  void paint(Canvas canvas, Offset offset, ImageConfiguration cfg) {
    final paint = Paint()
      ..shader = const RadialGradient(
        colors: [
          Colors.black,
          Colors.black,
        ],
      ).createShader(
        Rect.fromCircle(
          center: offset,
          radius: 0,
        ),
      )
      ..strokeWidth = 2
      ..isAntiAlias = true
      ..strokeCap = StrokeCap.square;

    canvas.drawLine(
      Offset(offset.dx, 0.5),
      Offset(cfg.size!.width + offset.dx, 0.5),
      paint,
    );
  }
}

class BottomSheetPage extends Page {
  const BottomSheetPage({
    required this.child,
    this.showDragHandle = true,
    this.useSafeArea = false,
    super.key,
    super.restorationId = 'bottomSheet',
  });
  final Widget child;
  final bool showDragHandle;
  final bool useSafeArea;

  @override
  Route createRoute(BuildContext context) => ModalBottomSheetRoute(
        settings: this,
        isScrollControlled: true,
        showDragHandle: showDragHandle,
        useSafeArea: useSafeArea,
        backgroundColor: Colors.transparent,
        builder: (context) => (ModalRoute.of(context)!.settings as BottomSheetPage).child,
      );
}
