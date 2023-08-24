class PictureOfTheDayModel {
  String copyright;
  DateTime date;
  String explanation;
  String hdurl;
  String mediaType;
  String serviceVersion;
  String title;
  String url;

  PictureOfTheDayModel({
    required this.copyright,
    required this.date,
    required this.explanation,
    required this.hdurl,
    required this.mediaType,
    required this.serviceVersion,
    required this.title,
    required this.url,
  });

  factory PictureOfTheDayModel.fromJson(Map<String, dynamic> json) {
    return PictureOfTheDayModel(
      copyright: json['copyright'],
      date: DateTime.parse(json['date']),
      explanation: json['explanation'],
      hdurl: json['hdurl'],
      mediaType: json['media_type'],
      serviceVersion: json['service_version'],
      title: json['title'],
      url: json['url'],
    );
  }

  PictureOfTheDayModel copyWith({
    String? copyright,
    DateTime? date,
    String? explanation,
    String? hdurl,
    String? mediaType,
    String? serviceVersion,
    String? title,
    String? url,
  }) =>
      PictureOfTheDayModel(
        copyright: copyright ?? this.copyright,
        date: date ?? this.date,
        explanation: explanation ?? this.explanation,
        hdurl: hdurl ?? this.hdurl,
        mediaType: mediaType ?? this.mediaType,
        serviceVersion: serviceVersion ?? this.serviceVersion,
        title: title ?? this.title,
        url: url ?? this.url,
      );
}
