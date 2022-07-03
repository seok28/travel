// ignore_for_file: deprecated_member_use

import 'dart:convert';

import 'package:crypto/crypto.dart';
// import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:junsu_project/data/user.dart';

class SignPage extends StatefulWidget {
  const SignPage({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _SignPage();
}

class _SignPage extends State<SignPage> {
  FirebaseDatabase? _database;
  DatabaseReference? reference;
  final String _databaseURL =
      'https://junsu-project-5a94e-default-rtdb.firebaseio.com/';

  TextEditingController? _idTextController;
  TextEditingController? _pwTextController;
  TextEditingController? _pwCheckTextController;

  @override
  void initState() {
    super.initState();
    _idTextController = TextEditingController();
    _pwTextController = TextEditingController();
    _pwCheckTextController = TextEditingController();

    _database = FirebaseDatabase(databaseURL: _databaseURL);
    reference = _database?.reference().child('user');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('회원가입'),
      ),
      body: Center(
        child: Column(
          children: <Widget>[
            SizedBox(
              width: 200,
              child: TextField(
                controller: _idTextController,
                maxLines: 1,
                decoration: const InputDecoration(
                    hintText: '4자 이상 입력해주세요',
                    labelText: '아이디',
                    border: OutlineInputBorder()),
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
                    hintText: '6자 이상 입력해주세요',
                    labelText: '비밀번호',
                    border: OutlineInputBorder()),
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            SizedBox(
              width: 200,
              child: TextField(
                controller: _pwCheckTextController,
                obscureText: true,
                maxLines: 1,
                decoration: const InputDecoration(
                    hintText: '비밀번호 확인',
                    labelText: '비밀번호와 동일하게 입력해주세요',
                    border: OutlineInputBorder()),
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            MaterialButton(
              onPressed: () {
                if (_idTextController!.value.text.length >= 4 &&
                    _pwTextController!.value.text.length >= 6) {
                  if (_pwTextController!.value.text ==
                      _pwCheckTextController!.value.text) {
                    var bytes = utf8.encode(_pwTextController!.value.text);
                    var digest = sha1.convert(bytes);
                    reference!
                        .child(_idTextController!.value.text)
                        .push()
                        .set(User(
                                _idTextController!.value.text,
                                digest.toString(),
                                DateTime.now().toIso8601String())
                            .toJson())
                        .then((_) {});
                    Navigator.of(context).pop();
                    showsDialog(context);
                  } else {
                    makeDialog('비밀번호가 틀립니다');
                  }
                } else {
                  makeDialog('길이가 짧습니다');
                }
              },
              child: const Text(
                '회원가입',
                style: TextStyle(color: Colors.white),
              ),
              color: Colors.blueAccent,
            )
          ],
          mainAxisAlignment: MainAxisAlignment.center,
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
          title: Text("회원가입 성공"),
          subtitle: Text("메인화면으로 이동합니다."),
        ),
      ),
    );
  }
}
