import 'package:flutter/material.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:junsu_project/data/Plandata.dart';
import 'package:sqflite/sqflite.dart';

class PlanPage extends StatefulWidget {
  final DatabaseReference? databaseReference; // 실시간 데이터베이스 변수
  final Future<Database>? db; // 내부에 저장되는 데이터베이스
  final String? id; // 로그인한 아이디
  PlanPage({this.databaseReference, this.db, this.id});

  @override
  State<StatefulWidget> createState() => _PlanPage();
}

class _PlanPage extends State<PlanPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold();
  }
}
