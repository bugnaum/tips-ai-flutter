import 'package:http/http.dart' as http;
import 'dart:convert';

class {{moduleName}}RemoteDataSource {
  final http.Client httpClient;

  {{moduleName}}RemoteDataSource({required this.httpClient});

  Future<Map<String, dynamic>> fetchDataFromApi() async {
    final url = Uri.parse('https://api.example.com/data');

    try {
      final response = await httpClient.get(url);

      if (response.statusCode == 200) {
        return jsonDecode(response.body);
      } else {
        throw Exception('Failed to load data from API');
      }
    } catch (e) {
      throw Exception('Failed to connect to the API');
    }
  }
}
