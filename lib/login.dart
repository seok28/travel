// ignore_for_file: prefer_is_empty, deprecated_member_use

import 'dart:async';
import 'dart:convert';
import 'dart:math';

import 'package:crypto/crypto.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:junsu_project/data/user.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _LoginPage();
}

class _LoginPage extends State<LoginPage> with SingleTickerProviderStateMixin {
  FirebaseDatabase? _database;
  DatabaseReference? reference;
  final String _databaseURL =
      'https://junsu-project-5a94e-default-rtdb.firebaseio.com/';

  double opacity = 0;
  AnimationController? _animationController;
  Animation? _animation;
  TextEditingController? _idTextController;
  TextEditingController? _pwTextController;

  @override
  void initState() {
    super.initState();

    _idTextController = TextEditingController();
    _pwTextController = TextEditingController();

    _animationController =
        AnimationController(duration: const Duration(seconds: 3), vsync: this);
    _animation =
        Tween<double>(begin: 0, end: pi * 2).animate(_animationController!);
    _animationController!.repeat();
    Timer(const Duration(seconds: 2), () {
      setState(() {
        opacity = 1; // 페이지 생성 후 2초 후 타이머 시작
      });
    });

    _database = FirebaseDatabase(databaseURL: _databaseURL);
    reference = _database?.reference().child('user');
  }

  @override
  void dispose() {
    _animationController?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: Center(
          child: Column(
            children: <Widget>[
              AnimatedBuilder(
                animation: _animationController!,
                builder: (context, widget) {
                  return Transform.rotate(
                    angle: _animation?.value,
                    child: widget,
                  );
                },
                child: const Icon(
                  Icons.airplanemode_active,
                  color: Colors.deepOrangeAccent,
                  size: 80,
                ),
              ),
              const SizedBox(
                height: 100,
                child: Center(
                  child: Text(
                    '석준수 졸작 ',
                    style: TextStyle(fontSize: 30),
                  ),
                ),
              ),
              AnimatedOpacity(
                opacity: opacity,
                duration: const Duration(seconds: 1),
                child: Column(
                  children: <Widget>[
                    SizedBox(
                      width: 200,
                      child: TextField(
                        controller: _idTextController,
                        maxLines: 1,
                        decoration: const InputDecoration(
                            labelText: '아이디', border: OutlineInputBorder()),
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    SizedBox(
                      width: 200,
                      child: TextField(
                        controller: _pwTextController,
                        obscureText: true,
                        maxLines: 1,
                        decoration: const InputDecoration(
                            labelText: '비밀번호', border: OutlineInputBorder()),
                      ),
                    ),
                    Row(
                      children: <Widget>[
                        MaterialButton(
                            onPressed: () {
                              Navigator.of(context).pushNamed('/sign');
                            },
                            child: const Text('회원가입')),
                        MaterialButton(
                            onPressed: () {
                              if (_idTextController?.value.text.length == 0 ||
                                  _pwTextController?.value.text.length == 0) {
                                makeDialog('빈칸이 있습니다');
                              } else {
                                reference!
                                    .child(_idTextController!.value.text)
                                    .onValue
                                    .listen((event) {
                                  if (event.snapshot.value == null) {
                                    makeDialog('아이디가 없습니다');
                                  } else {
                                    reference!
                                        .child(_idTextController!.value.text)
                                        .onChildAdded
                                        .listen((event) {
                                      User user =
                                          User.fromSnapshot(event.snapshot);
                                      var bytes = utf8.encode(
                                          _pwTextController!.value.text);
                                      var digest = sha1.convert(bytes);
                                      if (user.pw == digest.toString()) {
                                        showsDialog(context);
                                        Future.delayed(
                                            const Duration(milliseconds: 1000),
                                            (() {
                                          Navigator.of(context)
                                              .pushReplacementNamed('/main',
                                                  arguments: _idTextController!
                                                      .value.text);
                                        }));
                                      } else {
                                        makeDialog('비밀번호가 틀립니다');
                                      }
                                    });
                                  }
                                });
                              }
                            },
                            child: const Text('로그인'))
                      ],
                      mainAxisAlignment: MainAxisAlignment.center,
                    )
                  ],
                ),
              )
            ],
            mainAxisAlignment: MainAxisAlignment.center,
          ),
        ),
      ),
    );
  }

  void makeDialog(String text) {
    showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            content: Text(text),
          );
        });
  }

  void showsDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => const AlertDialog(
        content: ListTile(
          title: Text("로그인 성공"),
          subtitle: Text("로그인 성공하였습니다"),
        ),
        // actions: <Widget>[
        //   FlatButton(
        //     child: const Text('Ok'),
        //     onPressed: () => Navigator.of(context).pop(),
        //   ),
        // ],
      ),
    );
  }
}
