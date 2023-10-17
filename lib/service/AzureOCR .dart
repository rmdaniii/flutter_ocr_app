
import 'package:http/http.dart' as http;
import 'dart:convert';

class AzureOCR {
  final String apiKey;
  final String endpoint;

  AzureOCR({required this.apiKey, required this.endpoint});

  Future<Map<String, dynamic>> recognizeText(String imagePath) async {
    final url = '$endpoint/vision/v3.1/ocr?language=eng';
    final headers = {
      'Content-Type': 'application/json',
      'Ocp-Apim-Subscription-Key': apiKey,
    };

    final requestBody = jsonEncode({'url': imagePath});
    final response = await http.post(
      Uri.parse(url),
      headers: headers,
      body: requestBody,
    );

    if (response.statusCode == 200) {
      return json.decode(response.body);
    } else {
      throw Exception('Failed to recognize text. ${response.statusCode}');
    }
  }
}