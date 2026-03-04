class CategoryModel {
  late final int id;
  late final String name, media;

  CategoryModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    media = json['media'];
  }
}