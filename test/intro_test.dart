import 'package:zar3a/features/auth/view/recovery_view.dart';
import 'package:zar3a/features/auth/view_model/recovery_cubit.dart';
import 'package:zar3a/features/auth/view/auth_view.dart';
import 'package:zar3a/features/auth/view/verification_view.dart';
import 'package:zar3a/features/auth/view_model/auth_cubit.dart';
import 'package:zar3a/features/auth/view_model/verification_cubit.dart';

import 'dart:async';
import 'dart:io';
import 'dart:ui' as ui;

import 'package:go_router/go_router.dart';
import 'package:material_ui/material_ui.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:zar3a/main.dart';
import 'package:zar3a/injection_container/injection_container.dart';
import 'package:zar3a/features/location/data/data_source/device_location_source.dart';
import 'package:zar3a/features/location/data/model/selected_location.dart';
import 'package:zar3a/features/location/data/repository/location_repository.dart';
import 'package:zar3a/features/location/view_model/location_cubit.dart';
import 'package:zar3a/features/location/view_model/location_state.dart';
import 'package:zar3a/features/location/view/location_view.dart';
import 'package:zar3a/features/onboarding/view_model/onboarding_cubit.dart';
import 'package:zar3a/features/onboarding/view/onboarding_view.dart';
import 'package:zar3a/features/preferences/view_model/preferences_cubit.dart';
import 'package:zar3a/features/preferences/view/preferences_view.dart';
import 'package:zar3a/core/theme/app_theme.dart';

class FakeSource extends DeviceLocationSource {
  Object? failure;
  Completer<IntroLocation>? pending;
  @override
  Future<IntroLocation> current() async {
    if (failure != null) throw failure!;
    return pending?.future ?? IntroLocation(30, 31, 12, DateTime.now());
  }
}

