class Game {
  final String? round;
  final String? date;
  final String? home;
  final String? homeId;
  final String? away;
  final String? awayId;
  final String? homeImageUrl;
  final String? awayImageUrl;
  final String? localName;
  final String? fixtureId;
  final bool? tipsAvailable;
  final bool? canListenTip;

  Game({
    required this.round,
    required this.date,
    required this.home,
    required this.homeId,
    required this.away,
    required this.awayId,
    required this.homeImageUrl,
    required this.awayImageUrl,
    required this.localName,
    required this.fixtureId,
    required this.tipsAvailable,
    required this.canListenTip,
  });

  factory Game.fromJson(Map<String, dynamic> json) {
    return Game(
      round: json['round'],
      date: json['date'],
      home: json['home'],
      homeId: json['homeId'],
      away: json['away'],
      awayId: json['awayId'],
      homeImageUrl: json['homeImageUrl'],
      awayImageUrl: json['awayImageUrl'],
      localName: json['localName'],
      fixtureId: json['fixtureId'],
      tipsAvailable: json['tipsAvailable'],
      canListenTip: json['canListenTip'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'round': round,
      'date': date,
      'home': home,
      'homeId': homeId,
      'away': away,
      'awayId': awayId,
      'homeImageUrl': homeImageUrl,
      'awayImageUrl': awayImageUrl,
      'localName': localName,
      'fixtureId': fixtureId,
      'tipsAvailable': tipsAvailable,
      'canListenTip': canListenTip,
    };
  }
}
