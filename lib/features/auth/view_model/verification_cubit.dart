import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';

class VerificationState {
  const VerificationState({this.seconds = 45, this.code = '', this.error});
  final int seconds;
  final String code;
  final String? error;
}

class VerificationCubit extends Cubit<VerificationState> {
  VerificationCubit() : super(const VerificationState()) {
    timer = Timer.periodic(const Duration(seconds: 1), (_) {
      if (state.seconds > 0) {
        emit(
          VerificationState(
            seconds: state.seconds - 1,
            code: state.code,
            error: state.error,
          ),
        );
      }
    });
  }
  late final Timer timer;
  void update(String code) =>
      emit(VerificationState(seconds: state.seconds, code: code));
  bool check() {
    if (!RegExp(r'^\d{4}$').hasMatch(state.code)) {
      emit(
        VerificationState(
          seconds: state.seconds,
          code: state.code,
          error: 'أدخل الأرقام الأربعة',
        ),
      );
      return false;
    }
    return true;
  }

  void resendPreview() {
    if (state.seconds == 0) emit(VerificationState(code: state.code));
  }

  @override
  Future<void> close() {
    timer.cancel();
    return super.close();
  }
}
