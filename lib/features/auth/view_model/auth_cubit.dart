import 'package:flutter_bloc/flutter_bloc.dart';

import '../data/model/auth_draft.dart';
import '../data/repository/auth_repository.dart';

class AuthState {
  const AuthState({
    this.passwordVisible = false,
    this.confirmVisible = false,
    this.errors = const {},
    this.draft,
  });
  final bool passwordVisible, confirmVisible;
  final Map<String, String> errors;
  final AuthDraft? draft;
}

class AuthCubit extends Cubit<AuthState> {
  AuthCubit(this.repository) : super(const AuthState());
  final AuthRepository repository;
  String previewProvider(String provider) =>
      repository.previewProvider(provider).message;
  String previewReset() => repository.previewReset().message;
  void togglePassword({bool confirm = false}) => emit(
    AuthState(
      passwordVisible: confirm ? state.passwordVisible : !state.passwordVisible,
      confirmVisible: confirm ? !state.confirmVisible : state.confirmVisible,
      errors: state.errors,
    ),
  );
  bool submit({
    required String email,
    required String password,
    String name = '',
    String confirmation = '',
    bool signup = false,
  }) {
    final errors = <String, String>{};
    if (signup && name.trim().length < 2) errors['name'] = 'اكتب الاسم بالكامل';
    if (!RegExp(r'^[^\s@]+@[^\s@]+\.[^\s@]+$').hasMatch(email.trim())) {
      errors['email'] = 'اكتب بريدا إلكترونيا صحيحا';
    }
    if (password.length < 8) errors['password'] = 'استخدم 8 أحرف على الأقل';
    if (signup && confirmation != password) {
      errors['confirmation'] = 'كلمتا المرور غير متطابقتين';
    }
    emit(
      AuthState(
        passwordVisible: state.passwordVisible,
        confirmVisible: state.confirmVisible,
        errors: errors,
        draft: errors.isEmpty
            ? AuthDraft(email: email.trim(), name: name.trim())
            : null,
      ),
    );
    return errors.isEmpty;
  }
}
