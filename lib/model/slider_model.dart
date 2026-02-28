class SliderModel {
  final int id;
  final String media;

  SliderModel({required this.id, required this.media});

  factory SliderModel.fromJson(Map<String, dynamic> json) {
    return SliderModel(
      id: json['id'],
      media: json['media'],
    );
  }
}