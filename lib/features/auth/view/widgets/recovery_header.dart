import 'package:material_ui/material_ui.dart';

class RecoveryHeader extends StatelessWidget {
  const RecoveryHeader({super.key, required this.step, required this.email});
  final int step;
  final String email;
  @override
  Widget build(BuildContext context) {
    const titles = [
      'هل نسيت كلمة المرور؟',
      'أدخل رمز الاستعادة',
      'كلمة مرور جديدة',
      'انتهت معاينة الاستعادة',
    ];
    const descriptions = [
      'اكتب بريدك الإلكتروني لبدء خطوات الاستعادة',
      'أدخل أي 4 أرقام لتجربة الواجهة فقط',
      'اختر كلمة مرور قوية وأعد كتابتها',
      'لم يتم تغيير كلمة مرور أو إرسال بريد. يمكنك العودة لتسجيل الدخول.',
    ];
    return Column(
      children: [
        Image.asset(
          step == 1 ? 'assets/verification_mail.png' : 'assets/logo.png',
          height: step == 1 ? 180 : 140,
          width: 220,
        ),
        const SizedBox(height: 18),
        Text(
          titles[step],
          textAlign: TextAlign.center,
          style: const TextStyle(fontSize: 24, fontWeight: FontWeight.w800),
        ),
        const SizedBox(height: 12),
        Text(
          descriptions[step],
          textAlign: TextAlign.center,
          style: const TextStyle(fontSize: 14, color: Colors.black54),
        ),
        if (step == 1)
          Text(
            email,
            textDirection: TextDirection.ltr,
            style: const TextStyle(color: Color(0xFF347D1D)),
          ),
        const SizedBox(height: 28),
      ],
    );
  }
}
