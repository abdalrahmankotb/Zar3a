import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';

import '../data/repository/location_repository.dart';
import '../data/data_source/device_location_source.dart';
import 'location_state.dart';

class LocationCubit extends Cubit<LocationState> {
  LocationCubit(this.repository) : super(const LocationState());
  final LocationRepository repository;
  Future<void> detect() async {
    if (state.status == LocationStatus.loading) return;
    emit(const LocationState(status: LocationStatus.loading));
    try {
      final result = await repository.current();
      if (!isClosed) {
        emit(
          LocationState(status: LocationStatus.confirmation, location: result),
        );
      }
    } on LocationFailure catch (e) {
      if (!isClosed) {
        emit(LocationState(status: LocationStatus.error, failure: e));
      }
    } on TimeoutException {
      if (!isClosed) {
        emit(
          const LocationState(
            status: LocationStatus.error,
            failure: LocationFailure(
              'تحديد الموقع استغرق وقتا طويلا. حاول مرة أخرى أو تابع بدون موقع.',
            ),
          ),
        );
      }
    } catch (_) {
      if (!isClosed) {
        emit(
          const LocationState(
            status: LocationStatus.error,
            failure: LocationFailure(
              'تعذر تحديد الموقع. تحقق من الإذن وGPS أو تابع بدون موقع.',
            ),
          ),
        );
      }
    }
  }

  void accept() {
    if (state.status == LocationStatus.confirmation) {
      emit(
        LocationState(
          status: LocationStatus.accepted,
          location: state.location,
        ),
      );
    }
  }

  void reject() => emit(const LocationState());
  void skip() => emit(const LocationState(status: LocationStatus.skipped));
  Future<void> openSettings() =>
      repository.openSettings(services: state.failure?.services ?? false);
}
