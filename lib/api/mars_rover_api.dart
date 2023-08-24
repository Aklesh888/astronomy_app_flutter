import 'package:dio/dio.dart';
import 'package:astronomy_flutter/models/mars_rover_model.dart';

class MarsRoverApi {
  final Dio dio = Dio();

  Future<List<MarsRoverPhoto>> fetchPhotos(int sol, String camera) async {
    String apiKey = "GCJSiBZDOn4K07PT4heEnZv8gyJYhHDSda0VZXkg";
    String apiUrl =
        "https://api.nasa.gov/mars-photos/api/v1/rovers/curiosity/photos";

    final response = await dio.get(
      apiUrl,
      queryParameters: {
        'sol': sol,
        'camera': camera,
        'api_key': apiKey,
      },
    );

    if (response.statusCode == 200) {
      List<dynamic> data = response.data['photos'];
      return data.map((json) => MarsRoverPhoto.fromJson(json)).toList();
    } else {
      throw Exception("Failed to fetch photos");
    }
  }
}
