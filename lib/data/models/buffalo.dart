class Buffalo {
  final String id;
  final String scalper;
  final String snaggee;
  final DateTime dateTime;

  Buffalo(
      {required this.id,
      required this.scalper,
      required this.snaggee,
      required this.dateTime});

  factory Buffalo.fromJson(Map<String, dynamic> json) {
    return Buffalo(
        id: json['id'],
        scalper: json['scalper'],
        snaggee: json['snaggee'],
        dateTime: DateTime.parse(json['dateTime']));
  }

  @override
  String toString() {
    return 'Buffalo ID: $id, Scalper: $scalper, Snaggee: $snaggee';
  }
}
