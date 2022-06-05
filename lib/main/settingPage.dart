import 'dart:io';

import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SettingPage extends StatefulWidget {
  final DatabaseReference? databaseReference; // 실시간 데이터베이스 변수
  final String? id; // 로그인한 아이디
  final FirebaseDatabase database = FirebaseDatabase.instance; // 사용자 id를 가져오기 위한 인스턴스 생성
  SettingPage({this.databaseReference, this.id});

  @override
  State<StatefulWidget> createState() => _SettingPage();
}

class _SettingPage extends State<SettingPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('$widget.id'), // firebase realtime database read 
      ),
    );
  } // 
}
