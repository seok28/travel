// ignore: file_names
// ignore_for_file: deprecated_member_use

import 'dart:io';

import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
// import 'package:google_mobile_ads/google_mobile_ads.dart';

class SettingPage extends StatefulWidget {
  final DatabaseReference? databaseReference;
  final String? id;

  // ignore: use_key_in_widget_constructors
  const SettingPage({this.databaseReference, this.id});

  @override
  State<StatefulWidget> createState() => _SettingPage();
}

class _SettingPage extends State<SettingPage> {
  bool pushCheck = true;

  @override
  void initState() {
    super.initState();
    _loadData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('설정하기'),
      ),
      // ignore: avoid_unnecessary_containers
      body: Container(
        child: Center(
          child: Column(
            children: <Widget>[
              Row(
                children: <Widget>[
                  const Text(
                    '푸시 알림',
                    style: TextStyle(fontSize: 20),
                  ),
                  Switch(
                      value: pushCheck,
                      onChanged: (value) {
                        setState(() {
                          pushCheck = value;
                        });
                        _setData(value);
                      })
                ],
                mainAxisAlignment: MainAxisAlignment.spaceAround,
              ),
              const SizedBox(
                height: 50,
              ),
              MaterialButton(
                onPressed: () {
                  AlertDialog dialog = AlertDialog(
                    title:
                        const Text('로그아웃', style: TextStyle(color: Colors.red)),
                    content: const Text('정말로 로그아웃 하시겠습니까?'),
                    actions: <Widget>[
                      MaterialButton(
                          onPressed: () {
                            showsDialog(context);
                            Navigator.of(context).pushNamedAndRemoveUntil(
                                '/', (Route<dynamic> route) => false);
                          },
                          child: const Text('예')),
                      MaterialButton(
                          onPressed: () {
                            Navigator.of(context).pop();
                          },
                          child: const Text('아니요')),
                    ],
                  );
                  showDialog(
                      context: context,
                      builder: (context) {
                        return dialog;
                      });
                },
                child: const Text(
                  '로그아웃',
                  style: TextStyle(fontSize: 20, color: Colors.white),
                ),
                color: Colors.blueAccent,
              ),
              const SizedBox(
                height: 50,
              ),
              MaterialButton(
                color: Colors.blueAccent,
                onPressed: () {
                  AlertDialog dialog = AlertDialog(
                    title: const Text('아이디 삭제',
                        style: TextStyle(color: Colors.red)),
                    content: const Text('아이디를 삭제하시겠습니까?'),
                    actions: <Widget>[
                      MaterialButton(
                          onPressed: () {
                            // ignore: avoid_print
                            print(widget.id);
                            widget.databaseReference!
                                .child('user')
                                .child(widget.id!)
                                .remove();

                            Navigator.of(context).pushNamedAndRemoveUntil(
                                '/', (Route<dynamic> route) => false);
                            FlutterDialog();
                          },
                          child: const Text('예')),
                      MaterialButton(
                          onPressed: () {
                            Navigator.of(context).pop();
                          },
                          child: const Text('아니요')),
                    ],
                  );
                  showDialog(
                      context: context,
                      builder: (context) {
                        return dialog;
                      });
                },
                child: const Text('회원 탈퇴', style: TextStyle(fontSize: 20)),
              ),
              // SizedBox(
              //   height: 50,
              //   child:  Text(
              //     '계획 페이지 이동',
              //     style: TextStyle(fontSize: 20, color: Colors.white),
              //   ),
              // )

              // if (_banner != null)
              //   Container(
              //     color: Colors.green,
              //     width: _banner!.size.width.toDouble(),
              //     height: _banner!.size.height.toDouble(),
              //     child: AdWidget(ad: _banner!),
              //   ),
            ],
            mainAxisAlignment: MainAxisAlignment.center,
          ),
        ),
      ),
    );
  }

  void _setData(bool value) async {
    var key = "push";
    SharedPreferences pref = await SharedPreferences.getInstance();
    pref.setBool(key, value);
  }

  void _loadData() async {
    var key = "push";
    SharedPreferences pref = await SharedPreferences.getInstance();
    setState(() {
      var value = pref.getBool(key);
      if (value == null) {
        setState(() {
          pushCheck = true;
        });
      } else {
        setState(() {
          pushCheck = value;
        });
      }
    });
  }

  void showsDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        content: const ListTile(
          title: Text("로그아웃"),
          subtitle: Text("로그아웃 되었습니다."),
        ),
        actions: <Widget>[
          FlatButton(
            child: const Text('Ok'),
            onPressed: () => Navigator.of(context).pop(),
          ),
        ],
      ),
    );
  }

  // ignore: non_constant_identifier_names
  void FlutterDialog() {
    showDialog(
        context: context,
        //barrierDismissible - Dialog를 제외한 다른 화면 터치 x
        barrierDismissible: false,
        builder: (BuildContext context) {
          return AlertDialog(
            // RoundedRectangleBorder - Dialog 화면 모서리 둥글게 조절
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10.0)),
            //Dialog Main Title
            title: Column(
              children: const <Widget>[
                Text("Dialog Title"),
              ],
            ),
            //
            content: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: const <Widget>[
                Text(
                  "Dialog Content",
                ),
              ],
            ),
            actions: <Widget>[
              FlatButton(
                child: const Text("확인"),
                onPressed: () {
                  Navigator.pop(context);
                },
              ),
            ],
          );
        });
  }
}
