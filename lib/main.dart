import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sockets_chart/pages/home.dart';
import 'package:sockets_chart/pages/status.dart';
import 'package:sockets_chart/services/socket_service.dart';

void main() => runApp(MainApp());

class MainApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [ChangeNotifierProvider(create: (_) => SocketService())],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        initialRoute: 'status',
        routes: {'home': (_) => HomePage(), 'status': (_) => StatusPage()},
      ),
    );
  }
}
