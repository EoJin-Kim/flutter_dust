// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility in the flutter_test package. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.


import 'package:flutter_dust/models/air_result.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
void main() {
  test('http_test', () async {
    var response = await http.get(Uri.parse('http://api.airvisual.com/v2/nearest_city?key=7d0144eb-fa56-4b7d-ac7a-7fc4baa6582c'));

    expect(response.statusCode, 200);
    
    AirResult result = AirResult.fromJson(json.decode(response.body));
    expect(result.status, 'success');
  });
}
