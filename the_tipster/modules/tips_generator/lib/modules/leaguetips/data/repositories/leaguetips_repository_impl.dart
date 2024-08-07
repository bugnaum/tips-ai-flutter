import 'package:network/network.dart';

import '../../data/models/leaguetips_model.dart';
import '../../domain/repositories/leaguetips_repository.dart';

class LeagueTipsRepositoryImpl extends LeagueTipsRepository {
  @override
  Future<LeagueTipsModel> getLeagueTips() async {
    try {
      final response = await ApiManager.instance.makeApiCall(
        callName: 'LeagueTipsRequest',
        apiUrl: '${Network.baseUrl}/v1/home',
        callType: ApiCallType.get,
        headers: {
          ...Network.headers,
        },
        bodyType: BodyType.json,
      );

      if (response.jsonBody == null || !response.succeeded) {
        throw Exception("Resposta da API não contém dados válidos.");
      }

      return LeagueTipsModel.fromJson(
        response.jsonBody,
      );
    } catch (e) {
      throw Exception("Ocorreu um erro inesperado: $e");
    }
  }
}
