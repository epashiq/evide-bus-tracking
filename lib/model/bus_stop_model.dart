class BusStop {
  final String stopname;
  final double latitude;
  final double longitude;
  final int timedifference;
  final String? stopTime;
  bool isFavorite;

  BusStop({
    required this.stopname,
    required this.latitude,
    required this.longitude,
    required this.timedifference,
    this.stopTime,
    this.isFavorite = false,
  });

  factory BusStop.fromJson(Map<String, dynamic> json) {
    return BusStop(
      stopname: json['stopname'] ?? '',
      latitude: (json['latitude'] ?? 0.0).toDouble(),
      longitude: (json['longitude'] ?? 0.0).toDouble(),
      timedifference: json['timedifference'] ?? 0,
      stopTime: json['stopTime'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'stopname': stopname,
      'latitude': latitude,
      'longitude': longitude,
      'timedifference': timedifference,
      'stopTime': stopTime,
    };
  }

  String get shortDescription {
    return 'Lat: ${latitude.toStringAsFixed(4)}, Lng: ${longitude.toStringAsFixed(4)}';
  }

  String get estimatedArrival {
    final now = DateTime.now();
    final arrival = now.add(Duration(minutes: timedifference));
    return '${arrival.hour.toString().padLeft(2, '0')}:${arrival.minute.toString().padLeft(2, '0')}';
  }

  BusStop copyWith({
    String? stopname,
    double? latitude,
    double? longitude,
    int? timedifference,
    String? stopTime,
    bool? isFavorite,
  }) {
    return BusStop(
      stopname: stopname ?? this.stopname,
      latitude: latitude ?? this.latitude,
      longitude: longitude ?? this.longitude,
      timedifference: timedifference ?? this.timedifference,
      stopTime: stopTime ?? this.stopTime,
      isFavorite: isFavorite ?? this.isFavorite,
    );
  }
}