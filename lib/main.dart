import 'package:flutter/material.dart';
import 'package:sockets_chart/pages/home.dart';
import 'package:sockets_chart/pages/home.dart';

void main() => runApp(MainApp());

class MainApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: 'home',
      routes: {
        'home': (context) => HomePage(),
      },
    );
  }
}
