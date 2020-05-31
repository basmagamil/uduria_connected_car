import 'package:flutter/material.dart';

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
            display1: TextStyle(color: Colors.green, fontSize: 60),
            body2: TextStyle(fontSize: 28),
            display2: TextStyle(color: Colors.green, fontSize: 44),
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
  int _counter = 0;

  void _incrementCounter() {
    setState(() {
      _counter++;
    });
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
                    '$_counter',
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
                    '$_counter',
                    style: Theme.of(context).textTheme.display2,
                    // style: Theme.of(context).textTheme.display1,
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
                    '$_counter',
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
      floatingActionButton: FloatingActionButton(
        onPressed: _incrementCounter,
        tooltip: 'Increment',
        child: Icon(Icons.add),
      ),
    );
  }
}
