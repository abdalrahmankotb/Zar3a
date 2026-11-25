// API إضافية: geolocator لقراءة GPS. async/await وtry/catch موجودة في منهجك.
// لا تجمع موقعا في الخلفية ولا ترسله لخادم.
import 'package:flutter/foundation.dart';
import 'package:geolocator/geolocator.dart';

import '../model/selected_location.dart';

class LocationFailure implements Exception {
  const LocationFailure(
    this.message, {
    this.settings = false,
    this.services = false,
  });
  final String message;
  final bool settings, services;
}

class DeviceLocationSource {
  Future<IntroLocation> current() async {
    if (!await Geolocator.isLocationServiceEnabled()) {
      throw const LocationFailure(
        'خدمة الموقع مقفولة. افتحها من إعدادات الجهاز وحاول مرة أخرى.',
        services: true,
      );
    }
    var permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
    }
    if (permission == LocationPermission.deniedForever) {
      throw const LocationFailure(
        'إذن الموقع مرفوض من الإعدادات. يمكنك السماح به أو المتابعة بدونه.',
        settings: true,
      );
    }
    if (permission == LocationPermission.denied) {
      throw const LocationFailure(
        'لم تسمح بالوصول للموقع. يمكنك المحاولة مرة أخرى أو المتابعة بدونه.',
      );
    }
    final p = await Geolocator.getCurrentPosition(
      locationSettings: const LocationSettings(
        accuracy: LocationAccuracy.high,
        timeLimit: Duration(seconds: 25),
      ),
    );
    if (DateTime.now().difference(p.timestamp).inMinutes >= 2) {
      throw const LocationFailure('وصل موقع قديم. حاول تحديد موقعك من جديد.');
    }
    return IntroLocation(p.latitude, p.longitude, p.accuracy, p.timestamp);
  }

  Future<void> openSettings({bool services = false}) async {
    if (kIsWeb) return;
    if (services) {
      await Geolocator.openLocationSettings();
    } else {
      await Geolocator.openAppSettings();
    }
  }
}
