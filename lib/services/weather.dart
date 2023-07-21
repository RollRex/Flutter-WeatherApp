import 'location.dart';
import 'networking.dart';

const apiKey = 'e63b08dec600de0a0aa8b49b867d0435';
const apiHost = 'api.openweathermap.org';
const apiPath = '/data/2.5/weather';

class WeatherModel {
  Future<dynamic> getCityWeather(String cityName) async {
    var url = Uri.https(apiHost, apiPath,
        {'q': '$cityName', 'appid': '$apiKey', 'units': 'metric'});
    NetworkHelper networkHelper = NetworkHelper("$url");

    var weatherData = await networkHelper.getData();
    return weatherData;
  }

  Future<dynamic> getLocationWeather() async {
    Location location = Location();

    await location.getCurrrentPosition();

    var url = Uri.https(apiHost, apiPath, {
      'lat': '${location.latitude}',
      'lon': '${location.longitude}',
      'appid': '$apiKey',
      'units': 'metric'
    });
    NetworkHelper networkHelper = NetworkHelper("$url");

    var weatherData = await networkHelper.getData();

    return weatherData;
  }

  String getWeatherIcon(int condition) {
    if (condition < 300) {
      return '🌩';
    } else if (condition < 400) {
      return '🌧';
    } else if (condition < 600) {
      return '☔️';
    } else if (condition < 700) {
      return '☃️';
    } else if (condition < 800) {
      return '🌫';
    } else if (condition == 800) {
      return '☀️';
    } else if (condition <= 804) {
      return '☁️';
    } else {
      return '🤷‍';
    }
  }

  String getMessage(int temp) {
    if (temp > 25) {
      return 'It\'s 🍦 time';
    } else if (temp > 20) {
      return 'Time for shorts and 👕';
    } else if (temp < 10) {
      return 'You\'ll need 🧣 and 🧤';
    } else {
      return 'Bring a 🧥 just in case';
    }
  }
}
