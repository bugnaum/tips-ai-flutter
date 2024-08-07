import 'package:flutter_bloc/flutter_bloc.dart';
import '../../data/models/leaguetips_model.dart';
import '../../domain/usecases/leaguetips_usecase.dart';

class LeagueTipsBloc extends Cubit<LeagueTipsState> {
  final GetLeagueTips getLeagueTips;

  LeagueTipsBloc({
    required this.getLeagueTips,
  }) : super(LeagueTipsLoading());

  Future<void> loadLeagueTips() async {
    try {
      emit(LeagueTipsLoading());
      final leaguetips = await getLeagueTips.execute();
      emit(LeagueTipsLoaded(
        leaguetips: leaguetips,
      ));
    } catch (e) {
      emit(LeagueTipsError(
        message: e.toString(),
      ));
    }
  }
}

abstract class LeagueTipsState {}

class LeagueTipsLoading extends LeagueTipsState {}

class LeagueTipsLoaded extends LeagueTipsState {
  final LeagueTipsModel? leaguetips;

  LeagueTipsLoaded({
    this.leaguetips,
  });
}

class LeagueTipsError extends LeagueTipsState {
  final String message;

  LeagueTipsError({
    required this.message,
  });
}
