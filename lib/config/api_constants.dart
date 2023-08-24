class ApiConstants {
  static const String apiKey = "GCJSiBZDOn4K07PT4heEnZv8gyJYhHDSda0VZXkg";

  static String getProducts(String date) =>
      "https://api.nasa.gov/planetary/apod?api_key=$apiKey&date=$date";
}
