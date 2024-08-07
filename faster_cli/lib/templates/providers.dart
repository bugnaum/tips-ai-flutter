import 'package:provider/provider.dart';

import '../../data/repositories/{{fileModuleName}}_repository_impl.dart';
import '../../presentation/blocs/{{fileModuleName}}_bloc.dart';
import '../repositories/{{fileModuleName}}_repository.dart';
import '../usecases/{{fileModuleName}}_usecase.dart';

class {{moduleName}}Providers {
  static List<Provider> providers() {
    return [
      Provider<{{moduleName}}Repository>(
        create: (_) => {{moduleName}}RepositoryImpl(),
      ),
      Provider<Get{{moduleName}}>(
        create: (context) => Get{{moduleName}}(
          repository: context.read<{{moduleName}}Repository>(),
        ),
      ),
      Provider<{{moduleName}}Bloc>(
        create: (context) => {{moduleName}}Bloc(
          get{{moduleName}}: context.read<Get{{moduleName}}>(),
        ),
      ),
    ];
  }
}
