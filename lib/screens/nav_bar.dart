import 'package:flutter/material.dart';

class Navbar extends StatelessWidget {
  const Navbar({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: Color.fromARGB(255, 0, 36, 57),
      child: ListView(
        children: [
          const UserAccountsDrawerHeader(
            accountEmail: Text(''),
            accountName: Text(
              "Astronomy App",
              style: TextStyle(fontSize: 30),
            ),
            decoration: BoxDecoration(
                color: Color.fromARGB(255, 120, 204, 226),
                image: DecorationImage(
                    image: AssetImage("assets/wallpaper_2.jpg"),
                    fit: BoxFit.fill)),
          ),
          ListTile(
            leading: const Icon(Icons.camera),
            title: const Text("Mars Rover"),
            onTap: () {
              Navigator.of(context).pushNamed("marsRover");
            },
          ),
          ListTile(
            leading: const Icon(Icons.image),
            title: const Text("NASA APOD"),
            onTap: () {
              Navigator.of(context).pushNamed("apod");
            },
          ),
          ListTile(
            leading: const Icon(Icons.search),
            title: const Text("Search Images"),
            onTap: () {
              Navigator.of(context).pushNamed("images");
            },
          )
        ],
      ),
    );
  }
}
