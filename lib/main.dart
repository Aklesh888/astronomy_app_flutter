import 'package:astronomy_flutter/screens/apod_screen.dart';
import 'package:astronomy_flutter/screens/image_search_screen.dart';
import 'package:astronomy_flutter/screens/mars_rover_page.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
          scaffoldBackgroundColor: Color.fromARGB(255, 78, 121, 136),
          colorScheme: const ColorScheme.dark(),
          appBarTheme: const AppBarTheme(
            backgroundColor: Color.fromARGB(255, 0, 36, 57),
          )),
      home: NasaImagesPage(),
      routes: {
        'apod': (_) => const Apod(),
        'marsRover': (_) => MarsRoverPage(),
        'images': (_) => NasaImagesPage()
      },
    );
  }
}
