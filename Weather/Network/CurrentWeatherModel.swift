//
//  CurrentWeatherModel.swift
//  Weather
//
//  Created by Нияз Нуруллин on 15.01.2023.
//

import Foundation

struct CurrentWeatherModel: Codable {
    let data: [CurrentWeatherJSONData]
}

struct CurrentWeatherJSONData: Codable {
    let sunriseTime: String
    let sunsetTime: String
    let temperature: Double
    let weather: WeatherCodable
    let uvIndex: Double
    let windVelocity: Double
    let humidityLevel: Int
    let airQualityIndex: Int

    enum CodingKeys: String, CodingKey {
        case sunriseTime = "sunrise"
        case sunsetTime = "sunset"
        case temperature = "temp"
        case weather = "weather"
        case uvIndex = "uv"
        case windVelocity = "wind_spd"
        case humidityLevel = "rh"
        case airQualityIndex = "aqi"
    }
}

struct WeatherCodable: Codable {
    let code: Int
    let description: String
}

/*
sunrise: Sunrise time (HH:MM).
sunset: Sunset time (HH:MM).
wind_spd: Wind speed (Default m/s).
temp: Temperature (default Celsius).
app_temp: Apparent/"Feels Like" temperature (default Celsius).
rh: Relative humidity (%).
clouds: Cloud coverage (%).
weather: {
icon:Weather icon code.
code:Weather code.
description: Text weather description.
}
uv: UV Index (0-11+).
aqi: Air Quality Index [US - EPA standard 0 - +500]
precip: Liquid equivalent precipitation rate (default mm/hr).
*/

/*
 {
"count": 1,
"data":
 [
    {
        "app_temp": -44.3,
        "aqi": 13,
        "city_name": "Port-aux-Français",
        "clouds": 32,
        "country_code": "TF",
        "datetime": "2023-01-15:12",
        "dewpt": -35.6,
        "dhi": 86.92,
        "dni": 848.11,
        "elev_angle": 28.5,
        "ghi": 486.04,
        "gust": 5.109375,
        "h_angle": -72,
        "lat": -78.5,
        "lon": 38.5,
        "ob_time": "2023-01-15 12:53",
        "pod": "d",
        "precip": 0,
        "pres": 606,
        "rh": 92,
        "slp": 993.5,
        "snow": 0,
        "solar_rad": 477,
        "sources": [
            "analysis"
        ],
        "state_code": "03",
        "station": "G0697",
        "sunrise": "00:00",
        "sunset": "00:00",
        "temp": -31.5,
        "timezone": "Africa/Johannesburg",
        "ts": 1673787215,
        "uv": 2.4550676,
        "vis": 16,
        "weather": {
            "code": 801,
            "description": "Преимущественно ясно",
            "icon": "c02d"
        },
        "wind_cdir": "СЗ",
        "wind_cdir_full": "Северо-Западный",
        "wind_dir": 318,
        "wind_spd": 3.2690482
    }
]
}
*/

/*
 Field Decriptions:
 count: Count of returned observations.
 data: [
 lat: Latitude (Degrees).
 lon: Longitude (Degrees).
 sunrise: Sunrise time (HH:MM).
 sunset: Sunset time (HH:MM).
 timezone: Local IANA Timezone.
 station: [DEPRECATED] Nearest reporting station ID.
 sources: List of data sources used in response.
 ob_time: Last observation time (YYYY-MM-DD HH:MM).
 datetime: [DEPRECATED] Current cycle hour (YYYY-MM-DD:HH).
 ts: Last observation time (Unix timestamp).
 city_name: City name.
 country_code: Country abbreviation.
 state_code: State abbreviation/code.
 pres: Pressure (mb).
 slp: Sea level pressure (mb).
 wind_spd: Wind speed (Default m/s).
 gust: Wind gust speed (Default m/s).
 wind_dir: Wind direction (degrees).
 wind_cdir: Abbreviated wind direction.
 wind_cdir_full: Verbal wind direction.
 temp: Temperature (default Celsius).
 app_temp: Apparent/"Feels Like" temperature (default Celsius).
 rh: Relative humidity (%).
 dewpt: Dew point (default Celsius).
 clouds: Cloud coverage (%).
 pod: Part of the day (d = day / n = night).
 weather: {
 icon:Weather icon code.
 code:Weather code.
 description: Text weather description.
 }
 vis: Visibility (default KM).
 precip: Liquid equivalent precipitation rate (default mm/hr).
 snow: Snowfall (default mm/hr).
 uv: UV Index (0-11+).
 aqi: Air Quality Index [US - EPA standard 0 - +500]
 dhi: Diffuse horizontal solar irradiance (W/m^2) [Clear Sky]
 dni: Direct normal solar irradiance (W/m^2) [Clear Sky]
 ghi: Global horizontal solar irradiance (W/m^2) [Clear Sky]
 solar_rad: Estimated Solar Radiation (W/m^2).
 elev_angle: Solar elevation angle (degrees).
 h_angle: [DEPRECATED] Solar hour angle (degrees).
 ]
 */
