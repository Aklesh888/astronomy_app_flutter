import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:astronomy_flutter/screens/apod_screen.dart';
import 'package:astronomy_flutter/screens/image_search_screen.dart';
import 'package:astronomy_flutter/screens/mars_rover_page.dart';
import 'package:astronomy_flutter/screens/planets_screen.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Exploring the cosmos',
      theme: ThemeData(
          hintColor: Colors.white,
          focusColor: Colors.white,
          scaffoldBackgroundColor: const Color.fromARGB(255, 78, 121, 136),
          colorScheme: const ColorScheme.dark(),
          appBarTheme: const AppBarTheme(
            backgroundColor: Color.fromARGB(255, 0, 36, 57),
          )),
      home: AnimatedSplashScreen(
        backgroundColor: const Color.fromARGB(255, 0, 0, 0),
        splashTransition: SplashTransition.rotationTransition,
        animationDuration: const Duration(seconds: 1),
        splash: const Center(
          child: ClipRRect(
            borderRadius: BorderRadius.all(Radius.circular(100)),
            child: SizedBox(
              height: 500,
              width: 500,
              child: Image(
                image: AssetImage("assets/wallpaper_2.png"),
                fit: BoxFit.contain,
              ),
            ),
          ),
        ),
        nextScreen: const Apod(),
        duration: 2000,
      ),
      routes: {
        'apod': (_) => const Apod(),
        'marsRover': (_) => MarsRoverPage(),
        'images': (_) => NasaImagesPage(),
        "planets": (_) => PlanetListPage()
      },
    );
  }
}
