import '../features/auth/data/data_source/auth_demo_source.dart';
import '../features/auth/data/repository/auth_repository.dart';
// تجميع الاعتماديات في مكان واحد، دون حزمة DI إضافية.
import '../features/onboarding/data/data_source/onboarding_local_source.dart';
import '../features/onboarding/data/repository/onboarding_repository.dart';
import '../features/location/data/data_source/device_location_source.dart';
import '../features/location/data/repository/location_repository.dart';
import '../features/preferences/data/data_source/preferences_local_source.dart';
import '../features/preferences/data/repository/preferences_repository.dart';

class AppDependencies {
  final auth = AuthRepository(AuthDemoSource());
  final onboarding = OnboardingRepository(OnboardingLocalSource());
  final location = LocationRepository(DeviceLocationSource());
  final preferences = PreferencesRepository(PreferencesLocalSource());
}
