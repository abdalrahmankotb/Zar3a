import '../data_source/auth_demo_source.dart';
import '../model/auth_preview_result.dart';

class AuthRepository {
  AuthPreviewResult recoveryPreview() => source.recoveryPreview();
  AuthRepository(this.source);
  final AuthDemoSource source;
  String get notice => source.notice;
  AuthPreviewResult previewProvider(String provider) =>
      source.previewProvider(provider);
  AuthPreviewResult previewReset() => source.previewReset();
}
