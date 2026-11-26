import 'package:material_ui/material_ui.dart';

import '../../../../core/theme/app_text_styles.dart';

class OnboardingCopy extends StatelessWidget {
  const OnboardingCopy({
    super.key,
    required this.title,
    required this.description,
  });
  final String title, description;
  @override
  Widget build(BuildContext context) => Column(
    children: [
      Text(title, textAlign: TextAlign.center, style: AppTextStyles.button),
      const SizedBox(height: 16),
      Text(description, textAlign: TextAlign.center, style: AppTextStyles.button),
    ],
  );
}
