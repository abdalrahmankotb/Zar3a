import 'package:zar3a/features/auth/data/data_source/auth_demo_source.dart';
import 'package:zar3a/features/auth/data/repository/auth_repository.dart';
import 'package:zar3a/features/location/data/data_source/device_location_source.dart';
import 'package:zar3a/features/location/data/repository/location_repository.dart';
import 'package:zar3a/features/onboarding/data/data_source/onboarding_local_source.dart';
import 'package:zar3a/features/onboarding/data/repository/onboarding_repository.dart';
import 'package:zar3a/features/preferences/data/data_source/preferences_local_source.dart';
import 'package:zar3a/features/preferences/data/repository/preferences_repository.dart';

class AppDependencies {
  final AuthRepository auth;
  final OnboardingRepository onboarding;
  final LocationRepository location;
  final PreferencesRepository preferences;

  AppDependencies()
      : auth = AuthRepository(AuthDemoSource()),
        onboarding = OnboardingRepository(OnboardingLocalSource()),
        location = LocationRepository(DeviceLocationSource()),
        preferences = PreferencesRepository(PreferencesLocalSource());
}