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

  String getCreateDate() {
    DateTime date = DateTime.parse(createdAt);
    String day = date.day.toString();
    String month = date.month.toString();
    String year = date.year.toString();

    return '$day.$month.$year';
  }

  @override
  String toString() {
    return '$username, $email';
  }
}
