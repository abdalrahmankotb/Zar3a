import 'package:flutter_bloc/flutter_bloc.dart';

// الحالة تتحول عند انتهاء الحركة. AnimationController يبقى في View لأنه مرتبط بالرسم وvsync.
class SplashCubit extends Cubit<bool> {
  SplashCubit() : super(false);
  void finish() => emit(true);
}
