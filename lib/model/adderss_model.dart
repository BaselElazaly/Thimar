class AddressData {
  late final List<AddressModel> list;
  late final String status, message;

  AddressData.fromJson(Map<String, dynamic> json) {
    list = json['data'] != null 
        ? List.from(json['data']).map((e) => AddressModel.fromJson(e)).toList() 
        : [];
    status = json['status'] ?? "";
    message = json['message'] ?? "";
  }
}

class AddressModel {
  late final int id;
  late final String type, location, description, phone;
  late final double lat, lng;
  late final bool isDefault;

  AddressModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    type = json['type'];
    lat = (json['lat'] as num).toDouble();
    lng = (json['lng'] as num).toDouble();
    location = json['location'];
    description = json['description'] ?? "";
    isDefault = json['is_default'];
    phone = json['phone'];
  }
}