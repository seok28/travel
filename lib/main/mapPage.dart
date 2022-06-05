import 'package:flutter/material.dart';

import 'dart:convert';

import 'package:firebase_database/firebase_database.dart';
import 'package:http/http.dart' as http;
import 'package:junsu_project/data/tour.dart';
import 'package:junsu_project/data/listData.dart';
// import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:junsu_project/main/tourDetailPage.dart';

class MapPage extends StatefulWidget {
  final DatabaseReference? databaseReference; // 실시간 데이터베이스 변수
  final Future<Database>? db; // 내부에 저장되는 데이터베이스
  final String? id; // 로그인한 아이디
  FirebaseDatabase database = FirebaseDatabase.instance;
  MapPage({this.databaseReference, this.db, this.id});

  @override
  State<StatefulWidget> createState() => _MapPage();
}

class _MapPage extends State<MapPage> {
  List<DropdownMenuItem<Item>> list = List.empty(growable: true);
  List<DropdownMenuItem<Item>> sublist = List.empty(growable: true);
  List<TourData> tourData = List.empty(growable: true);
  ScrollController? _scrollController;
  String authKey =
      'k9FpTZ71Gf3BB%2FibO%2FJSQZT3TlCjWJU85r%2FkiumB2OKaueTUTwEj4gWI1nxdQ5EmfsTzmlMLA7vm0DDHjXC0qA%3D%3D'; // 국문 관광정보 apikey
  Item? area;
  Item? kind;
  TourData? _tourData;
  int page = 1;

  @override
  void initState() {
    super.initState();
    list = Area().seoulArea;
    sublist = Kind().kinds;
    area = list[0].value;
    kind = sublist[0].value;
    _scrollController = new ScrollController();
    _scrollController!.addListener(() {
      if (_scrollController!.offset >=
              _scrollController!.position.maxScrollExtent &&
          !_scrollController!.position.outOfRange) {
        page++;
        getAreaList(area: area!.value, contentTypeId: kind!.value, page: page);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('검색하기'),
      ),
      body: Container(
        child: Center(
          child: Column(
            children: <Widget>[
              Row(
                children: <Widget>[
                  DropdownButton<Item>(
                    value: area,
                    onChanged: (value) {
                      Item selectedItem = value!;
                      setState(() {
                        area = selectedItem;
                      });
                    },
                    items: list,
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  DropdownButton<Item>(
                    items: sublist,
                    onChanged: (value) {
                      Item selectedItem = value!;
                      setState(() {
                        kind = selectedItem;
                      });
                    },
                    value: kind,
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  MaterialButton(
                    onPressed: () {
                      page = 1;
                      tourData.clear();
                      getAreaList(
                          area: area!.value,
                          contentTypeId: kind!.value,
                          page: page);
                    },
                    child: Text(
                      '검색하기',
                      style: TextStyle(color: Colors.white),
                    ),
                    color: Colors.blueAccent,
                  )
                ],
                mainAxisAlignment: MainAxisAlignment.spaceAround,
              ),
              Expanded(
                  child: ListView.builder(
                itemBuilder: (context, index) {
                  return Card(
                    child: InkWell(
                      child: Row(
                        children: <Widget>[
                          Hero(
                              tag: 'tourinfo$index',
                              child: Container(
                                  margin: EdgeInsets.all(10),
                                  width: 100.0,
                                  height: 100.0,
                                  decoration: BoxDecoration(
                                      shape: BoxShape.circle,
                                      border: Border.all(
                                          color: Colors.black, width: 1),
                                      image: DecorationImage(
                                          fit: BoxFit.fill,
                                          image: getImage(
                                              tourData[index].imagePath))))),
                          SizedBox(
                            width: 20,
                          ),
                          Container(
                            child: Column(
                              children: <Widget>[
                                Text(
                                  tourData[index].title!,
                                  style: TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold),
                                ),
                                Text('주소 : ${tourData[index].address}'),
                                tourData[index].tel != null ?
                                     Text('전화 번호 : ${tourData[index].tel}')
                                    : Container(),
                              ],
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            ),
                            width: MediaQuery.of(context).size.width - 150,
                          )
                        ],
                      ),
                      onTap: () {
                        Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) => TourDetailPage(
                                  id: widget.id,
                                  tourData: tourData[index],
                                  index: index,
                                  databaseReference: widget.databaseReference,
                                )));
                      },
                      onDoubleTap: () {
                        insertTour(widget.db!, tourData[index]); //onTap
                      },
                    ),
                  );
                },
                itemCount: tourData.length,
                controller: _scrollController,
              ))
            ],
            mainAxisAlignment: MainAxisAlignment.start,
          ),
        ),
      ),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            DrawerHeader(
              child: Text('drawer testing'),
              decoration: BoxDecoration(
                color: Colors.blue,
              ),
            ),
            UserAccountsDrawerHeader(
              accountName: Text('$widget!.id'),
              accountEmail: Text('안녕하세요 '),
            )
          ],
        ),
      ),
    );
  }

  void insertTour(Future<Database> db, TourData info) async {
    final Database database = await db;
    await database
        .insert('place', info.toMap(),
            conflictAlgorithm: ConflictAlgorithm.replace)
        .then((value) {
      ScaffoldMessenger.of(context)
          .showSnackBar(const SnackBar(content: Text('즐겨찾기에 추가되었습니다')));
    });
  }

  ImageProvider getImage(String? imagePath) {
    if (imagePath != null) {
      return NetworkImage(imagePath);
    } else {
      return AssetImage('repo/images/map_location.png');
    }
  }

  void getAreaList(
      {required int area,
      required int contentTypeId,
      required int page}) async {
    var url =
        'http://api.visitkorea.or.kr/openapi/service/rest/KorService/areaBasedList?ServiceKey=$authKey&MobileOS=AND&MobileApp=ModuTour&_type=json&areaCode=1&numOfRows=10&sigunguCode=$area&pageNo=$page';
    if (contentTypeId != 0) {
      url = url + '&contentTypeId=$contentTypeId';
    }
    var response = await http.get(Uri.parse(url));
    String body = utf8.decode(response.bodyBytes);
    print(body);
    var json = jsonDecode(body);
    if (json['response']['header']['resultCode'] == "0000") {
      if (json['response']['body']['items'] == '') {
        showDialog (
            context: context,
            builder: (context) {
              return AlertDialog(
                content: Text('마지막 데이터 입니다'),
              );
            });
      } else {
        List jsonArray = json['response']['body']['items']['item'];
        for (var s in jsonArray) {
          setState(() {
            tourData.add(TourData.fromJson(s));
          });
        }
      }
    } else {
      print('error');
    }
  }
}
