import '../data/model/selected_location.dart';
import '../data/data_source/device_location_source.dart';

enum LocationStatus { initial, loading, confirmation, accepted, skipped, error }

class LocationState {
  const LocationState({
    this.status = LocationStatus.initial,
    this.location,
    this.failure,
  });
  final LocationStatus status;
  final IntroLocation? location;
  final LocationFailure? failure;
}
