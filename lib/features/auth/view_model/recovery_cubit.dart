import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';

import '../data/repository/auth_repository.dart';

class RecoveryState {
  const RecoveryState({
    this.step = 0,
    this.email = '',
    this.seconds = 45,
    this.error,
    this.visible = false,
    this.confirmVisible = false,
  });
  final int step, seconds;
  final String email;
  final String? error;
  final bool visible, confirmVisible;
}

// مراحل محلية للعرض، لا تثبت ملكية البريد ولا تغير بيانات حساب.
class RecoveryCubit extends Cubit<RecoveryState> {
  RecoveryCubit(this.repository) : super(const RecoveryState());
  final AuthRepository repository;
  Timer? timer;
  void _set({
    int? step,
    String? email,
    int? seconds,
    String? error,
    bool? visible,
    bool? confirmVisible,
  }) => emit(
    RecoveryState(
      step: step ?? state.step,
      email: email ?? state.email,
      seconds: seconds ?? state.seconds,
      error: error,
      visible: visible ?? state.visible,
      confirmVisible: confirmVisible ?? state.confirmVisible,
    ),
  );
  bool emailNext(String email) {
    if (!RegExp(r'^[^\s@]+@[^\s@]+\.[^\s@]+$').hasMatch(email.trim())) {
      _set(error: 'اكتب بريدا إلكترونيا صحيحا');
      return false;
    }
    _set(step: 1, email: email.trim(), seconds: 45);
    _startTimer();
    return true;
  }

  void _startTimer() {
    timer?.cancel();
    timer = Timer.periodic(const Duration(seconds: 1), (_) {
      if (state.seconds > 0) _set(seconds: state.seconds - 1);
    });
  }

  bool codeNext(String code) {
    if (!RegExp(r'^\d{4}$').hasMatch(code)) {
      _set(error: 'أدخل الأرقام الأربعة لتجربة الشاشة التالية');
      return false;
    }
    timer?.cancel();
    _set(step: 2);
    return true;
  }

  void resend() {
    if (state.seconds == 0) {
      _set(seconds: 45);
      _startTimer();
    }
  }

  bool save(String password, String confirmation) {
    if (password.length < 8) {
      _set(error: 'استخدم 8 أحرف على الأقل');
      return false;
    }
    if (password != confirmation) {
      _set(error: 'كلمتا المرور غير متطابقتين');
      return false;
    }
    _set(step: 3);
    return true;
  }

  String get notice => repository.recoveryPreview().message;
  void toggle({bool confirm = false}) => _set(
    visible: confirm ? state.visible : !state.visible,
    confirmVisible: confirm ? !state.confirmVisible : state.confirmVisible,
  );
  void back() {
    if (state.step > 0) {
      timer?.cancel();
      _set(step: state.step - 1);
      if (state.step == 1) _startTimer();
    }
  }

  @override
  Future<void> close() {
    timer?.cancel();
    return super.close();
  }
}
