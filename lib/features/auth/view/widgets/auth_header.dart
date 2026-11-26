import 'package:material_ui/material_ui.dart';

class AuthHeader extends StatelessWidget {
  const AuthHeader({super.key, required this.signup});
  final bool signup;
  @override
  Widget build(BuildContext context) => Column(
    children: [
      Image.asset(
        'assets/photos/logo.png',
        width: signup ? 125 : 150,
        height: signup ? 125 : 150,
      ),
      Text(
        signup ? 'إنشاء حساب جديد' : 'مرحباً بعودتك',
        style: const TextStyle(fontSize: 25, fontWeight: FontWeight.w800),
      ),
      Text(
        signup ? 'أنشئ حسابك واستمتع' : 'لنكمل معاً رحلتك\nالخضراء',
        textAlign: TextAlign.center,
        style: const TextStyle(
          fontSize: 16,
          color: Colors.black54,
          height: 1.5,
        ),
      ),
      const SizedBox(height: 16),
    ],
  );
}
