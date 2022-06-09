// ignore_for_file: file_names

import 'package:firebase_database/firebase_database.dart';

class Plandata {
  String id; // 로그인 아이디
  String planName; // 일정 이름
  String planContents; // 일정 내용
  String createTime; // 생성 시간

  Plandata(this.id, this.planName, this.planContents, this.createTime);

  Plandata.fromSnapshot(DataSnapshot snapshot)
      : id = snapshot.value['id'],
        planName = snapshot.value['planName'],
        planContents = snapshot.value['planContents'],
        createTime = snapshot.value['createTime'];

  toJson() {
    return {
      'id': id,
      'planName': planName,
      'planContents': planContents,
      'createTime': createTime,
    };
  }
}
