import '../../data/models/leaguetips_model.dart';

abstract class LeagueTipsRepository {
  Future<LeagueTipsModel> getLeagueTips();
}

