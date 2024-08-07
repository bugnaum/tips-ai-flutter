import 'package:flutter/material.dart';

import '../../data/models/leaguetips_model.dart';
import '../../data/repositories/leaguetips_repository_impl.dart';
import '../../domain/repositories/leaguetips_repository.dart';

class GetLeagueTips {
  final LeagueTipsRepository _repository;

  GetLeagueTips({
    LeagueTipsRepository? repository,
  }) : _repository = repository ?? LeagueTipsRepositoryImpl();

  Future<LeagueTipsModel?> execute() async {
    try {
      return await _repository.getLeagueTips();
    } catch (e) {
      debugPrint("Erro ao executar getLeagueTips: $e");
      return null;
    }
  }
}
