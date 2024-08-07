import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:tips_generator/tips_generator.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(MultiProvider(
    providers: [
      ...TipsGeneratorProviders.providers(),
    ],
    child: const MyApp(),
  ));
}

class MyApp extends StatefulWidget {
  const MyApp({
    super.key,
  });

  @override
  State<MyApp> createState() => _MyAppState();

  // ignore: library_private_types_in_public_api
  static _MyAppState of(BuildContext context) =>
      context.findAncestorStateOfType<_MyAppState>()!;
}

class _MyAppState extends State<MyApp> {
  late GoRouter _router;

  @override
  void initState() {
    super.initState();
    _router = createRouter();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: 'TheTipster',
      theme: ThemeData(
        brightness: Brightness.dark,
        useMaterial3: false,
      ),
      darkTheme: ThemeData(
        brightness: Brightness.dark,
        useMaterial3: false,
      ),
      routerConfig: _router,
    );
  }
}

final RouteObserver<ModalRoute> routeObserver = RouteObserver<PageRoute>();

GoRouter createRouter() => GoRouter(
      initialLocation: '/leagueTips',
      debugLogDiagnostics: true,
      routes: [
        ...TipsGeneratorRouter.routes(),
      ].map((r) => r.toRoute()).toList(),
      observers: [routeObserver],
    );
