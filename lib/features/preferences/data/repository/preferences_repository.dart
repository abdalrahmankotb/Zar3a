import '../data_source/preferences_local_source.dart';

class PreferencesRepository {
  PreferencesRepository(this.source);
  final PreferencesLocalSource source;
  List<String> getInterests() => source.getInterests();
}
