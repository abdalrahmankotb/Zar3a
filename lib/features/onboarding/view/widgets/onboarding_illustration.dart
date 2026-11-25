import 'package:material_ui/material_ui.dart';

class OnboardingIllustration extends StatelessWidget {
  const OnboardingIllustration({
    super.key,
    required this.image,
    required this.height,
  });
  final String image;
  final double height;
  @override
  Widget build(BuildContext context) => SizedBox(
    height: height,
    width: double.infinity,
    child: Image.asset(
      image,
      fit: BoxFit.contain,
      filterQuality: FilterQuality.high,
    ),
  );
}
