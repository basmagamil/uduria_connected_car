import 'dart:async';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Speedometer',
      theme: ThemeData(
          primarySwatch: Colors.blue,
          textTheme: TextTheme(
            body1: TextStyle(fontSize: 36),
            display1: TextStyle(
                color: Colors.green, fontSize: 80, fontFamily: "Digital"),
            body2: TextStyle(fontSize: 28),
            display2: TextStyle(
                color: Colors.green, fontSize: 60, fontFamily: "Digital"),
          )),
      debugShowCheckedModeBanner: false,
      home: MyHomePage(title: 'Speedometer'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  double _lat = 0;
  double _long = 0;
  // double _speed = 0; //int
  int _speed = 0;
  int _duration1 = 0;
  int _duration2 = 0;
  var geolocator = Geolocator();
  var locationOptions = LocationOptions(accuracy: LocationAccuracy.high);
  var stopwatch1 = new Stopwatch();
  var stopwatch2 = new Stopwatch();

  _MyHomePageState() : super() {
    var timer =
        new Timer.periodic(new Duration(milliseconds: 1000), _updateTime);

    // Stream<int> stream =
    //     Stream<int>.periodic(new Duration(milliseconds: 1000), incrementSpeed);
    // updateSpeed(stream);

    StreamSubscription<Position> positionStream = geolocator
        .getPositionStream(locationOptions)
        .listen((Position position) {
      setState(() {
        _lat = position?.latitude;
        _long = position?.longitude;
        _speed = (position?.speed * 3.6).round(); //remove 100
      });
      if (_speed >= 10 && _speed <= 11 && !stopwatch1.isRunning) {
        stopwatch1.reset();
        stopwatch1.start();
      } else if ((_speed >= 30 || _speed <= 10) && stopwatch1.isRunning) {
        stopwatch1.stop();
      } else if (_speed <= 31 && _speed >= 30 && !stopwatch2.isRunning) {
        stopwatch2.reset();
        stopwatch2.start();
      } else if ((_speed <= 10 || _speed >= 30) && stopwatch2.isRunning) {
        stopwatch2.stop();
      }
    });
  }

  // int incrementSpeed(int value) {
  //   // return value;
  //   return (40 - value).abs();
  // }

  // void updateSpeed(Stream<int> stream) async {
  //   await for (var value in stream) {
  //     setState(() {
  //       _speed = value;
  //     });
  //   }
  // }

  _updateTime(Timer timer) {
    if (stopwatch1.isRunning) {
      setState(() {
        _duration1 = (stopwatch1.elapsedMilliseconds * 0.001).round();
      });
    }
    if (stopwatch2.isRunning) {
      setState(() {
        _duration2 = (stopwatch2.elapsedMilliseconds * 0.001).round();
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Expanded(
              flex: 4,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Text(
                    'Current Speed',
                    style: Theme.of(context).textTheme.body1,
                  ),
                  Text(
                    '$_speed',
                    style: Theme.of(context).textTheme.display1,
                  ),
                  Text(
                    'kmh',
                    style: Theme.of(context).textTheme.body1,
                  ),
                ],
              ),
            ),
            Expanded(
              flex: 3,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Text(
                    'From 10 to 30',
                    style: Theme.of(context).textTheme.body2,
                  ),
                  Text(
                    '$_duration1',
                    style: Theme.of(context).textTheme.display2,
                  ),
                  Text(
                    'Seconds',
                    style: Theme.of(context).textTheme.body2,
                  ),
                ],
              ),
            ),
            Expanded(
              flex: 3,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Text(
                    'From 30 to 10',
                    style: Theme.of(context).textTheme.body2,
                  ),
                  Text(
                    '$_duration2',
                    style: Theme.of(context).textTheme.display2,
                  ),
                  Text(
                    'Seconds',
                    style: Theme.of(context).textTheme.body2,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
