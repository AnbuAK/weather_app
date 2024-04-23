import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:weather_app/models/weather_models.dart';
import 'package:weather_app/services/weather_service.dart';



class WeatherPage extends StatefulWidget {
  const WeatherPage({super.key});

  @override
  State<WeatherPage> createState() => _WeatherPageState();
}

class _WeatherPageState extends State<WeatherPage> {

  late DateTime _currentTime;
  bool _isNight = false;

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

  String getWeatherAnimation(String? mainCondition, bool _isNight) {
  if (mainCondition == null)
    return 'assets/sunny.json'; // Default animation

  switch (mainCondition.toLowerCase()) {
    case 'clouds':
      return _isNight ? 'assets/nightcloudy.json' : 'assets/suncloudy.json';
    case 'mist':
    case 'smoke':
    case 'haze':
    case 'dust':
      return _isNight ? 'assets/nightcloudy.json' : 'assets/cloudy.json';
    case 'fog':
      return _isNight ? 'assets/fog.json' : 'assets/fog.json';
    case 'rain':
    case 'drizzle':
    case 'shower rain':
      return _isNight ? 'assets/nightrainy.json' : 'assets/rainy.json';
    case 'thunderstorm':
      return _isNight ? 'assets/night_thunder.json' : 'assets/thunder.json';
    case 'clear':
      return _isNight ? 'assets/moonie.json' : 'assets/sunny.json';
    default:
      return 'assets/loading.json'; // Default animation
  }
}

  @override
  void initState() {
    
    super.initState();
    _currentTime = DateTime.now();
    _updateTimeAndCheckDayNight();
    _fetchWeather();
  }

  void _updateTimeAndCheckDayNight() {
    setState(() {
      _currentTime = DateTime.now();
      _isNight = _currentTime.hour < 6 || _currentTime.hour > 18; // Assuming night is from 6 PM to 6 AM
    });
  }

  


  @override
  Widget build(BuildContext context) {
    return Builder(
      builder: (BuildContext  context) {
        return Scaffold(backgroundColor: _isNight? Colors.grey.shade800  : Colors.grey.shade50,
          body: Center(
          
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
                  Icon(Icons.location_on_sharp,
                  color: _isNight? Colors.grey.shade100 :Colors.grey,
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
                              color:_isNight? Colors.grey.shade100 : Colors.grey.shade700,
                              fontWeight: FontWeight.w900,
                              fontSize: 25,
                            ),
                          ),
              const SizedBox(height: 20,),
              Lottie.asset(getWeatherAnimation(_weather?.mainCondition, _isNight)),
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
                        color: _isNight? Colors.grey.shade100 :Colors.grey.shade700,
                        fontWeight: FontWeight.w900,
                        fontSize: 50,
                      ),
                    ),
                    TextSpan(
                      text: '°C',
                      style: TextStyle(
                        color: _isNight? Colors.grey.shade100 : Colors.grey.shade700,
                        fontWeight: FontWeight.w900,
                        fontSize: 20, // Adjust the size of '°C' here
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 10,),
              Text(_weather?.mainCondition?? "",
              style:  TextStyle(fontSize: 16,
              color: _isNight? Colors.grey.shade100 :Colors.grey),),
            ],
          ),
          )
        );
      }
    );
  }
}