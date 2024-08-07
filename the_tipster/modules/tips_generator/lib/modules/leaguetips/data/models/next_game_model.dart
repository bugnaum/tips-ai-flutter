import 'game_model.dart';

class NextGame {
  final String? round;
  final List<Game>? games;

  NextGame({
    required this.round,
    required this.games,
  });

  factory NextGame.fromJson(Map<String, dynamic> json) {
    var gamesList = json['games'] as List;
    List<Game> games =
        gamesList.map((gameJson) => Game.fromJson(gameJson)).toList();

    return NextGame(
      round: json['round'],
      games: games,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'round': round,
      'games': games?.map((game) => game.toJson()).toList(),
    };
  }
}