void main() {
  test(
    'Onboarding ViewModel advances through exactly four local items',
    () async {
      final c = OnboardingCubit(AppDependencies().onboarding);
      expect(c.items.length, 4);
      for (var i = 0; i < 10; i++) {
        c.next();
      }
      expect(c.state, 3);
      expect(c.isLast, true);
      await c.close();
    },
  );
  test(
    'Preferences default, valid changes and confirmed location survive finish',
    () async {
      final location = IntroLocation(30, 31, 12, DateTime.now());
      final c = PreferencesCubit(
        AppDependencies().preferences,
        location: location,
      );
      expect(c.state, 2);
      c.select(9);
      expect(c.state, 2);
      c.select(0);
      expect(c.finish().label, c.interests[0]);
      expect(c.finish().location, same(location));
      await c.close();
    },
  );
  test(
    'Location loading, confirmation, rejection, acceptance and skip',
    () async {
      final source = FakeSource()..pending = Completer<IntroLocation>();
      final c = LocationCubit(LocationRepository(source));
      final f = c.detect();
      expect(c.state.status, LocationStatus.loading);
      source.pending!.complete(IntroLocation(30, 31, 10, DateTime.now()));
      await f;
      expect(c.state.status, LocationStatus.confirmation);
      c.reject();
      expect(c.state.status, LocationStatus.initial);
      await c.detect();
      c.accept();
      expect(c.state.status, LocationStatus.accepted);
      c.skip();
      expect(c.state.location, isNull);
      await c.close();
    },
  );
  test('Location failures and timeouts do not create a fake fix', () async {
    for (final failure in [
      const LocationFailure('denied', settings: true),
      TimeoutException('timeout'),
      Exception('offline'),
    ]) {
      final c = LocationCubit(
        LocationRepository(FakeSource()..failure = failure),
      );
      await c.detect();
      expect(c.state.status, LocationStatus.error);
      expect(c.state.location, isNull);
      expect(c.state.failure, isNotNull);
      await c.close();
    }
  });
  test('Completing a request after disposal is safe', () async {
    final source = FakeSource()..pending = Completer<IntroLocation>();
    final c = LocationCubit(LocationRepository(source));
    final f = c.detect();
    await c.close();
    source.pending!.complete(IntroLocation(30, 31, 1, DateTime.now()));
    await f;
  });
  test('Auth validates email, name, password and confirmation without retaining secrets', () async {
    final c = AuthCubit(AppDependencies().auth);
    expect(
      c.submit(
        email: 'bad',
        password: '1',
        name: '',
        confirmation: '2',
        signup: true,
      ),
      false,
    );
    expect(c.state.errors.length, 4);
    expect(
      c.submit(
        email: 'demo@example.com',
        password: 'demo12345',
        name: 'Demo User',
        confirmation: 'demo12345',
        signup: true,
      ),
      true,
    );
    expect(c.state.draft!.email, 'demo@example.com');
    c.togglePassword();
    expect(c.state.passwordVisible, true);
    await c.close();
  });
  test(
    'Verification is format checking only and timer closes cleanly',
    () async {
      final c = VerificationCubit();
      c.update('123');
      expect(c.check(), false);
      c.update('1234');
      expect(c.check(), true);
      expect(c.state.seconds, 45);
      await c.close();
    },
  );
  testWidgets('Sign up shows errors and routes to demo verification', (
    t,
  ) async {
    await t.pumpWidget(MyApp(dependencies: AppDependencies()));
    await t.pump(const Duration(seconds: 4));
    await t.pumpAndSettle();
    final ctx = t.element(find.text('متابعة'));
    Navigator.pushNamed(ctx, '/signup');
    await t.pumpAndSettle();
    await t.tap(find.text('إنشاء الحساب'));
    await t.pumpAndSettle();
    expect(find.text('اكتب الاسم بالكامل'), findsOneWidget);
    final fields = find.byType(TextField);
    await t.enterText(fields.at(0), 'Demo User');
    await t.enterText(fields.at(1), 'demo@example.com');
    await t.enterText(fields.at(2), 'demo12345');
    await t.enterText(fields.at(3), 'demo12345');
    await t.ensureVisible(find.text('إنشاء الحساب'));
    await t.tap(find.text('إنشاء الحساب'));
    await t.pumpAndSettle();
    expect(find.text('تحقق من بريدك الإلكتروني'), findsOneWidget);
    expect(find.text('demo@example.com'), findsOneWidget);
    await t.enterText(find.byKey(const ValueKey('otp_0')), '1234');
    await t.ensureVisible(find.text('تأكيد'));
    await t.tap(find.text('تأكيد'));
    await t.pump();
    expect(
      find.text('هذه معاينة فقط. لم يتم التحقق من الرمز أو تفعيل حساب.'),
      findsOneWidget,
    );
    await t.pumpWidget(const SizedBox());
  });
  test('Recovery local steps validate and never persist a password', () async {
    final c = RecoveryCubit(AppDependencies().auth);
    expect(c.emailNext('bad'), false);
    expect(c.emailNext('demo@example.com'), true);
    expect(c.state.step, 1);
    expect(c.codeNext('1'), false);
    expect(c.codeNext('1234'), true);
    expect(c.save('short', 'short'), false);
    expect(c.save('demo12345', 'other'), false);
    expect(c.save('demo12345', 'demo12345'), true);
    expect(c.state.step, 3);
    await c.close();
  });
  testWidgets('Forgot password navigates through all demo screens', (t) async {
    await t.pumpWidget(MyApp(dependencies: AppDependencies()));
    await t.pump(const Duration(seconds: 4));
    await t.pumpAndSettle();
    Navigator.pushNamed(t.element(find.text('متابعة')), '/login');
    await t.pumpAndSettle();
    await t.ensureVisible(find.text('هل نسيت كلمة المرور؟'));
    await t.tap(find.text('هل نسيت كلمة المرور؟'));
    await t.pumpAndSettle();
    await t.enterText(find.byType(TextField), 'demo@example.com');
    await t.ensureVisible(find.text('متابعة'));
    await t.tap(find.text('متابعة'));
    await t.pumpAndSettle();
    expect(find.text('أدخل رمز الاستعادة'), findsOneWidget);
    await t.enterText(find.byKey(const ValueKey('otp_0')), '1234');
    await t.ensureVisible(find.text('متابعة المعاينة'));
    await t.tap(find.text('متابعة المعاينة'));
    await t.pumpAndSettle();
    await t.enterText(find.byType(TextField).at(0), 'demo12345');
    await t.enterText(find.byType(TextField).at(1), 'demo12345');
    await t.ensureVisible(find.text('حفظ في المعاينة'));
    await t.tap(find.text('حفظ في المعاينة'));
    await t.pumpAndSettle();
    expect(find.text('انتهت معاينة الاستعادة'), findsOneWidget);
    await t.ensureVisible(find.text('العودة لتسجيل الدخول'));
    await t.tap(find.text('العودة لتسجيل الدخول'));
    await t.pumpAndSettle();
    expect(find.text('مرحباً بعودتك'), findsOneWidget);
    await t.pumpWidget(const SizedBox());
  });
  testWidgets('Whole intro navigation and selection work without GPS prompt', (
    t,
  ) async {
    t.view.physicalSize = const Size(390, 844);
    t.view.devicePixelRatio = 1;
    addTearDown(t.view.resetPhysicalSize);
    addTearDown(t.view.resetDevicePixelRatio);
    await t.pumpWidget(MyApp(dependencies: AppDependencies()));
    await t.pump(const Duration(seconds: 4));
    await t.pumpAndSettle();
    expect(find.text('متابعة'), findsOneWidget);
    await t.tap(find.text('تخطي'));
    await t.pumpAndSettle();
    expect(find.text('الوصول إلى موقع الجهاز'), findsOneWidget);
    await t.tap(find.text('المتابعة بدون موقع'));
    await t.pumpAndSettle();
    expect(find.text('اختر ما يناسبك بشكل أفضل'), findsOneWidget);
    await t.tap(find.text('زراعة النباتات المنزلية'));
    await t.tap(find.text('ابدأ الآن'));
    await t.pumpAndSettle();
    expect(find.text('مرحباً بعودتك'), findsOneWidget);
    expect(find.text('تسجيل الدخول'), findsOneWidget);
    expect(t.takeException(), isNull);
  });
  testWidgets('Splash renders its motion, fill and transparent brand', (
    t,
  ) async {
    t.view.physicalSize = const Size(390, 844);
    t.view.devicePixelRatio = 1;
    addTearDown(t.view.resetPhysicalSize);
    addTearDown(t.view.resetDevicePixelRatio);
    final loader = FontLoader('Cairo')
      ..addFont(rootBundle.load('assets/Cairo.ttf'));
    await loader.load();
    final key = GlobalKey();
    await t.pumpWidget(
      RepaintBoundary(
        key: key,
        child: MyApp(dependencies: AppDependencies()),
      ),
    );
    await t.pump();
    var elapsed = 0;
    for (final ms in [0, 650, 1300, 1950, 2500, 3300]) {
      await t.pump(Duration(milliseconds: ms - elapsed));
      elapsed = ms;
      await t.runAsync(() async {
        await Future<void>.delayed(const Duration(milliseconds: 100));
      });
      await t.pump();
      final b =
          key.currentContext!.findRenderObject()! as RenderRepaintBoundary;
      await t.runAsync(() async {
        final im = await b.toImage();
        final data = await im.toByteData(format: ui.ImageByteFormat.png);
        File('previews/splash_$ms.png')
            .writeAsBytesSync(data!.buffer.asUint8List());
      });
      expect(t.takeException(), isNull);
    }
    await t.pumpWidget(const SizedBox());
  });
  testWidgets('Render all content pages at phone size', (t) async {
    t.view.physicalSize = const Size(390, 844);
    t.view.devicePixelRatio = 1;
    addTearDown(t.view.resetPhysicalSize);
    addTearDown(t.view.resetDevicePixelRatio);
    final loader = FontLoader('Cairo')
      ..addFont(rootBundle.load('assets/Cairo.ttf'));
    await loader.load();
    final icons = FontLoader('MaterialIcons')
      ..addFont(rootBundle.load('fonts/MaterialIcons-Regular.otf'));
    await icons.load();
    final deps = AppDependencies();
    Directory('previews').createSync();
    Future<void> capture(Widget page, String name) async {
      final key = GlobalKey();
      await t.pumpWidget(
        MaterialApp(
          theme: buildAppTheme(),
          home: RepaintBoundary(key: key, child: page),
        ),
      );
      await t.pumpAndSettle();
      await t.runAsync(() async {
        await Future<void>.delayed(const Duration(milliseconds: 200));
      });
      await t.pumpAndSettle();
      expect(t.takeException(), isNull);
      final boundary =
          key.currentContext!.findRenderObject()! as RenderRepaintBoundary;
      await t.runAsync(() async {
        final image = await boundary.toImage();
        final data = await image.toByteData(format: ui.ImageByteFormat.png);
        File('previews/$name.png').writeAsBytesSync(data!.buffer.asUint8List());
      });
      await t.pumpWidget(const SizedBox());
    }

    for (var i = 0; i < 4; i++) {
      final c = OnboardingCubit(deps.onboarding);
      for (var n = 0; n < i; n++) {
        c.next();
      }
      await capture(
        BlocProvider.value(value: c, child: const OnboardingView()),
        'onboarding_$i',
      );
      await c.close();
    }
    final l = LocationCubit(LocationRepository(FakeSource()));
    await capture(
      BlocProvider.value(value: l, child: const LocationView()),
      'location',
    );
    await l.close();
    for (final signup in [false, true]) {
      final a = AuthCubit(deps.auth);
      await capture(
        BlocProvider.value(
          value: a,
          child: AuthView(signup: signup),
        ),
        signup ? 'signup' : 'login',
      );
      await a.close();
    }
    for (var step = 0; step < 4; step++) {
      final c = RecoveryCubit(deps.auth);
      if (step > 0) c.emailNext('demo@example.com');
      if (step > 1) c.codeNext('1234');
      if (step > 2) c.save('demo12345', 'demo12345');
      await capture(
        BlocProvider.value(value: c, child: const RecoveryView()),
        'recovery_$step',
      );
      await c.close();
    }
    final v = VerificationCubit();
    await capture(
      BlocProvider.value(value: v, child: const VerificationView()),
      'verification',
    );
    await v.close();
    final p = PreferencesCubit(deps.preferences);
    await capture(
      BlocProvider.value(value: p, child: const PreferencesView()),
      'preferences',
    );
    await p.close();
  });
}
