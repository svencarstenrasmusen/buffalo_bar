class Group {
  final String id;
  final String name;
  final String createdAt;

  Group({required this.id, required this.name, required this.createdAt});

  factory Group.fromJson(Map<String, dynamic> json) {
    return Group(
        id: json['id'], name: json['name'], createdAt: json['createdAt']);
  }

  Map<String, dynamic> toJson() {
    return {'id': id, 'name': name, 'createdAt': createdAt};
  }
}
