import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:groot/Models/earning_history.dart';
import 'package:groot/Shopping/shop.dart';
import 'package:groot/badges.dart';
import 'package:groot/bottom_navigation.dart';
import 'package:groot/home_page.dart';
import 'package:groot/map.dart';
import 'package:groot/screenshotshare.dart';
import 'package:share_plus/share_plus.dart';
import 'package:http/http.dart' as http;

class GreenPointsPage extends StatefulWidget {
  const GreenPointsPage({super.key});

  @override
  State<GreenPointsPage> createState() => _GreenPointsPageState();
}

class _GreenPointsPageState extends State<GreenPointsPage> {
  final List<dynamic> earningHistory = [
    {
      "title": "Carpool Crusader",
      "subtitle": "+25",
      "image": "assets/images/img_coin.png"
    },
    {
      "title": "Carpool Crusader",
      "subtitle": "+25",
      "image": "assets/images/img_coin.png"
    },
    {
      "title": "Carpool Crusader",
      "subtitle": "+25",
      "image": "assets/images/img_coin.png"
    },
    {
      "title": "Carpool Crusader",
      "subtitle": "+25",
      "image": "assets/images/img_coin.png"
    },
    {
      "title": "Carpool Crusader",
      "subtitle": "+25",
      "image": "assets/images/img_coin.png"
    },
    {
      "title": "Carpool Crusader",
      "subtitle": "+25",
      "image": "assets/images/img_coin.png"
    },
    {
      "title": "Carpool Crusader",
      "subtitle": "+25",
      "image": "assets/images/img_coin.png"
    },
    {
      "title": "Carpool Crusader",
      "subtitle": "+25",
      "image": "assets/images/img_coin.png"
    },
  ];
  void share() {
    Share.share('check out my website https://example.com');
  }

  Future<EarningHistory> completedchallenges() async {
    final response = await http.post(
      Uri.parse(
          'https://manipal-hackathon-2.onrender.com/api/user/earning_history'),
      body: jsonEncode(<String, String>{
        'userId': '65990ea64d0d558d497a4408',
      }),
      headers: <String, String>{'Content-Type': 'application/json'},
    );
    print(response.body);
    if (response.statusCode == 200) {
      return EarningHistory.fromJson(jsonDecode(response.body));
    } else {
      throw Exception('Failed to load album');
    }
  }

