import 'package:astronomy_flutter/screens/nav_bar.dart';
import 'package:flutter/material.dart';
import 'package:astronomy_flutter/api/mars_rover_api.dart';
import 'package:astronomy_flutter/models/mars_rover_model.dart';

class MarsRoverPage extends StatefulWidget {
  @override
  _MarsRoverPageState createState() => _MarsRoverPageState();
}

class _MarsRoverPageState extends State<MarsRoverPage> {
  final MarsRoverApi marsRoverApi = MarsRoverApi();
  int selectedSol = 0;
  String selectedCamera = "FHAZ"; // Default to FHAZ
  Map<String, String> cameraOptions = {
    "FHAZ": "Front Hazard Avoidance Camera",
    "RHAZ": "Rear Hazard Avoidance Camera",
    "MAST": "Mast Camera",
    "CHEMCAM": "Chemistry and Camera Complex",
    "MAHLI": "Mars Hand Lens Imager",
    "MARDI": "Mars Descent Imager",
    "NAVCAM": "Navigation Camera",
    "PANCAM": "Panoramic Camera",
    "MINITES": "Mini-TES",
  };
  List<MarsRoverPhoto> marsRoverPhotos = [];
  bool isLoading = false;

  void _fetchMarsRoverPhotos() async {
    setState(() {
      isLoading = true;
    });

    try {
      marsRoverPhotos =
          await marsRoverApi.fetchPhotos(selectedSol, selectedCamera);
    } catch (e) {
      debugPrint("Error: $e");
    }

    setState(() {
      isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: const Navbar(),
      appBar: AppBar(
        title: const Text("Mars Rover Photos"),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const SizedBox(height: 20),
            Card(
              color: const Color.fromARGB(255, 0, 36, 57),
              elevation: 5,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
              margin: const EdgeInsets.all(16),
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    const Text(
                      "Select Sol",
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                    const SizedBox(height: 2),
                    TextField(
                      cursorColor: Colors.black,
                      keyboardType: TextInputType.number,
                      decoration: const InputDecoration(
                        labelText: "Enter Sol",
                        labelStyle: TextStyle(color: Colors.white),
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                            color: Colors.white,
                          ),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                            color: Colors.white,
                          ),
                        ),
                      ),
                      onChanged: (value) {
                        setState(() {
                          selectedSol = int.tryParse(value) ?? 0;
                        });
                      },
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 1),
            Card(
              color: const Color.fromARGB(255, 0, 36, 57),
              elevation: 5,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
              margin: const EdgeInsets.all(16),
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    const Text(
                      "Select Camera",
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                    const SizedBox(height: 10),
                    DropdownButton<String>(
                      value: selectedCamera,
                      onChanged: (newValue) {
                        setState(() {
                          selectedCamera = newValue!;
                        });
                      },
                      items: cameraOptions.keys
                          .map<DropdownMenuItem<String>>((String key) {
                        return DropdownMenuItem<String>(
                          value: key,
                          child: Text(
                            cameraOptions[key]!,
                            maxLines: 1,
                            style: const TextStyle(fontSize: 16),
                          ),
                        );
                      }).toList(),
                    ),
                    ElevatedButton(
                      onPressed: _fetchMarsRoverPhotos,
                      style: ElevatedButton.styleFrom(
                        primary: const Color.fromARGB(255, 0, 80, 102),
                      ),
                      child: const Text(
                        "Fetch Photos",
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 20),
            const Divider(),
            const Padding(
              padding: EdgeInsets.symmetric(vertical: 10),
              child: Padding(
                padding: EdgeInsets.fromLTRB(10.0, 10.0, 10.0, 0.0),
                child: Center(
                  child: Text(
                    "Pictures",
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 10),
            isLoading
                ? const Center(
                    child: CircularProgressIndicator(),
                  )
                : marsRoverPhotos.isEmpty
                    ? Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(10),
                          child: Container(
                            color: const Color.fromARGB(255, 0, 36, 57),
                            child: const Padding(
                              padding:
                                  EdgeInsets.fromLTRB(10.0, 10.0, 10.0, 10.0),
                              child: Center(
                                child: Text(
                                  "Sorry, there are no pictures in that sol or camera. Try searching for a different camera or sol.",
                                  style: TextStyle(fontSize: 16),
                                  textAlign: TextAlign.center,
                                ),
                              ),
                            ),
                          ),
                        ),
                      )
                    : Column(
                        children: marsRoverPhotos.map((photo) {
                          return Column(
                            children: [
                              Card(
                                color: const Color.fromARGB(255, 0, 36, 57),
                                elevation: 5,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                margin: const EdgeInsets.all(16),
                                child: Column(
                                  children: [
                                    ClipRRect(
                                      borderRadius: BorderRadius.circular(10),
                                      child: Image.network(
                                        photo.imageUrl,
                                        fit: BoxFit.cover,
                                        height: 200,
                                      ),
                                    ),
                                    const SizedBox(height: 10),
                                    Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Text(
                                        "Camera: ${photo.cameraName}",
                                        style: const TextStyle(
                                          fontSize: 20,
                                          fontWeight: FontWeight.bold,
                                          color: Colors.white,
                                        ),
                                      ),
                                    ),
                                    const SizedBox(height: 20),
                                  ],
                                ),
                              ),
                            ],
                          );
                        }).toList(),
                      ),
          ],
        ),
      ),
    );
  }
}

void main() {
  runApp(MaterialApp(
    home: MarsRoverPage(),
  ));
}
