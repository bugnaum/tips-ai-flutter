import '../models/api_response_model.dart';
import '../models/language_model.dart';
import 'api_call_response.dart';

abstract class Requestable<T extends GoladorModelResponse> {
  Future<ApiCallResponse> call({dynamic params});
  Future<ApiResponseModel<T>>? serialized({dynamic params});

  ApiCallResponse? apiResponse;
}