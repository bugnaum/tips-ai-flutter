import 'package:flutter_bloc/flutter_bloc.dart';
import '../../data/models/{{fileModuleName}}_model.dart';
import '../../domain/usecases/{{fileModuleName}}_usecase.dart';

class {{moduleName}}Bloc extends Cubit<{{moduleName}}State> {
  final Get{{moduleName}} get{{moduleName}};

  {{moduleName}}Bloc({
    required this.get{{moduleName}},
  }) : super({{moduleName}}Loading());

  Future<void> load{{moduleName}}() async {
    try {
      emit({{moduleName}}Loading());
      final {{fileModuleName}} = await get{{moduleName}}.execute();
      emit({{moduleName}}Loaded(
        {{fileModuleName}}: {{fileModuleName}},
      ));
    } catch (e) {
      emit({{moduleName}}Error(
        message: e.toString(),
      ));
    }
  }
}

abstract class {{moduleName}}State {}

class {{moduleName}}Loading extends {{moduleName}}State {}

class {{moduleName}}Loaded extends {{moduleName}}State {
  final {{moduleName}}Model? {{fileModuleName}};

  {{moduleName}}Loaded({
    this.{{fileModuleName}},
  });
}

class {{moduleName}}Error extends {{moduleName}}State {
  final String message;

  {{moduleName}}Error({
    required this.message,
  });
}
