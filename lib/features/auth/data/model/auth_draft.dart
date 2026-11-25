// بيانات العرض المؤقتة فقط، لا نخزن كلمة المرور أو ننقلها للـ verification.
class AuthDraft {
  const AuthDraft({required this.email, this.name = ''});
  final String email, name;
}
