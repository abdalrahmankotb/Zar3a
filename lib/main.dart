import 'package:material_ui/material_ui.dart';
import 'package:go_router/go_router.dart';

import 'package:zar3a/injection_container/injection_container.dart';
import 'package:zar3a/routes/app_router.dart';

class MyApp extends StatelessWidget {
  final AppDependencies dependencies;
  final GoRouter router;

  MyApp({super.key, required this.dependencies})
    : router = appRouter(dependencies);
  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      debugShowCheckedModeBanner: false,
      routerConfig: router,
      
    );
  }
}
