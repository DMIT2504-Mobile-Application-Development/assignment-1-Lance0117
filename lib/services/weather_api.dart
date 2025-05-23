import 'dart:convert';

import 'package:http/http.dart' as http;

/// Returns JSON from a provided endpoint
///
/// Will throw a [FormatException] if the [endpoint] is not a well-formed URI.
Future<dynamic> getWeatherForCity(String city) async {
  const weatherApiKey = "8e1a75480b4c86674740069a268fc4b0";
  final currentWeatherEndpoint = "https://api.openweathermap.org/data/2.5/weather?units=metric&q=$city&appid=$weatherApiKey";

  final url = Uri.parse(currentWeatherEndpoint);
  final response = await http.get(url);
  if (response.statusCode == 200) {
    return jsonDecode(response.body);
  } else {
    print('There was a problem with the request: status ${response.statusCode} received');
    print('Response body: ${response.body}');
    return null;
  }
}