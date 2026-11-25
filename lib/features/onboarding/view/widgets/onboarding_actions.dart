import 'package:material_ui/material_ui.dart';

import '../../../../core/widgets/app_button.dart';

class OnboardingActions extends StatelessWidget {
  const OnboardingActions({
    super.key,
    required this.onNext,
    required this.onSkip,
  });
  final VoidCallback onNext, onSkip;
  @override
  Widget build(BuildContext context) => Column(
    children: [
      AppButton(text: 'متابعة', onPressed: onNext),
      TextButton(
        onPressed: onSkip,
        child: const Text(
          'تخطي',
          style: TextStyle(
            color: Colors.black,
            fontSize: 16,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    ],
  );
}
