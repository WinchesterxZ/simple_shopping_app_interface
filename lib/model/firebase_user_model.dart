class UserModel {
  final String age;
  final String hobby;
  final String name;
  final String phone;

  UserModel({
    required this.age,
    required this.hobby,
    required this.name,
    required this.phone,
  });

  // Convert model to JSON
  Map<String, dynamic> toJson() {
    return {
      'age': age,
      'hobby': hobby,
      'name': name,
      'phone': phone,
    };
  }

  // Create model from JSON
  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      age: json['age'] ?? '',
      hobby: json['hobby'] ?? '',
      name: json['name'] ?? '',
      phone: json['phone'] ?? '',
    );
  }

  // Copy with method for immutability
  UserModel copyWith({
    String? age,
    String? hobby,
    String? name,
    String? phone,
  }) {
    return UserModel(
      age: age ?? this.age,
      hobby: hobby ?? this.hobby,
      name: name ?? this.name,
      phone: phone ?? this.phone,
    );
  }
}
