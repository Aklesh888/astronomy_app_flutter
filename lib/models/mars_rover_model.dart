class MarsRoverPhoto {
  final int id;
  final String imageUrl;
  final String cameraName;
  final String earthDate;

  MarsRoverPhoto({
    required this.id,
    required this.imageUrl,
    required this.cameraName,
    required this.earthDate,
  });

  factory MarsRoverPhoto.fromJson(Map<String, dynamic> json) {
    return MarsRoverPhoto(
      id: json['id'],
      imageUrl: json['img_src'],
      cameraName: json['camera']['full_name'],
      earthDate: json['earth_date'],
    );
  }
}
