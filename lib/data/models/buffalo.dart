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

  String getDateTimeString() {
    return '${getDateString()} at ${getTimeString()}';
  }

  String getDateString() {
    String year = dateTime.year.toString();
    String month = dateTime.month.toString();
    String day = dateTime.day.toString();

    return '$day.$month.$year';
  }

  String getTimeString() {
    String hour = dateTime.hour.toString();
    String minute = dateTime.minute.toString();
    String second = dateTime.second.toString();

    return '$hour:$minute:$second';
  }

  @override
  String toString() {
    return 'Buffalo ID: $id, Scalper: $scalper, Snaggee: $snaggee';
  }
}
