// نتيجة صريحة للمعاينة، لا تعني أن المستخدم مسجل أو موثّق.
class AuthPreviewResult {
  const AuthPreviewResult(this.message);
  final String message;
  bool get authenticated => false;
}
