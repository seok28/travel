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

  // BannerAd? _banner;
  // bool _loadingBanner = false;

  // Future<void> _createAnchoredBanner(BuildContext context) async {
  //   final AnchoredAdaptiveBannerAdSize? size =
  //       await AdSize.getAnchoredAdaptiveBannerAdSize(
  //     Orientation.portrait,
  //     MediaQuery.of(context).size.width.truncate(),
  //   );
  //   if (size == null) {
  //     print('Unable to get height of anchored banner.');
  //     return;
  //   }
  //   final BannerAd banner = BannerAd(
  //     size: size,
  //     request: AdRequest(),
  //     adUnitId: BannerAd.testAdUnitId,
  //     listener: BannerAdListener(
  //       onAdLoaded: (Ad ad) {
  //         print('$BannerAd loaded.');
  //         setState(() {
  //           _banner = ad as BannerAd?;
  //         });
  //       },
  //       onAdFailedToLoad: (Ad ad, LoadAdError error) {
  //         print('$BannerAd failedToLoad: $error');
  //         ad.dispose();
  //       },
  //       onAdOpened: (Ad ad) => print('$BannerAd onAdOpened.'),
  //       onAdClosed: (Ad ad) => print('$BannerAd onAdClosed.'),
  //     ),
  //   );
  //   return banner.load();
  // }

  // @override
  // void dispose() {
  //   super.dispose();
  //   _banner!.dispose();
  // }

  @override
  void initState() {
    super.initState();
    _loadData();
  }

  @override
  Widget build(BuildContext context) {
    // if (!_loadingBanner) {
    //   _loadingBanner = true;
    //   _createAnchoredBanner(context);
    // }
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
                  showsDialog(context);
                  Navigator.of(context).pushNamedAndRemoveUntil(
                      '/', (Route<dynamic> route) => false);
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
}

void showsDialog(BuildContext context) {
  showDialog(
    context: context,
    builder: (context) => AlertDialog(
      content: const ListTile(
        title: Text("테스트"),
        subtitle: Text("테스트에 성공했어요"),
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
