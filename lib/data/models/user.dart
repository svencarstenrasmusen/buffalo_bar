class User {
  final String id;
  final String username;
  final String createdAt;
  final String? email;

  User(
      {required this.id,
      required this.username,
      required this.createdAt,
      this.email});

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
        id: json['id'],
        username: json['username'],
        createdAt: json['createdAt'],
        email: json['email']);
  }

  Map<String, dynamic> toJson() {
    return {'id': id, 'username': username, 'email': email};
  }

  @override
  String toString() {
    return '$username, $email';
  }
}
