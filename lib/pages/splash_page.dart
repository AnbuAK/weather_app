import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:flutter/widgets.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lottie/lottie.dart';
import 'package:weather_app/pages/weather_page.dart';
import 'package:flutter/material.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  get splash => null;

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.topCenter,
      child: AnimatedSplashScreen(splash: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text('Weather App',
            style: GoogleFonts.lato(
              color:Colors.white,
              fontSize: 25,
            fontWeight: FontWeight.w700,
            ),),
            const SizedBox(height: 50,),
            Padding(
              padding: const EdgeInsets.all(30.0),
              child: LottieBuilder.asset('assets/loading.json',
              height: 200,),
            ),
            SizedBox(height: 30,),
            Text('Powered by ZingBizz',
            style: GoogleFonts.lato(
                  textStyle: Theme.of(context).textTheme.displayLarge,
                  fontSize: 18,
                  fontWeight: FontWeight.w700,
                  fontStyle: FontStyle.italic,
              ),
            ),
          ],
        ),
      nextScreen: WeatherPage(),
      splashIconSize: 80,
      duration: 4000,
      backgroundColor: Colors.blue.shade700,
      centered: true,
      splashTransition: SplashTransition.fadeTransition,
      ),
    );
  }
}