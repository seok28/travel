import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'main/favoritePage.dart';
import 'main/settingPage.dart';
import 'main/mapPage.dart';
import 'plan/planPage.dart';
import 'package:sqflite/sqflite.dart';

class MainPage extends StatefulWidget {
  final Future<Database> database;
  // ignore: use_key_in_widget_constructors
  const MainPage(this.database);
  @override
  State<StatefulWidget> createState() => _MainPage();
}

class _MainPage extends State<MainPage> with SingleTickerProviderStateMixin {
  TabController? controller;
  FirebaseDatabase? _database;
  DatabaseReference? reference;
  final String _databaseURL =
      'https://junsu-project-5a94e-default-rtdb.firebaseio.com/';
  String? id;

  @override
  void initState() {
    super.initState();
    controller = TabController(length: 4, vsync: this);
    _database = FirebaseDatabase(databaseURL: _databaseURL);
    reference = _database!.reference();
  }

  @override
  void dispose() {
    controller!.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    id = ModalRoute.of(context)!.settings.arguments as String?;
    return Scaffold(
        body: TabBarView(
          children: <Widget>[
            MapPage(
              databaseReference: reference,
              db: widget.database,
              id: id,
            ), // 맵 페이지
            FavoritePage(
              databaseReference: reference,
              db: widget.database,
              id: id,
            ),
            const MyApp(), // 즐겨 찾기
            SettingPage(
              databaseReference: reference,
              id: id,
            ), // 설정 화면
          ],
          controller: controller,
        ),
        bottomNavigationBar: TabBar(
          tabs: const <Tab>[
            Tab(
              icon: Icon(Icons.map),
            ),
            Tab(
              icon: Icon(Icons.star),
            ),
            Tab(
              icon: Icon(Icons.featured_play_list_rounded),
            ),
            Tab(
              icon: Icon(Icons.settings),
            )
          ],
          labelColor: Colors.amber,
          indicatorColor: Colors.deepOrangeAccent,
          controller: controller,
        ));
  }
}
