import 'package:design_system/components/cardpagecontrol/cardpagecontrol_component.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../data/models/next_game_model.dart';
import '../../domain/usecases/leaguetips_usecase.dart';

class LeagueTipsBloc extends Cubit<LeagueTipsState> {
  final GetLeagueTips getLeagueTips;

  LeagueTipsBloc({
    required this.getLeagueTips,
  }) : super(LeagueTipsLoading());

  Future<void> loadLeagueTips() async {
    try {
      emit(LeagueTipsLoading());
      final tips = await getLeagueTips.execute();
      final List<CardPageControlComponentDTO> dtoList = tips?.gamesWithFreeTips
              ?.map((element) =>
                  CardPageControlComponentDTO.fromJson(element.toJson()))
              .toList() ??
          [];
      emit(
        LeagueTipsLoaded(
          freeTipsDTO: dtoList,
          round: tips?.nextGames ?? [],
        ),
      );
    } catch (e) {
      emit(
        LeagueTipsError(
          message: e.toString(),
        ),
      );
    }
  }
}

abstract class LeagueTipsState {}

class LeagueTipsLoading extends LeagueTipsState {}

class LeagueTipsLoaded extends LeagueTipsState {
  final List<CardPageControlComponentDTO> freeTipsDTO;
  final List<NextGame> round;

  LeagueTipsLoaded({
    required this.freeTipsDTO,
    required this.round,
  });
}

class LeagueTipsError extends LeagueTipsState {
  final String message;

  LeagueTipsError({
    required this.message,
  });
}
