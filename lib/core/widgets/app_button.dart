import 'package:material_ui/material_ui.dart';

import '../theme/app_text_styles.dart';

// زر مشترك لكل الفيتشرز، وليس خاصا بميزة واحدة.
class AppButton extends StatelessWidget {
  const AppButton({
    super.key,
    required this.text,
    required this.onPressed,
    this.color = const Color(0xFF4DA534),
  });
  final String text;
  final VoidCallback? onPressed;
  final Color color;
  @override
  Widget build(BuildContext context) => SizedBox(
    width: double.infinity,
    height: 48,
    child: FilledButton(
      style: FilledButton.styleFrom(
        backgroundColor: color,
        foregroundColor: Colors.white,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(7)),
      ),
      onPressed: onPressed,
      child: Text(text, style: AppTextStyles.button),
    ),
  );
}
