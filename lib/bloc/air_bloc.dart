import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:flutter_dust/models/air_result.dart';
import 'package:rxdart/rxdart.dart';

class AirBloc{
  final _airSubject = BehaviorSubject<AirResult>();

  AirBloc(){
    fetch();
  }

  Future<AirResult> fetchData() async {
    var response = await http.get(Uri.parse(
        'http://api.airvisual.com/v2/nearest_city?key=7d0144eb-fa56-4b7d-ac7a-7fc4baa6582c'));
    AirResult result = AirResult.fromJson(json.decode(response.body));

    return result;
  }

  void fetch() async {
    var airResult = await fetchData();
    _airSubject.add(airResult);
  }
  Stream<AirResult> get airResult => _airSubject.stream;

}