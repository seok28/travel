import 'package:flutter/material.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:junsu_project/data/Plandata.dart';
import 'package:sqflite/sqflite.dart';

class PlanDetailPage extends StatefulWidget {
  final DatabaseReference? databaseReference; // 실시간 데이터베이스 변수
  final Future<Database>? db; // 내부에 저장되는 데이터베이스
  final String? id; // 로그인한 아이디
  // ignore: use_key_in_widget_constructors
  const PlanDetailPage({this.databaseReference, this.db, this.id});

  @override
  State<StatefulWidget> createState() => _PlanDetailPage();
}

class _PlanDetailPage extends State<PlanDetailPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold();
  }
}
