class UserModel {
  String name;
  String email;
  String phone;
  String dob;
  String idNumber;
  String gender;
  String location;
  String town;
  String imageUrl; // Firebase Storage URL for the uploaded image

  UserModel({
    required this.name,
    required this.email,
    required this.phone,
    required this.dob,
    required this.idNumber,
    required this.gender,
    required this.location,
    required this.town,
    required this.imageUrl,
  });

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'email': email,
      'phone': phone,
      'dob': dob,
      'idNumber': idNumber,
      'gender': gender,
      'location': location,
      'town': town,
      'imageUrl': imageUrl,
    };
  }
}
