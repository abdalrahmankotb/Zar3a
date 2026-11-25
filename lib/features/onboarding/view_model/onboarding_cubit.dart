import 'package:flutter_bloc/flutter_bloc.dart';

import '../data/model/onboarding_item.dart';
import '../data/repository/onboarding_repository.dart';

// ViewModel: يعرف رقم الصفحة ويتعامل مع الضغط، دون Widgets أو BuildContext.
class OnboardingCubit extends Cubit<int> {
  OnboardingCubit(this.repository) : super(0);
  final OnboardingRepository repository;
  List<OnboardingItem> get items => repository.getItems();
  void next() {
    if (state < items.length - 1) emit(state + 1);
  }

  bool get isLast => state == items.length - 1;
}
