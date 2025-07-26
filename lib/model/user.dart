class User {
  final String id;
  final String name;
  final String email;
  final String address;
  final String profilePictureUrl;

  User({
    required this.id,
    required this.name,
    required this.email,
    required this.address,
    required this.profilePictureUrl,
  });

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json['id'] as String,
      name: json['name'] as String,
      email: json['email'] as String,
      address: json['address'] as String,
      profilePictureUrl: json['profilePictureUrl'] as String,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'email': email,
      'address': address,
      'profilePictureUrl': profilePictureUrl,
    };
  }
}