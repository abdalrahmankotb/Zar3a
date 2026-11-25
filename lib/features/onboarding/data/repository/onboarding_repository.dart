import '../data_source/onboarding_local_source.dart';
import '../model/onboarding_item.dart';

class OnboardingRepository {
  OnboardingRepository(this.source);
  final OnboardingLocalSource source;
  List<OnboardingItem> getItems() => source.getItems();
}
