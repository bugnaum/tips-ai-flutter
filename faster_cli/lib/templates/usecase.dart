import '../../data/repositories/{{fileModuleName}}_repository_impl.dart';
import '../../domain/repositories/{{fileModuleName}}_repository.dart';
import '../../data/models/{{fileModuleName}}_model.dart';

class Get{{moduleName}} {
  final {{moduleName}}Repository _repository;

  Get{{moduleName}}({
    {{moduleName}}Repository? repository,
  }) : _repository = repository ?? {{moduleName}}RepositoryImpl();

  Future<{{moduleName}}Model?> execute() async {
    return await _repository.get{{moduleName}}();
  }
}

