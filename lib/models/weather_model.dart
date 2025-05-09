import 'dart:convert';

//TODO: write comments for how this works

Weather weatherFromJson(String str) => Weather.fromJson(json.decode(str));

String weatherToJson(Weather data) => json.encode(data.toJson());

class Weather {
    double lat;
    double lon;
    String timezone;
    int timezoneOffset;
    Current current;
    List<Current> hourly;
    List<Daily> daily;

    Weather({
        required this.lat,
        required this.lon,
        required this.timezone,
        required this.timezoneOffset,
        required this.current,
        required this.hourly,
        required this.daily,
    });

    factory Weather.fromJson(Map<String, dynamic> json) => Weather(
        lat: json["lat"]?.toDouble(),
        lon: json["lon"]?.toDouble(),
        timezone: json["timezone"],
        timezoneOffset: json["timezone_offset"],
        current: Current.fromJson(json["current"]),
        hourly: List<Current>.from(json["hourly"].map((x) => Current.fromJson(x))),
        daily: List<Daily>.from(json["daily"].map((x) => Daily.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "lat": lat,
        "lon": lon,
        "timezone": timezone,
        "timezone_offset": timezoneOffset,
        "current": current.toJson(),
        "hourly": List<dynamic>.from(hourly.map((x) => x.toJson())),
        "daily": List<dynamic>.from(daily.map((x) => x.toJson())),
    };
}

class Current {
    int dt;
    int? sunrise;
    int? sunset;
    double temp;
    double feelsLike;
    int pressure;
    int humidity;
    double dewPoint;
    double uvi;
    int clouds;
    int visibility;
    double windSpeed;
    int windDeg;
    List<WeatherElement> weather;
    double? windGust;
    int? pop;

    Current({
        required this.dt,
        this.sunrise,
        this.sunset,
        required this.temp,
        required this.feelsLike,
        required this.pressure,
        required this.humidity,
        required this.dewPoint,
        required this.uvi,
        required this.clouds,
        required this.visibility,
        required this.windSpeed,
        required this.windDeg,
        required this.weather,
        this.windGust,
        this.pop,
    });

    factory Current.fromJson(Map<String, dynamic> json) => Current(
        dt: json["dt"],
        sunrise: json["sunrise"],
        sunset: json["sunset"],
        temp: json["temp"]?.toDouble(),
        feelsLike: json["feels_like"]?.toDouble(),
        pressure: json["pressure"],
        humidity: json["humidity"],
        dewPoint: json["dew_point"]?.toDouble(),
        uvi: json["uvi"]?.toDouble(),
        clouds: json["clouds"],
        visibility: json["visibility"],
        windSpeed: json["wind_speed"]?.toDouble(),
        windDeg: json["wind_deg"],
        weather: List<WeatherElement>.from(json["weather"].map((x) => WeatherElement.fromJson(x))),
        windGust: json["wind_gust"]?.toDouble(),
        pop: json["pop"],
    );

    Map<String, dynamic> toJson() => {
        "dt": dt,
        "sunrise": sunrise,
        "sunset": sunset,
        "temp": temp,
        "feels_like": feelsLike,
        "pressure": pressure,
        "humidity": humidity,
        "dew_point": dewPoint,
        "uvi": uvi,
        "clouds": clouds,
        "visibility": visibility,
        "wind_speed": windSpeed,
        "wind_deg": windDeg,
        "weather": List<dynamic>.from(weather.map((x) => x.toJson())),
        "wind_gust": windGust,
        "pop": pop,
    };
}

class WeatherElement {
    int id;
    Main main;
    Description description;
    String icon;

    WeatherElement({
        required this.id,
        required this.main,
        required this.description,
        required this.icon,
    });

    factory WeatherElement.fromJson(Map<String, dynamic> json) => WeatherElement(
        id: json["id"],
        main: mainValues.map[json["main"]]!,
        description: descriptionValues.map[json["description"]]!,
        icon: json["icon"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "main": mainValues.reverse[main],
        "description": descriptionValues.reverse[description],
        "icon": icon,
    };
}

enum Description {
    BROKEN_CLOUDS,
    CLEAR_SKY,
    FEW_CLOUDS,
    LIGHT_RAIN,
    OVERCAST_CLOUDS,
    SCATTERED_CLOUDS
}

final descriptionValues = EnumValues({
    "broken clouds": Description.BROKEN_CLOUDS,
    "clear sky": Description.CLEAR_SKY,
    "few clouds": Description.FEW_CLOUDS,
    "light rain": Description.LIGHT_RAIN,
    "overcast clouds": Description.OVERCAST_CLOUDS,
    "scattered clouds": Description.SCATTERED_CLOUDS
});

enum Main {
    CLEAR,
    CLOUDS,
    RAIN
}

final mainValues = EnumValues({
    "Clear": Main.CLEAR,
    "Clouds": Main.CLOUDS,
    "Rain": Main.RAIN
});

class Daily {
    int dt;
    int sunrise;
    int sunset;
    int moonrise;
    int moonset;
    double moonPhase;
    String summary;
    Temp temp;
    FeelsLike feelsLike;
    int pressure;
    int humidity;
    double dewPoint;
    double windSpeed;
    int windDeg;
    double windGust;
    List<WeatherElement> weather;
    int clouds;
    double pop;
    double uvi;
    double? rain;

    Daily({
        required this.dt,
        required this.sunrise,
        required this.sunset,
        required this.moonrise,
        required this.moonset,
        required this.moonPhase,
        required this.summary,
        required this.temp,
        required this.feelsLike,
        required this.pressure,
        required this.humidity,
        required this.dewPoint,
        required this.windSpeed,
        required this.windDeg,
        required this.windGust,
        required this.weather,
        required this.clouds,
        required this.pop,
        required this.uvi,
        this.rain,
    });

    factory Daily.fromJson(Map<String, dynamic> json) => Daily(
        dt: json["dt"],
        sunrise: json["sunrise"],
        sunset: json["sunset"],
        moonrise: json["moonrise"],
        moonset: json["moonset"],
        moonPhase: json["moon_phase"]?.toDouble(),
        summary: json["summary"],
        temp: Temp.fromJson(json["temp"]),
        feelsLike: FeelsLike.fromJson(json["feels_like"]),
        pressure: json["pressure"],
        humidity: json["humidity"],
        dewPoint: json["dew_point"]?.toDouble(),
        windSpeed: json["wind_speed"]?.toDouble(),
        windDeg: json["wind_deg"],
        windGust: json["wind_gust"]?.toDouble(),
        weather: List<WeatherElement>.from(json["weather"].map((x) => WeatherElement.fromJson(x))),
        clouds: json["clouds"],
        pop: json["pop"]?.toDouble(),
        uvi: json["uvi"]?.toDouble(),
        rain: json["rain"]?.toDouble(),
    );

    Map<String, dynamic> toJson() => {
        "dt": dt,
        "sunrise": sunrise,
        "sunset": sunset,
        "moonrise": moonrise,
        "moonset": moonset,
        "moon_phase": moonPhase,
        "summary": summary,
        "temp": temp.toJson(),
        "feels_like": feelsLike.toJson(),
        "pressure": pressure,
        "humidity": humidity,
        "dew_point": dewPoint,
        "wind_speed": windSpeed,
        "wind_deg": windDeg,
        "wind_gust": windGust,
        "weather": List<dynamic>.from(weather.map((x) => x.toJson())),
        "clouds": clouds,
        "pop": pop,
        "uvi": uvi,
        "rain": rain,
    };
}

class FeelsLike {
    double day;
    double night;
    double eve;
    double morn;

    FeelsLike({
        required this.day,
        required this.night,
        required this.eve,
        required this.morn,
    });

    factory FeelsLike.fromJson(Map<String, dynamic> json) => FeelsLike(
        day: json["day"]?.toDouble(),
        night: json["night"]?.toDouble(),
        eve: json["eve"]?.toDouble(),
        morn: json["morn"]?.toDouble(),
    );

    Map<String, dynamic> toJson() => {
        "day": day,
        "night": night,
        "eve": eve,
        "morn": morn,
    };
}

class Temp {
    double day;
    double min;
    double max;
    double night;
    double eve;
    double morn;

    Temp({
        required this.day,
        required this.min,
        required this.max,
        required this.night,
        required this.eve,
        required this.morn,
    });

    factory Temp.fromJson(Map<String, dynamic> json) => Temp(
        day: json["day"]?.toDouble(),
        min: json["min"]?.toDouble(),
        max: json["max"]?.toDouble(),
        night: json["night"]?.toDouble(),
        eve: json["eve"]?.toDouble(),
        morn: json["morn"]?.toDouble(),
    );

    Map<String, dynamic> toJson() => {
        "day": day,
        "min": min,
        "max": max,
        "night": night,
        "eve": eve,
        "morn": morn,
    };
}

class EnumValues<T> {
    Map<String, T> map;
    late Map<T, String> reverseMap;

    EnumValues(this.map);

    Map<T, String> get reverse {
            reverseMap = map.map((k, v) => MapEntry(v, k));
            return reverseMap;
    }
}