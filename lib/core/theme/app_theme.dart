import 'package:material_ui/material_ui.dart';

import 'app_colors.dart';

ThemeData buildAppTheme() => ThemeData(
  fontFamily: 'Cairo',
  scaffoldBackgroundColor: paper,
  colorScheme: ColorScheme.fromSeed(seedColor: green),
);
