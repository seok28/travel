import 'package:flutter/material.dart';
// import 'package:junsu_project/plan/Planpage.dart';
import 'package:junsu_project/signPage.dart';
import 'login.dart';
import 'mainPage.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  Future<Database> initDatabase() async {
    return openDatabase(
      join(await getDatabasesPath(), 'tour_database.db'),
      onCreate: (db, version) {
        return db.execute(
            "CREATE TABLE place(id INTEGER PRIMARY KEY AUTOINCREMENT, title TEXT, tel TEXT , zipcode TEXT , address TEXT , mapx Number , mapy Number , imagePath TEXT)");
      },
      version: 1,
    );
  }

  @override
  Widget build(BuildContext context) {
    Future<Database> database = initDatabase();
    return MaterialApp(
      title: '심플 트립 플래너',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      initialRoute: '/',
      routes: {
        '/': (context) {
          return FutureBuilder(
            future: Firebase.initializeApp(),
            builder: (context, snapshot) {
              if (snapshot.hasError) {
                return const Center(
                  child: Text('Error'),
                );
              }

              if (snapshot.connectionState == ConnectionState.done) {
                _getToken();
                _initFirebaseMessaging(context);
                return const LoginPage();
              }

              return const Center(
                child: CircularProgressIndicator(),
              );
            },
          );
        },
        '/sign': (context) => const SignPage(),
        '/main': (context) => MainPage(database),
      },
    );
  }

  _initFirebaseMessaging(BuildContext context) {
    FirebaseMessaging.onMessage.listen((RemoteMessage event) async {
      bool? pushCheck = await _loadData();
      if (pushCheck!) {
        showDialog(
            context: context,
            // ignore: non_constant_identifier_names
            builder: (BuildContext BuildContext) {
              return AlertDialog(
                title: Text(event.notification!.title!),
                content: Text(event.notification!.body!),
                actions: [
                  TextButton(
                    child: const Text("ok"),
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                  )
                ],
              );
            });
      }
    });
    FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {});
  }

  Future<bool?> _loadData() async {
    var key = "push";
    SharedPreferences pref = await SharedPreferences.getInstance();
    var value = pref.getBool(key);
    return value;
  }

  _getToken() async {
    FirebaseMessaging messaging = FirebaseMessaging.instance;

    // ignore: avoid_print
    print("messaging.getToken() , ${await messaging.getToken()}");
  }
}
