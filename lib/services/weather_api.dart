import 'dart:convert';

import 'package:http/http.dart' as http;

/// Returns JSON from a provided endpoint
///
/// Will throw a [FormatException] if the [endpoint] is not a well-formed URI.

const String weatherApiKey = "8e1a75480b4c86674740069a268fc4b0";
final String currentWeatherEndpoint = "";

Future<dynamic> getWeatherForCity({required String city}) async {
  try {
    final String currentWeatherEndpoint =
        "https://api.openweathermap.org/data/2.5/weather?units=metric&q=$city&appid=$weatherApiKey";

    final url = Uri.parse(currentWeatherEndpoint);
    final response = await http.get(url);

    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    } else {
      throw Exception(
          'There was a problem with the request: status ${response.statusCode} received');
    }
  } catch (e) {
    throw Exception('There was a problem with the request: $e');
  }
}
