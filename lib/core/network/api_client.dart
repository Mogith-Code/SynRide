import 'dart:convert';
import 'package:http/http.dart' as http;

class ApiClient {
  final http.Client _client;

  ApiClient({http.Client? client}) : _client = client ?? http.Client();

  Future<Map<String, dynamic>> get(String url, {Map<String, String>? headers}) async {
    try {
      final response = await _client.get(
        Uri.parse(url),
        headers: headers ?? {'Content-Type': 'application/json'},
      );
      return _processResponse(response);
    } catch (e) {
      return {'success': false, 'error': e.toString()};
    }
  }

  Future<Map<String, dynamic>> post(String url, {Map<String, dynamic>? body, Map<String, String>? headers}) async {
    try {
      final response = await _client.post(
        Uri.parse(url),
        body: jsonEncode(body ?? {}),
        headers: headers ?? {'Content-Type': 'application/json'},
      );
      return _processResponse(response);
    } catch (e) {
      return {'success': false, 'error': e.toString()};
    }
  }

  Map<String, dynamic> _processResponse(http.Response response) {
    if (response.statusCode >= 200 && response.statusCode < 300) {
      if (response.body.isEmpty) return {'success': true};
      final data = jsonDecode(response.body);
      if (data is Map<String, dynamic>) {
        return {'success': true, ...data};
      }
      return {'success': true, 'data': data};
    } else {
      return {
        'success': false,
        'statusCode': response.statusCode,
        'message': response.reasonPhrase ?? 'API Request Failed',
      };
    }
  }
}
