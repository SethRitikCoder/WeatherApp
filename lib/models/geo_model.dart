class GeoModel {
  final String? name;
  final double? lat;
  final double? lon;
  final String? country;
  final String? state;

  GeoModel({
    required this.name,
    required this.lat,
    required this.lon,
    required this.country,
    required this.state,
  });

  factory GeoModel.fromjson(Map<String, dynamic> json) {
    return GeoModel(
      name: json["name"],
      lat: json["lat"].toDouble(),
      lon: json["lon"].toDouble(),
      country: json["country"],
      state: json["state"],
    );
  }
}
