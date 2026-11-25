import '../data_source/device_location_source.dart';
import '../model/selected_location.dart';

class LocationRepository {
  LocationRepository(this.source);
  final DeviceLocationSource source;
  Future<IntroLocation> current() => source.current();
  Future<void> openSettings({bool services = false}) =>
      source.openSettings(services: services);
}
