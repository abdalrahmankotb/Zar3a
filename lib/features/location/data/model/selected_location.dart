class IntroLocation {
  const IntroLocation(
    this.latitude,
    this.longitude,
    this.accuracy,
    this.timestamp,
  );
  final double latitude, longitude, accuracy;
  final DateTime timestamp;
}
