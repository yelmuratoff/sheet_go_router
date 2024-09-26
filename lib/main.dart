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
                builder: (BuildContext context, GoRouterState state) =>
                    const RootScreen(label: 'A', detailsPath: '/a/details'),
                routes: <RouteBase>[
                  GoRoute(
                    path: 'details',
                    builder: (BuildContext context, GoRouterState state) => const DetailsScreen(label: 'A'),
                  ),
                ],
              ),
            ],
          ),
          StatefulShellBranch(
            routes: <RouteBase>[
              GoRoute(
                path: '/b',
                builder: (BuildContext context, GoRouterState state) => const RootScreen(
                  label: 'B',
                  detailsPath: '/b/details/1',
                  secondDetailsPath: '/b/details/2',
                ),
                routes: <RouteBase>[
                  GoRoute(
                    path: 'details/:param',
                    builder: (BuildContext context, GoRouterState state) => DetailsScreen(
                      label: 'B',
                      param: state.pathParameters['param'],
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
                builder: (BuildContext context, GoRouterState state) => const RootScreen(
                  label: 'C',
                  detailsPath: '/c/details',
                ),
                routes: <RouteBase>[
                  GoRoute(
                    path: 'details',
                    builder: (BuildContext context, GoRouterState state) => DetailsScreen(
                      label: 'C',
                      extra: state.extra,
                    ),
                  ),
                ],
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
  late final TabController _tabController = TabController(length: 4, vsync: this);

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
          Tab(icon: Icon(Icons.home), text: 'Section A'),
          Tab(icon: Icon(Icons.work), text: 'Section B'),
          Tab(icon: Icon(Icons.tab), text: 'Section C'),
          Tab(icon: Icon(Icons.menu), text: 'Menu'),
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
          if (index == 3) {
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

class RootScreen extends StatelessWidget {
  const RootScreen({
    required this.label,
    required this.detailsPath,
    this.secondDetailsPath,
    super.key,
  });

  final String label;
  final String detailsPath;
  final String? secondDetailsPath;

  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: AppBar(
          title: Text('Root of section $label'),
        ),
        body: Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Text('Screen $label', style: Theme.of(context).textTheme.titleLarge),
              const Padding(padding: EdgeInsets.all(4)),
              TextButton(
                onPressed: () {
                  GoRouter.of(context).go(detailsPath, extra: '$label-XYZ');
                },
                child: const Text('View details'),
              ),
              const Padding(padding: EdgeInsets.all(4)),
              if (secondDetailsPath != null)
                TextButton(
                  onPressed: () {
                    GoRouter.of(context).go(secondDetailsPath!);
                  },
                  child: const Text('View more details'),
                ),
            ],
          ),
        ),
      );
}

class DetailsScreen extends StatefulWidget {
  const DetailsScreen({
    required this.label,
    this.param,
    this.extra,
    this.withScaffold = true,
    super.key,
  });

  final String label;
  final String? param;
  final Object? extra;
  final bool withScaffold;

  @override
  State<StatefulWidget> createState() => DetailsScreenState();
}

class DetailsScreenState extends State<DetailsScreen> {
  int _counter = 0;

  @override
  Widget build(BuildContext context) {
    if (widget.withScaffold) {
      return Scaffold(
        appBar: AppBar(
          title: Text('Details Screen - ${widget.label}'),
        ),
        body: _build(context),
      );
    } else {
      return ColoredBox(
        color: Theme.of(context).scaffoldBackgroundColor,
        child: _build(context),
      );
    }
  }

  Widget _build(BuildContext context) => Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Text('Details for ${widget.label} - Counter: $_counter', style: Theme.of(context).textTheme.titleLarge),
            const Padding(padding: EdgeInsets.all(4)),
            TextButton(
              onPressed: () {
                setState(() {
                  _counter++;
                });
              },
              child: const Text('Increment counter'),
            ),
            const Padding(padding: EdgeInsets.all(8)),
            if (widget.param != null)
              Text('Parameter: ${widget.param!}', style: Theme.of(context).textTheme.titleMedium),
            const Padding(padding: EdgeInsets.all(8)),
            if (widget.extra != null) Text('Extra: ${widget.extra!}', style: Theme.of(context).textTheme.titleMedium),
            if (!widget.withScaffold) ...<Widget>[
              const Padding(padding: EdgeInsets.all(16)),
              TextButton(
                onPressed: () {
                  GoRouter.of(context).pop();
                },
                child: const Text('< Back', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
              ),
            ],
          ],
        ),
      );
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
