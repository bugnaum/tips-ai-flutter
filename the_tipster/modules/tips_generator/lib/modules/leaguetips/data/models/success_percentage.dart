class SuccessPercentage {
  final String? title;
  final String? allTime;
  final String? currentMonth;
  final String? currentWeek;
  final String? upcoming;

  SuccessPercentage({
    required this.title,
    required this.allTime,
    required this.currentMonth,
    required this.currentWeek,
    required this.upcoming,
  });

  factory SuccessPercentage.fromJson(Map<String, dynamic> json) {
    return SuccessPercentage(
      title: json['title'],
      allTime: json['allTime'],
      currentMonth: json['currentMonth'],
      currentWeek: json['currentWeek'],
      upcoming: json['upcoming'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'title': title,
      'allTime': allTime,
      'currentMonth': currentMonth,
      'currentWeek': currentWeek,
      'upcoming': upcoming,
    };
  }
}
