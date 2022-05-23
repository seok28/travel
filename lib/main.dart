import 'package:flutter/material.dart';
import 'package:junsu_project/plan/Planpage.dart';
import 'package:junsu_project/signPage.dart';
import 'login.dart';
import 'mainPage.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: '석준수 졸작',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      initialRoute: '/',
      routes: {
        '/': (context) => LoginPage(),
        '/sign': (context) => SignPage(),
        '/main': (context) => MainPage(),
        '/plan': (context) => PlanPage(),
      },
    );
  }
}
