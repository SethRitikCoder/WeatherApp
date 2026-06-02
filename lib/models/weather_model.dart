class WeatherModel {
  final CoordModel? coord;
  final List<WeatherInfo?> weather;
  final String? base;
  final MainModel? main;
  final int? visibility;
  final WindModel? wind;
  final CloudsModel? clouds;
  final int? dt;
  final SysModel? sys;
  final int? timezone;
  final int? id;
  final String? name;
  final int? cod;
  WeatherModel({
    required this.coord,
    required this.weather,
    required this.base,
    required this.main,
    required this.visibility,
    required this.wind,
    required this.clouds,
    required this.dt,
    required this.sys,
    required this.timezone,
    required this.id,
    required this.name,
    required this.cod,
  });
  factory WeatherModel.fromJson(Map<String, dynamic> json) {
    return WeatherModel(
      coord: CoordModel.fromJson(json["coord"]),
      weather: (json["weather"] as List)
          .map((e) => WeatherInfo.fromJson(e))
          .toList(),
      base: json["base"],
      main: MainModel.fromJson(json["main"]),
      visibility: json["visibility"],
      wind: WindModel.fromJson(json["wind"]),
      clouds: CloudsModel.fromJson(json["clouds"]),
      dt: json["dt"],
      sys: SysModel.fromJson(json["sys"]),
      timezone: json["timezone"],
      id: json["id"],
      name: json["name"],
      cod: json["cod"],
    );
  }
}

class CoordModel {
  final double lon;
  final double lat;

  CoordModel({required this.lon, required this.lat});
  factory CoordModel.fromJson(Map<String, dynamic> json) {
    return CoordModel(lon: json["lon"].toDouble(), lat: json["lat"].toDouble());
  }
}

class WeatherInfo {
  final int id;
  final String main;
  final String description;
  final String icon;

  WeatherInfo({
    required this.id,
    required this.main,
    required this.description,
    required this.icon,
  });

  factory WeatherInfo.fromJson(Map<String, dynamic> json) {
    return WeatherInfo(
      id: json["id"],
      main: json["main"],
      description: json["description"],
      icon: json["icon"],
    );
  }
}

class MainModel {
  final double temp;
  final double feelsLike;
  final double tempMin;
  final double tempMax;
  final int pressure;
  final int humidity;
  final int? seaLevel;
  final int? grndLevel;

  MainModel({
    required this.temp,
    required this.feelsLike,
    required this.tempMin,
    required this.tempMax,

    required this.pressure,
    required this.humidity,
    required this.seaLevel,
    required this.grndLevel,
  });
  factory MainModel.fromJson(Map<String, dynamic> json) {
    return MainModel(
      temp: json["temp"].toDouble(),
      feelsLike: json["feels_like"].toDouble(),
      tempMax: json["temp_max"].toDouble(),
      tempMin: json["temp_min"].toDouble(),
      pressure: json["pressure"],
      humidity: json["humidity"],
      seaLevel: json["sea_level"],
      grndLevel: json["grnd_level"],
    );
  }
}

class WindModel {
  final double speed;
  final int? deg;
  final double? gust;
  WindModel({required this.speed, required this.deg, this.gust});

  factory WindModel.fromJson(Map<String, dynamic> json) {
    return WindModel(speed: json["speed"].toDouble(), deg: json["deg"]);
  }
}

class CloudsModel {
  final int all;
  CloudsModel({required this.all});
  factory CloudsModel.fromJson(Map<String, dynamic> json) {
    return CloudsModel(all: json["all"]);
  }
}

class SysModel {
  final int? type;
  final int? id;
  final String country;
  final int? sunrise;
  final int? sunset;
  SysModel({
    required this.type,
    required this.id,
    required this.country,
    required this.sunrise,
    required this.sunset,
  });

  factory SysModel.fromJson(Map<String, dynamic> json) {
    return SysModel(
      type: json['type'],
      id: json['id'],
      country: json['country'],
      sunrise: json['sunrise'] ?? "No Data",
      sunset: json['sunset'] ?? "No  Data",
    );
  }
}
