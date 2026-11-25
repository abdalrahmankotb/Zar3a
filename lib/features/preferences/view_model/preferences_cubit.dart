import 'package:flutter_bloc/flutter_bloc.dart';

import '../data/repository/preferences_repository.dart';
import '../data/model/intro_selection.dart';
import '../../location/data/model/selected_location.dart';

class PreferencesCubit extends Cubit<int> {
  PreferencesCubit(this.repository, {this.location}) : super(2);
  final PreferencesRepository repository;
  final IntroLocation? location;
  List<String> get interests => repository.getInterests();
  void select(int index) {
    if (index >= 0 && index < interests.length) emit(index);
  }

  IntroSelection finish() => IntroSelection(
    interest: state,
    label: interests[state],
    location: location,
  );
}
