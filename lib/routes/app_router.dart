import '../features/auth/view/recovery_view.dart';
import '../features/auth/view_model/recovery_cubit.dart';
import '../features/auth/view/auth_view.dart';
import '../features/auth/view/verification_view.dart';
import '../features/auth/view_model/auth_cubit.dart';
import '../features/auth/view_model/verification_cubit.dart';
import '../features/auth/data/model/auth_draft.dart';

import 'package:material_ui/material_ui.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'route_names.dart';
import '../injection_container/injection_container.dart';
import '../features/splash/view/splash_view.dart';
import '../features/splash/view_model/splash_cubit.dart';
import '../features/onboarding/view/onboarding_view.dart';
import '../features/onboarding/view_model/onboarding_cubit.dart';
import '../features/location/view/location_view.dart';
import '../features/location/view_model/location_cubit.dart';
import '../features/location/data/model/selected_location.dart';
import '../features/preferences/view/preferences_view.dart';
import '../features/preferences/view/ready_view.dart';
import '../features/preferences/view_model/preferences_cubit.dart';
import '../features/preferences/data/model/intro_selection.dart';

// Navigator وMaterialPageRoute من درس التنقل، دون go_router.
Route<dynamic> buildRoute(
  RouteSettings settings,
  AppDependencies dependencies,
) {
  Widget page;
  switch (settings.name) {
    case RouteNames.recovery:
      page = BlocProvider(
        create: (_) => RecoveryCubit(dependencies.auth),
        child: const RecoveryView(),
      );
      break;
    case RouteNames.login:
      page = BlocProvider(
        create: (_) => AuthCubit(dependencies.auth),
        child: const AuthView(),
      );
      break;
    case RouteNames.signup:
      page = BlocProvider(
        create: (_) => AuthCubit(dependencies.auth),
        child: const AuthView(signup: true),
      );
      break;
    case RouteNames.verification:
      page = BlocProvider(
        create: (_) => VerificationCubit(),
        child: VerificationView(
          draft: settings.arguments is AuthDraft
              ? settings.arguments as AuthDraft
              : null,
        ),
      );
      break;
    case RouteNames.onboarding:
      page = BlocProvider(
        create: (_) => OnboardingCubit(dependencies.onboarding),
        child: const OnboardingView(),
      );
      break;
    case RouteNames.location:
      page = BlocProvider(
        create: (_) => LocationCubit(dependencies.location),
        child: const LocationView(),
      );
      break;
    case RouteNames.preferences:
      page = BlocProvider(
        create: (_) => PreferencesCubit(
          dependencies.preferences,
          location: settings.arguments is IntroLocation
              ? settings.arguments as IntroLocation
              : null,
        ),
        child: const PreferencesView(),
      );
      break;
    case RouteNames.ready:
      page = ReadyView(
        selection: settings.arguments is IntroSelection
            ? settings.arguments as IntroSelection
            : null,
      );
      break;
    default:
      page = BlocProvider(
        create: (_) => SplashCubit(),
        child: const SplashView(),
      );
  }
  return MaterialPageRoute(settings: settings, builder: (_) => page);
}
