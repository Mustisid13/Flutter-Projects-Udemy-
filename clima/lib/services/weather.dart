import 'package:clima/services/location.dart';
import 'package:clima/services/networking.dart';


class WeatherModel {
String baseUrl ="https://api.openweathermap.org/data/2.5/weather";
String api = "4f1777b33f9f08bf00d310bc52d19f58";

  Future<dynamic> getCityWeather(String cityName) async{
    var url = "$baseUrl?q=$cityName&appid=$api&units=metric";
    NetworkHelper networkHelper = NetworkHelper(url);
    var weatherData = await networkHelper.getData();
    return weatherData;
  }

  Future<dynamic> getLocationWeather() async{

    Location location = Location();
    await location.determinePosition();

    NetworkHelper networkHelper = NetworkHelper("$baseUrl?lat=${location.lat!}&lon=${location.long!}&appid=$api&units=metric");
    var res = await networkHelper.getData();
    return res;
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
