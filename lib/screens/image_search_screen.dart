import 'package:astronomy_flutter/screens/nav_bar.dart';
import 'package:flutter/material.dart';
import 'package:astronomy_flutter/api/images_api.dart'; // Import the NasaApi class

class NasaImagesPage extends StatefulWidget {
  @override
  _NasaImagesPageState createState() => _NasaImagesPageState();
}

class _NasaImagesPageState extends State<NasaImagesPage> {
  final NasaApi nasaApi = NasaApi(); // Create an instance of NasaApi
  List<Map<String, dynamic>> nasaImages =
      []; // List to hold the fetched NASA images
  final TextEditingController _searchController =
      TextEditingController(); // Controller for the search input
  bool isLoading = false;

  // Fetch NASA images using the API
  Future<void> fetchNasaImages({String query = 'galaxy'}) async {
    setState(() {
      isLoading = true;
    });

    try {
      final response = await nasaApi.fetchNasaImages(query: query);
      final jsonData = response.data;
      final items = jsonData['collection']['items'] as List<dynamic>;

      setState(() {
        nasaImages = items.map((item) {
          final data = item['data'][0];
          final links = item['links'][0];
          return {
            'title': data['title'],
            'description': data['description'],
            'imageUrl': links['href'], // Use the href from links
          };
        }).toList();
        isLoading = false;
      });
    } catch (error) {
      setState(() {
        isLoading = false;
      });
      debugPrint(error.toString()); // Handle the error appropriately
    }
  }

  @override
  void initState() {
    super.initState();
    fetchNasaImages();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: const Navbar(),
      appBar: AppBar(
        title: const Center(child: Text('NASA Images')),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: TextField(
              controller: _searchController,
              decoration: InputDecoration(
                labelText: 'Search',
                labelStyle: const TextStyle(color: Colors.white),
                suffixIcon: IconButton(
                  onPressed: () {
                    fetchNasaImages(query: _searchController.text);
                  },
                  icon: const Icon(
                    Icons.search,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          ),
          if (isLoading)
            const Expanded(
              child: Center(
                child: CircularProgressIndicator(
                  color: Colors.white,
                ),
              ),
            )
          else
            Expanded(
              child: ListView.builder(
                itemCount: nasaImages.length,
                itemBuilder: (context, index) {
                  final image = nasaImages[index];
                  return ClipRRect(
                    borderRadius: BorderRadius.circular(25),
                    child: Card(
                      color: const Color.fromARGB(255, 0, 36, 57),
                      child: Padding(
                        padding: const EdgeInsets.all(14.0),
                        child: Column(
                          children: [
                            ClipRRect(
                              borderRadius: BorderRadius.circular(25),
                              child: Image.network(
                                image['imageUrl'],
                                width: 300,
                              ),
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            Text(
                              // maxLines: 5,
                              image['title'],
                              style: const TextStyle(
                                  fontSize: 20, fontWeight: FontWeight.bold),
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            Text(image['description']),
                          ],
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
        ],
      ),
    );
  }
}

void main() {
  runApp(MaterialApp(
    home: NasaImagesPage(),
  ));
}
