import 'package:http/http.dart' as http;

class HttpClient {
  static final _client = http.Client();
  static const String baseUrl = 'https://jsonplaceholder.typicode.com';

  static Future<http.Response> get(String endpoint) async {
    final url = Uri.parse('$baseUrl$endpoint');
    return await _client.get(url);
  }
}
