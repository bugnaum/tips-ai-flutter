import 'package:tips_generator/modules/leaguetips/data/models/success_percentage.dart';
import 'package:tips_generator/modules/leaguetips/data/models/team_model.dart';

import 'game_model.dart';
import 'next_game_model.dart';

class LeagueTipsModel {
  final List<Team>? teamsList;
  final List<Game>? gamesWithFreeTips;
  final List<NextGame>? nextGames;
  final SuccessPercentage? successPercentage;

  LeagueTipsModel({
    required this.teamsList,
    required this.gamesWithFreeTips,
    required this.nextGames,
    required this.successPercentage,
  });

  factory LeagueTipsModel.fromJson(Map<String, dynamic> json) {
    var teamsList = json['teamsList'] as List;
    var gamesWithFreeTips = json['gamesWithFreeTips'] as List;
    var nextGames = json['nextGames'] as List;

    return LeagueTipsModel(
      teamsList: teamsList.map((teamJson) => Team.fromJson(teamJson)).toList(),
      gamesWithFreeTips:
          gamesWithFreeTips.map((gameJson) => Game.fromJson(gameJson)).toList(),
      nextGames: nextGames
          .map((nextGameJson) => NextGame.fromJson(nextGameJson))
          .toList(),
      successPercentage: SuccessPercentage.fromJson(json['successPercentage']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'teamsList': teamsList?.map((team) => team.toJson()).toList(),
      'gamesWithFreeTips':
          gamesWithFreeTips?.map((game) => game.toJson()).toList(),
      'nextGames': nextGames?.map((nextGame) => nextGame.toJson()).toList(),
      'successPercentage': successPercentage?.toJson(),
    };
  }
}
