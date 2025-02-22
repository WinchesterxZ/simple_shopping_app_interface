class UserModel {
  final String name;  // Changed from just 'age' to match usage
  final String age;   // Changed from just 'hobby' to match usage
  final String phone; // Added phone field
  final String favoriteHobby;  // Changed from just 'hobby' to match usage

  UserModel({
    required this.name,
    required this.age,
    required this.phone,
    required this.favoriteHobby,
  });

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'age': age,
      'phone': phone,
      'favoriteHobby': favoriteHobby,
    };
  }

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      name: json['name'] ?? '',
      age: json['age'] ?? '',
      phone: json['phone'] ?? '',
      favoriteHobby: json['favoriteHobby'] ?? '',
    );
  }

  // Copy with method for immutability
  UserModel copyWith({
    String? name,
    String? age,
    String? phone,
    String? favoriteHobby,
  }) {
    return UserModel(
      name: name ?? this.name,
      age: age ?? this.age,
      phone: phone ?? this.phone,
      favoriteHobby: favoriteHobby ?? this.favoriteHobby,
    );
  }
}
