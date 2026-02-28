class UserModel {
  final int id;
  final String fullname;
  final String phone;
  final String image;
  final String? token; 
  final String userType;

  UserModel({
    required this.id,
    required this.fullname,
    required this.phone,
    required this.image,
    this.token, 
    required this.userType,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      id: json['id'] ?? 0,
      fullname: json['fullname'] ?? "",
      phone: json['phone'] ?? "",
      image: json['image'] ?? "",
      token: json['token'], 
      userType: json['user_type'] ?? "",
    );
  }
}