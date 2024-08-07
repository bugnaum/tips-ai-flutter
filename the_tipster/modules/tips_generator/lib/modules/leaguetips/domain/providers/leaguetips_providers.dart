import 'package:provider/provider.dart';

import '../../data/repositories/leaguetips_repository_impl.dart';
import '../../presentation/blocs/leaguetips_bloc.dart';
import '../repositories/leaguetips_repository.dart';
import '../usecases/leaguetips_usecase.dart';

class LeaguetipsProviders {
  static List<Provider> providers() {
    return [
      Provider<LeagueTipsRepository>(
        create: (_) => LeagueTipsRepositoryImpl(),
      ),
      Provider<GetLeagueTips>(
        create: (context) => GetLeagueTips(
          repository: context.read<LeagueTipsRepository>(),
        ),
      ),
      Provider<LeagueTipsBloc>(
        create: (context) => LeagueTipsBloc(
          getLeagueTips: context.read<GetLeagueTips>(),
        ),
      ),
    ];
  }
}
