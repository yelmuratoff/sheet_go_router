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
                builder: (BuildContext context, GoRouterState state) => const TabScreen(
                  text: 'B',
                ),
              ),
            ],
          ),
          StatefulShellBranch(
            routes: <RouteBase>[
              GoRoute(
                path: '/menu',
                pageBuilder: (context, state) => const BottomSheetPage(
                  child: _MenuBottomSheetBody(),
                ),
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
        title: 'Flutter Demo',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
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
  const _MenuBottomSheetBody();

  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
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
            title: const Text('Option 1'),
            onTap: () {},
          ),
          ListTile(
            title: const Text('Option 2'),
            onTap: () {},
          ),
        ],
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
  bool _isSheetOpen = false;
  late final TabController _tabController = TabController(length: 5, vsync: this);

  @override
  void dispose() {
    super.dispose();
    _tabController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: const ValueKey<String>('ScaffoldWithNavBar'),
      body: widget.navigationShell,
      bottomNavigationBar: TabBar(
        controller: _tabController,
        indicator: TopIndicator(),
        tabs: const <Tab>[
          Tab(icon: Icon(Icons.work), text: 'A'),
          Tab(icon: Icon(Icons.work), text: 'B'),
          Tab(icon: Icon(Icons.menu), text: 'Menu'),
          Tab(icon: Icon(Icons.tab), text: 'C'),
          Tab(icon: Icon(Icons.settings), text: 'D'),
        ],
        onTap: (int index) async {
          await Future.delayed(const Duration(milliseconds: 200), () {
            if (_isSheetOpen) {
              setState(() {
                _isSheetOpen = false;
                context.pop();
              });
            }
          });
          if (index == 2) {
            setState(() {
              _isSheetOpen = true;
              GoRouter.of(context).push('/menu');
            });
          } else {
            widget.navigationShell.goBranch(
              index,
              initialLocation: index == widget.navigationShell.currentIndex,
            );
          }
        },
      ),
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
    this.showDragHandle = false,
    this.useSafeArea = false,
    super.key,
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
