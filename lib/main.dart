import 'package:flutter/widgets.dart';
import 'package:material_ui/material_ui.dart';

import 'routes/app_router.dart';
import 'routes/route_names.dart';
import 'core/theme/app_theme.dart';
import 'injection_container/injection_container.dart';

void main() => runApp(MainApp());

class MainApp extends StatelessWidget {
  MainApp({super.key}) : dependencies = AppDependencies();
  final AppDependencies dependencies;
  @override
  Widget build(BuildContext context) => MaterialApp(
    title: 'zar3a',
    debugShowCheckedModeBanner: false,
    theme: buildAppTheme(),
    initialRoute: RouteNames.splash,
    onGenerateRoute: (settings) => buildRoute(settings, dependencies),
  );
}