  @override
  Widget build(BuildContext context) {
    final double width = MediaQuery.of(context).size.width;
    return SafeArea(
        child: Scaffold(
            backgroundColor: const Color.fromARGB(255, 230, 224, 199),
            appBar: AppBar(
              title: Text('GreenPoint'),
              leading: GestureDetector(
                onTap: () {
                  Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                          builder: (context) => MyHomePage(
                                title: '',
                              )));
                },
                child: Container(
                  margin: EdgeInsets.only(
                    left: 10,
                  ),
                  child: Icon(Icons.arrow_back),
                ),
              ),
              flexibleSpace: Container(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [
                      Color.fromARGB(255, 28, 77, 59),
                      Color.fromARGB(255, 147, 228, 198),
                    ],
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                  ),
                ),
              ),
              // centerTitle: true,
            ),
            body: SingleChildScrollView(
                child: FutureBuilder(
              builder: ((context, snapshot) {
                if (snapshot.hasData) {
                  return Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Container(
                          margin: EdgeInsets.only(
                              top: 10, bottom: 10, left: 10, right: 10),
                          width: width,
                          decoration: BoxDecoration(
                            color: const Color.fromARGB(255, 161, 197, 162),
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: Column(children: [
                            Container(
                                margin: EdgeInsets.only(top: 10, bottom: 10),
                                child: const Text(
                                  "Be the change\n earn the green ",
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    color: Color.fromARGB(255, 15, 68, 50),
                                    fontSize: 20,
                                    fontFamily: "Montserrat",
                                    fontWeight: FontWeight.w700,
                                  ),
                                )),
                            Container(
                              width: 83,
                              height: 83,
                              margin: EdgeInsets.only(top: 10, bottom: 10),
                              decoration: BoxDecoration(
                                image: DecorationImage(
                                  image:
                                      AssetImage("assets/images/img_coin.png"),
                                  fit: BoxFit.fill,
                                ),
                                boxShadow: [
                                  BoxShadow(
                                    color: Color(0x26000000),
                                    blurRadius: 10,
                                    offset: Offset(0, 4),
                                    spreadRadius: 0,
                                  )
                                ],
                              ),
                            ),
                            Text(
                              "159",
                              style: TextStyle(
                                color: Color.fromARGB(255, 15, 68, 50),
                                fontSize: 20,
                                fontFamily: "Montserrat",
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                            Container(
                              margin: EdgeInsets.only(top: 10, bottom: 10),
                              child: Text(
                                "Total Green Points",
                                style: TextStyle(
                                  color: Color.fromARGB(255, 15, 68, 50),
                                  fontSize: 20,
                                  fontFamily: "Montserrat",
                                  fontWeight: FontWeight.w400,
                                ),
                              ),
                            ),
                            GestureDetector(
                              onTap: () {
                                // Navigator.push(
                                //     context,
                                //     MaterialPageRoute(
                                //         builder: (context) => ScreenShotShare()));
                                share();
                              },
                              child: Text("Share.."),
                            )
                          ]),
                        ),
                        Container(
                          margin: EdgeInsets.only(
                              top: 10, bottom: 10, left: 10, right: 10),
                          padding: EdgeInsets.only(
                              top: 20, bottom: 20, left: 20, right: 20),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Container(
                                  child: Text("Earning History",
                                      style: TextStyle(
                                        color: Color.fromARGB(255, 15, 68, 50),
                                        fontSize: 20,
                                        fontFamily: "Montserrat",
                                        fontWeight: FontWeight.w700,
                                      )),
                                ),
                                Container(
                                  height: 200,
                                  child: ListView.builder(
                                    itemCount: snapshot
                                        .data![0].completedChallenges.length,
                                    itemBuilder:
                                        (BuildContext context, int index) {
                                      return ListTile(
                                        title: Text(snapshot.data![0]
                                            .completedChallenges[index].title),
                                        subtitle: Text(
                                            earningHistory[index]['subtitle']),
                                        leading: Image.asset(
                                            earningHistory[index]['image']),
                                      );
                                    },
                                  ),
                                ),
                                Container(
                                  width: width,
                                  alignment: Alignment.bottomRight,
                                  child: Text("See all...",
                                      style: TextStyle(
                                        color: Color.fromARGB(255, 15, 68, 50),
                                        fontSize: 15,
                                        fontFamily: "Montserrat",
                                        fontWeight: FontWeight.w300,
                                      )),
                                )
                              ]),
                        ),
                        Container(
                          width: width * 0.9,
                          padding: EdgeInsets.only(
                              top: 20, bottom: 20, left: 20, right: 20),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: Row(children: [
                            Container(
                              child:
                                  Image.asset("assets/images/icon_award.png"),
                            ),
                            GestureDetector(
                              onTap: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            AchievementsPage()));
                              },
                              child: Container(
                                margin: EdgeInsets.only(left: 10),
                                child: Text("Achievements",
                                    style: TextStyle(
                                      color: Color.fromARGB(255, 15, 68, 50),
                                      fontSize: 20,
                                      fontFamily: "Montserrat",
                                      fontWeight: FontWeight.w700,
                                    )),
                              ),
                            )
                          ]),
                        ),
                        GestureDetector(
                          onTap: () => {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => ShoppingPage()))
                          },
                          child: Container(
                            width: width * 0.9,
                            margin: EdgeInsets.only(top: 10, bottom: 10),
                            padding: EdgeInsets.only(
                                top: 20, bottom: 20, left: 20, right: 20),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(20),
                            ),
                            child: Row(children: [
                              Container(
                                child:
                                    Image.asset("assets/images/icon_award.png"),
                              ),
                              Container(
                                margin: EdgeInsets.only(left: 10),
                                child: Text("Redeem GreenPoints",
                                    style: TextStyle(
                                      color: Color.fromARGB(255, 15, 68, 50),
                                      fontSize: 20,
                                      fontFamily: "Montserrat",
                                      fontWeight: FontWeight.w700,
                                    )),
                              )
                            ]),
                          ),
                        )
                      ]);
                } else {
                  return Center(child: CircularProgressIndicator());
                }
              }),
              future: Future.wait([completedchallenges()]),
            ))));
  }
}
