import '../../../location/data/model/selected_location.dart';

class IntroSelection {
  const IntroSelection({
    required this.interest,
    required this.label,
    this.location,
  });
  final int interest;
  final String label;
  final IntroLocation? location;
}
