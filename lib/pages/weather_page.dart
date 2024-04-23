import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:weather_app/models/weather_models.dart';
import 'package:weather_app/services/weather_service.dart';
import 'package:dotted_line/dotted_line.dart';


class WeatherPage extends StatefulWidget {
  const WeatherPage({super.key});

  @override
  State<WeatherPage> createState() => _WeatherPageState();
}

class _WeatherPageState extends State<WeatherPage> {

  final _weatherService = WeatherService('b4966fbbcdc7815d0d2fa30f6bbc1b05');
  Weather? _weather;
  bool _isLoading = true;

  _fetchWeather() async{
    String cityName= await _weatherService.getCurrentCity();


    try {
      final weather = await _weatherService.getWeather(cityName);
      setState(() {
        _weather = weather;
        _isLoading = false;
      });
    }
    catch (e){
        print (e);
      }
  }

  String getWeatherAnimation(String? mainCondition){
    if (mainCondition == null )
      return 'assets/sunny.json';

      switch (mainCondition?.toLowerCase()){
        case 'clouds':
          return 'assets/suncloudy.json';
        case 'mist':
        case 'smoke':
          return 'assets/cloudy.json';
        case 'haze':
        case 'dust':
          return 'assets/cloudy.json';
        case 'fog':
          return 'assets/fog.json';
        case 'rain':
          return 'assets/rainy.json';
        case 'drizzle':
          return 'assets/drizzle.json';
        case 'shower rain':
          return 'assets/rainy.json'; 
        case 'thunderstorm':
          return 'assets/thunder.json';
        case 'clear':
          return 'assets/sunny.json';
        default: 
          return 'assets/loading.json';
    }

  }

  @override
  void initState() {
    
    super.initState();

    _fetchWeather();
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(backgroundColor: Colors.grey.shade50,
      body: Center(
      
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
              const Icon(Icons.location_on_sharp,
              color: Colors.grey,
              size: 40),
              const SizedBox(height: 10), // Add spacing between icon and text
                // Display loading icon only when loading, else display city name
                _isLoading
                    ? 
                    const CircularProgressIndicator(
                      color: Color.fromARGB(255, 135, 134, 134),
                    ) // Show loading indicator
                    : Text(
                        _weather?.cityName ?? "", // Show city name if available
                        style: TextStyle(
                          color: Colors.grey.shade700,
                          fontWeight: FontWeight.w900,
                          fontSize: 25,
                        ),
                      ),
          const SizedBox(height: 20,),
          Lottie.asset(getWeatherAnimation(_weather?.mainCondition)),
          const SizedBox(height: 30,),
          _isLoading
                ? const CircularProgressIndicator(
                      color: Color.fromARGB(255, 135, 134, 134),
                    )
          :RichText(
            text: TextSpan(
              children: [
                TextSpan(
                  text: '${_weather?.temperature.round()}',
                  style: TextStyle(
                    color: Colors.grey.shade700,
                    fontWeight: FontWeight.w900,
                    fontSize: 50,
                  ),
                ),
                TextSpan(
                  text: '°C',
                  style: TextStyle(
                    color: Colors.grey.shade700,
                    fontWeight: FontWeight.w900,
                    fontSize: 20, // Adjust the size of '°C' here
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 10,),
          Text(_weather?.mainCondition?? "",
          style: const TextStyle(fontSize: 16,
          color: Colors.grey),),

        ],
      ),
      )
    );
  }
}