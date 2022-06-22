class UserModel {
  String? name;
  String? email;
  String? phone;
  String? country;
  String? birthDate;
  String? uId;
  String? profileImage;
  UserModel(
      {required this.name,
      required this.email,
      required this.phone,
      required this.country,
      required this.birthDate,
      required this.uId,
      this.profileImage});

  UserModel.fromJson(Map<String, dynamic>? json) {
    name = json!['name'];
    email = json['email'];
    phone = json['phone'];
    country = json['country'];
    uId = json['uId'];
    birthDate = json['birthDate'];
    profileImage = json['profileImage'];
  }

  Map<String, dynamic> asMap() {
    return {
      'name': name,
      'email': email,
      'phone': phone,
      'country': country,
      'birthDate': birthDate,
      'uId': uId,
      'profileImage': profileImage,
    };
  }
}
