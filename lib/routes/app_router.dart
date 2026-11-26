
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:material_ui/material_ui.dart';

import 'route_names.dart';
import '../injection_container/injection_container.dart';

// Splash
import '../features/splash/view/splash_view.dart';
import '../features/splash/view_model/splash_cubit.dart';

// Onboarding
import '../features/onboarding/view/onboarding_view.dart';
import '../features/onboarding/view_model/onboarding_cubit.dart';

// Location
import '../features/location/view/location_view.dart';
import '../features/location/view_model/location_cubit.dart';
import '../features/location/data/model/selected_location.dart';

// Preferences
import '../features/preferences/view/preferences_view.dart';
import '../features/preferences/view/ready_view.dart';
import '../features/preferences/view_model/preferences_cubit.dart';
import '../features/preferences/data/model/intro_selection.dart';

// Authentication
import '../features/auth/view/auth_view.dart';
import '../features/auth/view/recovery_view.dart';
import '../features/auth/view/verification_view.dart';
import '../features/auth/view_model/auth_cubit.dart';
import '../features/auth/view_model/recovery_cubit.dart';
import '../features/auth/view_model/verification_cubit.dart';
import '../features/auth/data/model/auth_draft.dart';

GoRouter appRouter(AppDependencies dependencies) {
  return GoRouter(
    initialLocation: RouteNames.splash,

    routes: [
      // Splash
      GoRoute(
        path: RouteNames.splash,
        name: 'splash',
        builder: (context, state) {
          return BlocProvider(
            create: (_) => SplashCubit(),
            child: const SplashView(),
          );
        },
      ),

      // Onboarding
      GoRoute(
        path: RouteNames.onboarding,
        name: 'onboarding',
        builder: (context, state) {
          return BlocProvider(
            create: (_) => OnboardingCubit(dependencies.onboarding),
            child: const OnboardingView(),
          );
        },
      ),

      // Location
      GoRoute(
        path: RouteNames.location,
        name: 'location',
        builder: (context, state) {
          return BlocProvider(
            create: (_) => LocationCubit(dependencies.location),
            child: const LocationView(),
          );
        },
      ),

      // Preferences
      GoRoute(
        path: RouteNames.preferences,
        name: 'preferences',
        builder: (context, state) {
          return BlocProvider(
            create: (_) => PreferencesCubit(
              dependencies.preferences,
              location: state.extra is IntroLocation
                  ? state.extra as IntroLocation
                  : null,
            ),
            child: const PreferencesView(),
          );
        },
      ),

      // Ready
      GoRoute(
        path: RouteNames.ready,
        name: 'ready',
        builder: (context, state) {
          return ReadyView(
            selection: state.extra is IntroSelection
                ? state.extra as IntroSelection
                : null,
          );
        },
      ),

      // Login
      GoRoute(
        path: RouteNames.login,
        name: 'login',
        builder: (context, state) {
          return BlocProvider(
            create: (_) => AuthCubit(dependencies.auth),
            child: const AuthView(),
          );
        },
      ),

      // Signup
      GoRoute(
        path: RouteNames.signup,
        name: 'signup',
        builder: (context, state) {
          return BlocProvider(
            create: (_) => AuthCubit(dependencies.auth),
            child: const AuthView(signup: true),
          );
        },
      ),

      // Recovery
      GoRoute(
        path: RouteNames.recovery,
        name: 'recovery',
        builder: (context, state) {
          return BlocProvider(
            create: (_) => RecoveryCubit(dependencies.auth),
            child: const RecoveryView(),
          );
        },
      ),

      // Verification
      GoRoute(
        path: RouteNames.verification,
        name: 'verification',
        builder: (context, state) {
          return BlocProvider(
            create: (_) => VerificationCubit(),
            child: VerificationView(
              draft: state.extra is AuthDraft
                  ? state.extra as AuthDraft
                  : null,
            ),
          );
        },
      ),
    ],

    errorBuilder: (context, state) {
      return const Scaffold(
        body: Center(
          child: Text('Page Not Found'),
        ),
      );
    },
  );
}
