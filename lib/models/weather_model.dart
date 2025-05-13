//generated using QuickType. both a blessing and a curse.
//TODO: write comments for what all the fields are (in progress)

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
        timezoneOffset: json["timezone_offset"] * 1000, //the api returns all time as int from epoch start but smaller by 1000 times (why?)
        current: Current.fromJson(json["current"]),
        hourly: List<Current>.from(json["hourly"].map((x) => Current.fromJson(x))),
        daily: List<Daily>.from(json["daily"].map((x) => Daily.fromJson(x))),
    );
}

class Current {
    int date;
    int? sunrise; //timestamp for sunrise
    int? sunset; //timestamp for sunset
    double temp;
    double feelsLike;
    int pressure;
    int humidity;
    double dewPoint; //the temperature the air needs to be cooled to in order to achieve a relative humidity of 100%
    double uvi; //ultraviolet index
    int clouds; //percentage value of sky coverage by clouds
    int visibility; //in meters
    double windSpeed; 
    int windDeg; //wind direction in degrees
    List<WeatherElement> weather;
    double? windGust; //highest recorded wind speed in a short duration
    double? pop; //probability of precipitation - percentage value chance of rain

    Current({
        required this.date,
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
        date: json["dt"] * 1000,
        sunrise: json["sunrise"] != null ? json["sunrise"] * 1000 : null, //the api returns this time as nullable int here so have to do this check
        sunset: json["sunset"] != null ? json["sunset"] * 1000 : null, //same here as above
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
        pop: json["pop"]?.toDouble(),
    );
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
    int date;
    int sunrise; //timestamp for sunrise
    int sunset; //timestamp for sunset
    int moonrise; //timestamp for moonrise
    int moonset; //timestamp for moonset
    double moonPhase;
    String summary;
    Temp temp;
    FeelsLike feelsLike;
    int pressure;
    int humidity;
    double dewPoint; //the temperature the air needs to be cooled to in order to achieve a relative humidity of 100%
    double windSpeed;
    int windDeg; //wind direction in degrees
    double windGust; //highest recorded wind speed in a short duration
    List<WeatherElement> weather;
    int clouds;
    double pop; //probability of precipitation - percentage value chance of rain
    double uvi; //ultraviolet index
    double? rain;

    Daily({
        required this.date,
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
        date: json["dt"] * 1000,
        sunrise: json["sunrise"] * 1000,
        sunset: json["sunset"] * 1000,
        moonrise: json["moonrise"] * 1000,
        moonset: json["moonset"] * 1000,
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
}

class FeelsLike { //what the temperature feels like to fellow humans.
    double day; //average temp during daytime
    double night; //average temp during nighttime
    double eve; //average temp in the evening
    double morn; //average temp in the morning

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
}

class Temp {
    double day; //average temp during daytime
    double min;
    double max;
    double night; //average temp during nighttime
    double eve; //average temp in the evening
    double morn; //average temp in the morning

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