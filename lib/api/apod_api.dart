import 'package:dio/dio.dart';
import 'package:astronomy_flutter/models/apod_model.dart';
import 'package:astronomy_flutter/config/api_constants.dart';

class PicsApi {
  final Dio dio = Dio();

  Future<PictureOfTheDayModel> fetchProductByDate(String date) async {
    final response = await dio.get(ApiConstants.getProducts(date));

    if (response.statusCode == 200) {
      final Map<String, dynamic> data = response.data;
      final picture = PictureOfTheDayModel.fromJson(data);
      return picture;
    } else {
      throw Exception("Failed to fetch product");
    }
  }
}
