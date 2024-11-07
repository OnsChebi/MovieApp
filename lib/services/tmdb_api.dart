import 'package:filmood/utils/api_constants.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class TmdbApi {
  final http.Client _client;

  TmdbApi(this._client);

  Future<dynamic> get(String path) async {
    try {
      final response = await _client.get(
        Uri.parse('${ApiConstants.BASE_URL}$path?api_key=${ApiConstants.API_KEY}'),
        headers: {
          'Content-Type': 'application/json',
        },
      );

      if (response.statusCode == 200) {
        final jsonResponse = json.decode(response.body);
        return jsonResponse;
      } else {
        throw Exception('Failed to load data: ${response.statusCode} - ${response.reasonPhrase}');
      }
    } catch (error) {
      // for other errors( network or parsing )
      throw Exception('Failed to perform GET request: $error');
    }
  }
}
