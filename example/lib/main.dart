import 'dart:math';

import 'package:flutter/material.dart';
import 'package:sliding_number/sliding_number.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _points = 0;
  final random = Random();

  void _incrementPoints() {
    setState(() => _points += random.nextInt(100));
  }

  void _decrementPoints() {
    setState(() => _points -= random.nextInt(100));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('SlidingNumber Demo'),
      ),
      body: Center(
        child: Column(
          children: <Widget>[
            Expanded(child: Container()),
            Text('Your points:'),
            SlidingNumber(
              number: _points,
              style: Theme.of(context).textTheme.headline3!,
              duration: const Duration(milliseconds: 500),
              curve: Curves.easeOutQuint,
            ),
            Expanded(child: Container()),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  FloatingActionButton(
                    onPressed: _decrementPoints,
                    tooltip: 'Decrement',
                    child: Icon(Icons.remove),
                  ),
                  FloatingActionButton(
                    onPressed: _incrementPoints,
                    tooltip: 'Increment',
                    child: Icon(Icons.add),
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
