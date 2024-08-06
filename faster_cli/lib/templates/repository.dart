import '../../data/models/{{fileModuleName}}_model.dart';

abstract class {{moduleName}}Repository {
  Future<{{moduleName}}Model> get{{moduleName}}();
}

