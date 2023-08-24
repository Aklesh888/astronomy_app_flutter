import 'package:astronomy_flutter/screens/nav_bar.dart';
import 'package:flutter/material.dart';
import 'package:astronomy_flutter/config/planet_data.dart'; // Import the PlanetData class

class PlanetListPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: const Navbar(),
      appBar: AppBar(
        title: const Center(child: Text('Planet List')),
      ),
      body: ListView.builder(
        itemCount: PlanetData.planets.length,
        itemBuilder: (context, index) {
          return Card(
            color: const Color.fromARGB(255, 0, 36, 57),
            child: ListTile(
              title: Text(PlanetData.planets[index]['name']),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => PlanetDetailsPage(index: index),
                  ),
                );
              },
            ),
          );
        },
      ),
    );
  }
}

class PlanetDetailsPage extends StatelessWidget {
  final int index;

  const PlanetDetailsPage({required this.index});

  @override
  Widget build(BuildContext context) {
    final planet = PlanetData.planets[index];

    return Scaffold(
      appBar: AppBar(
        title: Text(planet['name'] + ' Details'),
      ),
      body: Card(
        color: const Color.fromARGB(255, 0, 36, 57),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                planet['name'],
                style: const TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 10),
              Image(
                image: NetworkImage(planet['image']),
              ),
              const SizedBox(
                height: 50,
              ),
              Text(
                "Description: ${planet['description']}",
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.normal,
                ),
              ),
              const SizedBox(height: 10),
              Text(
                'Distance from Sun: ${planet['distanceFromSun']}',
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.normal,
                ),
              ),

              const SizedBox(height: 10),
              Text(
                'Diameter: ${planet['diameter']}',
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.normal,
                ),
              ),

              const SizedBox(height: 10),
              Text(
                'Mass: ${planet['mass']}',
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.normal,
                ),
              ),

              const SizedBox(height: 10),
              Text(
                'Gravity: ${planet['gravity']}',
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.normal,
                ),
              ),

              const SizedBox(height: 10),
              Text(
                'Orbital peroid: ${planet['orbitalPeriod']}',
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.normal,
                ),
              ),

              const SizedBox(height: 10),
              Text(
                'Day Length: ${planet['dayLength']}',
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.normal,
                ),
              ),

              const SizedBox(height: 10),
              Text(
                'Moons: ${planet['moons']}',
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.normal,
                ),
              ),
              // Add more planet details...
            ],
          ),
        ),
      ),
    );
  }
}

void main() {
  runApp(MaterialApp(
    home: PlanetListPage(),
  ));
}
