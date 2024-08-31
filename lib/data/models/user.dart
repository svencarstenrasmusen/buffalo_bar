class User {
  final String id;
  final String username;
  final String createdAt;
  final String? email;
  final int? scalpCount;
  final int? snagCount;
  final bool isAdmin;
  final DateTime? joinedAt;

  User(
      {required this.id,
      required this.username,
      required this.createdAt,
      required this.isAdmin,
      this.email,
      this.scalpCount,
      this.snagCount,
      this.joinedAt});

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
        id: json['id'],
        username: json['username'],
        createdAt: json['createdAt'],
        email: json['email'],
        isAdmin: false);
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

  String? getJoinedAtDate() {
    String? day = joinedAt?.day.toString();
    String? month = joinedAt?.month.toString();
    String? year = joinedAt?.year.toString();

    return '$day.$month.$year';
  }

  @override
  String toString() {
    return '$username, $email';
  }
}
