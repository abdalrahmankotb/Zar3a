import '../model/auth_preview_result.dart';

// استبدل هذا المصدر لاحقا بمصدر الفريق. لا نحتفظ بكلمات المرور هنا.
class AuthDemoSource {
  AuthPreviewResult recoveryPreview() => const AuthPreviewResult(
    'معاينة محلية فقط. لم يُرسل رمز ولم تتغير كلمة مرور أي حساب.',
  );
  AuthPreviewResult previewProvider(String provider) =>
      AuthPreviewResult('تسجيل $provider غير مربوط في نسخة المعاينة');
  AuthPreviewResult previewReset() => const AuthPreviewResult(
    'استعادة كلمة المرور تحتاج ربط خدمة المصادقة أولا',
  );
  String get notice => 'معاينة الواجهة فقط: لم يتم إرسال بريد أو إنشاء حساب.';
}
