import '../../data/models/{{fileModuleName}}_model.dart';
import '../../domain/repositories/{{fileModuleName}}_repository.dart';

class {{moduleName}}RepositoryImpl extends {{moduleName}}Repository {

  @override
  Future<{{moduleName}}Model> get{{moduleName}}() async {
    return {{moduleName}}Model.fromJson({});
  }
}

