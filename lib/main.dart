import 'package:flutter/material.dart';
import 'package:flutter_dust/bloc/air_bloc.dart';
import 'package:flutter_dust/models/air_result.dart';

void main() {
  runApp(const MyApp());
}

final airBloc = AirBloc();
class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: Main(),
    );
  }
}

class Main extends StatefulWidget {
  const Main({super.key});

  @override
  State<Main> createState() => _MainState();
}

class _MainState extends State<Main> {


  @override
  void initState() {
    super.initState();

    // fetchData().then((airResult) {
    //   setState(() {
    //     _result = airResult;
    //     if (airResult.data?.current?.pollution != null) {
    //       _aqius = airResult.data!.current!.pollution!.aqius!;
    //       _tp = airResult.data!.current!.weather!.tp!;
    //       _hu = airResult.data!.current!.weather!.hu!;
    //       _ws = airResult.data!.current!.weather!.ws!;
    //     }
    //   });
    // });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder<AirResult>(
            stream: airBloc.airResult,
            builder: (context, snapshot) {
              if(snapshot.hasData){
                return buildBody(snapshot.data!);
              }else{
                return Center(child: CircularProgressIndicator());
              }
            }
          ),
    );
  }

  Widget buildBody(AirResult result) {
    return Padding(
            padding: const EdgeInsets.all(8.0),
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    '현제위치 미세먼지',
                    style: TextStyle(
                      fontSize: 30,
                    ),
                  ),
                  SizedBox(height: 16),
                  Card(
                    child: Column(
                      children: [
                        Container(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              Text('얼굴사진'),
                              Text(
                                '${result.data!.current!.pollution!.aqius!}',
                                style: TextStyle(
                                  fontSize: 40,
                                ),
                              ),
                              Text(
                                getString(result!),
                                style: TextStyle(
                                  fontSize: 20,
                                ),
                              ),
                            ],
                          ),
                          color: getColor(result!),
                          padding: EdgeInsets.all(8.0),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              Row(
                                children: [
                                  Image.network(
                                    'https://airvisual.com/images/${result!.data!.current!.weather!.ic!}.png',
                                    width: 32,
                                    height: 32,
                                  ),
                                  Text(
                                    '${result.data!.current!.weather!.tp}℃',
                                    style: TextStyle(fontSize: 16),
                                  ),
                                ],
                              ),
                              Text(
                                '습도 ${result.data!.current!.weather!.hu}%',
                              ),
                              Text(
                                '풍속 ${result.data!.current!.weather!.ws}m/s',
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 16),
                  ElevatedButton(
                    onPressed: () {
                      airBloc.fetch();
                    },
                    child: Icon(Icons.refresh),
                  ),
                ],
              ),
            ),
          );
  }

  Color getColor(AirResult result) {
    if (result.data!.current!.pollution!.aqius! <= 50) {
      return Colors.greenAccent;
    } else if (result.data!.current!.pollution!.aqius! <= 100) {
      return Colors.yellow;
    } else if (result.data!.current!.pollution!.aqius! <= 150) {
      return Colors.orange;
    } else {
      return Colors.red;
    }
  }

  String getString(AirResult result) {
    if (result.data!.current!.pollution!.aqius! <= 50) {
      return '좋음';
    } else if (result.data!.current!.pollution!.aqius! <= 100) {
      return '보통';
    } else if (result.data!.current!.pollution!.aqius! <= 150) {
      return '나쁨';
    } else {
      return '최악';
    }
  }
}
