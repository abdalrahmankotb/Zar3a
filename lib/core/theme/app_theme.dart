import 'package:material_ui/material_ui.dart';

import 'app_colors.dart';
import 'app_text_styles.dart';

ThemeData buildAppTheme() => ThemeData(
  useMaterial3: true,

  fontFamily: AppTextStyles.fontFamily,

  scaffoldBackgroundColor: AppColors.background,

  textTheme: const TextTheme(
    displayLarge: AppTextStyles.h1,
    displayMedium: AppTextStyles.h2,
    displaySmall: AppTextStyles.h3,

    headlineMedium: AppTextStyles.button,

    titleLarge: AppTextStyles.bodyLargeBold,
    titleMedium: AppTextStyles.bodyMediumBold,
    titleSmall: AppTextStyles.bodySmallBold,

    bodyLarge: AppTextStyles.bodyLarge,
    bodyMedium: AppTextStyles.bodyMedium,
    bodySmall: AppTextStyles.bodySmall,

    labelLarge: AppTextStyles.captionBold,
    labelMedium: AppTextStyles.caption,
    labelSmall: AppTextStyles.overline,
  ),
);
