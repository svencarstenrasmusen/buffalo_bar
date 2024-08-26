class Group {
  final String id;
  final String name;
  final String createdAt;
  final int? numMembers;

  Group(
      {required this.id,
      required this.name,
      required this.createdAt,
      this.numMembers});

  factory Group.fromJson(Map<String, dynamic> json) {
    return Group(
        id: json['pack']['id'],
        name: json['pack']['name'],
        createdAt: json['pack']['createdAt'],
        numMembers: json['pack']['numMembers']);
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'createdAt': createdAt,
      'numMembers': numMembers
    };
  }

  @override
  String toString() {
    return 'Name: $name, Members: $numMembers';
  }
}
