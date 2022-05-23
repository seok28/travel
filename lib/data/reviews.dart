import 'package:firebase_database/firebase_database.dart';

class Review {
  String id; // 로그인 id
  String review; // 여행 후기
  String createTime; // 생성시간 

  Review(this.id, this.review, this.createTime);

  Review.fromSnapshot(DataSnapshot snapshot)
      : id = snapshot.value['id'],
        review = snapshot.value['review'],
        createTime = snapshot.value['createTime'];

  toJson() {
    return {
      'id': id,
      'review': review,
      'createTime': createTime,
    };
  }
}
