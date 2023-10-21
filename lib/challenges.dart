import 'dart:math';

import 'package:flutter/material.dart';
import 'package:groot/challenges_detail.dart';
import 'package:simple_circular_progress_bar/simple_circular_progress_bar.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class ChallengesPage extends StatefulWidget {
  const ChallengesPage({super.key});

  @override
  State<ChallengesPage> createState() => _ChallengesPageState();
}

class _ChallengesPageState extends State<ChallengesPage> {
  bool gotChallengesData = true;
  final List<dynamic> challenges = [
    {
      "title": "Challenge 1",
      "description": "Complete a 5km run in under 30 minutes",
      "reward": "50 points",
      "users": [
        {
          "name": "User 1",
          "points": 100,
        },
        {
          "name": "User 2",
          "points": 80,
        },
        {
          "name": "User 3",
          "points": 60,
        },
      ],
    },
    {
      "title": "Challenge 2",
      "description": "Read 5 books in a month",
      "reward": "100 points",
      "users": [
        {
          "name": "User 1",
          "points": 200,
        },
        {
          "name": "User 2",
          "points": 150,
        },
        {
          "name": "User 3",
          "points": 100,
        },
      ],
    },
    {
      "title": "Challenge 3",
      "description": "Complete a 30-day yoga challenge",
      "reward": "75 points",
      "users": [
        {
          "name": "User 1",
          "points": 150,
        },
        {
          "name": "User 2",
          "points": 100,
        },
        {
          "name": "User 3",
          "points": 50,
        },
      ],
    },
    {
      "title": "Challenge 4",
      "description": "Learn a new language in 3 months",
      "reward": "200 points",
      "users": [
        {
          "name": "User 1",
          "points": 300,
        },
        {
          "name": "User 2",
          "points": 250,
        },
        {
          "name": "User 3",
          "points": 200,
        },
      ],
    },
    {
      "title": "Challenge 5",
      "description": "Complete a 24-hour coding challenge",
      "reward": "150 points",
      "users": [
        {
          "name": "User 1",
          "points": 250,
        },
        {
          "name": "User 2",
          "points": 200,
        },
        {
          "name": "User 3",
          "points": 150,
        },
      ],
    },
    {
      "title": "Challenge 6",
      "description": "Run a marathon",
      "reward": "300 points",
      "users": [
        {
          "name": "User 1",
          "points": 400,
        },
        {
          "name": "User 2",
          "points": 350,
        },
        {
          "name": "User 3",
          "points": 300,
        },
      ],
    },
    {
      "title": "Challenge 7",
      "description": "Complete a 30-day fitness challenge",
      "reward": "100 points",
      "users": [
        {
          "name": "User 1",
          "points": 200,
        },
        {
          "name": "User 2",
          "points": 150,
        },
        {
          "name": "User 3",
          "points": 100,
        },
      ],
    },
    {
      "title": "Challenge 8",
      "description": "Learn a new musical instrument in 6 months",
      "reward": "250 points",
      "users": [
        {
          "name": "User 1",
          "points": 350,
        },
        {
          "name": "User 2",
          "points": 300,
        },
        {
          "name": "User 3",
          "points": 250,
        },
      ],
    },
    {
      "title": "Challenge 9",
      "description": "Complete a 7-day meditation challenge",
      "reward": "50 points",
      "users": [
        {
          "name": "User 1",
          "points": 100,
        },
        {
          "name": "User 2",
          "points": 80,
        },
        {
          "name": "User 3",
          "points": 60,
        },
      ],
    },
    {
      "title": "Challenge 10",
      "description": "Complete a 30-day writing challenge",
      "reward": "200 points",
      "users": [
        {
          "name": "User 1",
          "points": 300,
        },
        {
          "name": "User 2",
          "points": 250,
        },
        {
          "name": "User 3",
          "points": 200,
        },
      ],
    },
  ];
  // void getChalleges() async {
  //   Map<String, String> requestBody = {
  //     'userId': '6532d61e52d13891fe9dd181',
  //   };

  //   final response = await http.post(
  //     Uri.parse(
  //         'https://manipal-hackathon-2.onrender.com/api/admin/getChallenges'),
  //     headers: <String, String>{'Content-Type': 'application/json'},
  //     body: jsonEncode(requestBody),
  //   );
  //   final data = response.body;
  //   final jsonResult = json.decode(data);
  //   print(jsonResult);
  //   setState(() {
  //     challenges.addAll(jsonResult["challenges"]);
  //   });
  // }

  final List<dynamic> globalLeaderboard = List.generate(
    10,
    (index) => {
      "name": "User ${index + 1}",
      "rewards": {"points": Random().nextInt(500)},
    },
  );
  // void getGlobalLeaderboard() async {
  //   final response = await http.get(Uri.parse(
  //       'https://manipal-hackathon-2.onrender.com/api/user/globalLeaderboard'));
  //   final data = response.body;
  //   final jsonResult = json.decode(data);
  //   print(jsonResult);
  //   setState(() {
  //     // globalLeaderboard.addAll(jsonResult["globalLeaderboard"]);
  //     // Sort the list in descending order according to the points
  //     gotChallengesData = true;
  //     globalLeaderboard.addAll(jsonResult["globalLeaderboard"]);
  //     globalLeaderboard.sort(
  //         (a, b) => b['rewards']['points'].compareTo(a['rewards']['points']));
  //   });
  // }

  // void addParticipant(int index) {
  //   // increment the number of participants of the given index of challenges
  //   setState(() {
  //     challenges[index]["users"].add({
  //       "name": "User 1",
  //       "points": 100,
  //     });
  //   });
  // }

  final List<dynamic> userChallengesLeaderboard = [
    {
      "title": "Challenge 1",
      "participants": [
        {
          "name": "User 1",
          "points": 100,
        },
        {
          "name": "User 2",
          "points": 100,
        },
        {
          "name": "User 3",
          "points": 100,
        },
        {
          "name": "User 4",
          "points": 100,
        },
        {
          "name": "User 5",
          "points": 100,
        },
        {
          "name": "User 6",
          "points": 100,
        },
      ]
    },
    {
      "title": "Challenge 2",
      "participants": [
        {
          "name": "User 1",
          "points": 100,
        },
        {
          "name": "User 2",
          "points": 100,
        },
        {
          "name": "User 3",
          "points": 100,
        },
        {
          "name": "User 4",
          "points": 100,
        },
        {
          "name": "User 5",
          "points": 100,
        },
      ]
    },
  ];

  // void getUserChallengesLeaderboard() async {
  //   final response = await http.get(Uri.parse(
  //       'https://manipal-hackathon-2.onrender.com/api/admin/getChallenges'));
  //   final data = response.body;
  //   final jsonResult = json.decode(data);
  //   print(jsonResult);
  //   setState(() {
  //     userChallengesLeaderboard.addAll(jsonResult["challenges"]);
  //   });
  // }

  final centerTextStyle = const TextStyle(
    fontSize: 15,
    color: Colors.lightBlue,
    fontWeight: FontWeight.bold,
  );

  late ValueNotifier<double> valueNotifier;
  @override
  void initState() {
    super.initState();
    valueNotifier = ValueNotifier(0.0);
    // getChalleges();
    // getGlobalLeaderboard();
    // getUserChallengesLeaderboard();
  }

  @override
  Widget build(BuildContext context) {
    final double width = MediaQuery.of(context).size.width;
    return SafeArea(
        child: DefaultTabController(
      length: 2,
      child: Scaffold(
          appBar: AppBar(
            title: Text('Challenges',
                style: TextStyle(
                  fontFamily: 'Poppins',
                  fontSize: 20,
                  color: const Color(0xffffffff),
                  fontWeight: FontWeight.w600,
                )),
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
            bottom: TabBar(
              tabs: [
                Tab(text: 'Challenges'),
                Tab(text: 'Leaderboard'),
              ],
            ),
          ),
          body: TabBarView(
            children: [
              gotChallengesData
                  ? Container(
                      height: MediaQuery.of(context).size.height,
                      child: ListView.builder(
                        itemCount: challenges.length,
                        itemBuilder: (context, index) {
                          return GestureDetector(
                            onTap: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: ((context) =>
                                          ChallengeDetailPage(
                                              challenge: challenges[index]))));
                            },
                            child: Container(
                                margin: EdgeInsets.all(10),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
                                  color: Color.fromARGB(25, 299, 190, 142),
                                ),
                                child: Column(
                                  children: [
                                    Container(
                                      child: Image.asset(
                                          "assets/images/challenges_temp.png"),
                                    ),
                                    Container(
                                        margin: EdgeInsets.only(
                                            top: 10,
                                            left: 10,
                                            right: 10,
                                            bottom: 10),
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Text(challenges[index]["title"],
                                                    style: TextStyle(
                                                      fontFamily: 'Poppins',
                                                      fontSize: 20,
                                                      color: Color.fromARGB(
                                                          255, 28, 77, 59),
                                                      fontWeight:
                                                          FontWeight.w600,
                                                    )),
                                                Container(
                                                  margin: const EdgeInsets.only(
                                                      top: 10),
                                                  child: Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment.start,
                                                    children: [
                                                      Container(
                                                        margin: const EdgeInsets
                                                            .only(left: 10),
                                                        child: Stack(
                                                          children: [
                                                            Container(
                                                              width: 20,
                                                              height: 20,
                                                              decoration:
                                                                  BoxDecoration(
                                                                borderRadius:
                                                                    BorderRadius
                                                                        .circular(
                                                                            50),
                                                                color: Colors
                                                                    .white,
                                                              ),
                                                              child: ClipOval(
                                                                child:
                                                                    Image.asset(
                                                                  "assets/images/img_coin.png",
                                                                  fit: BoxFit
                                                                      .fill,
                                                                ),
                                                              ),
                                                            ),
                                                            Container(
                                                              margin:
                                                                  const EdgeInsets
                                                                      .only(
                                                                      left: 10),
                                                              width: 20,
                                                              height: 20,
                                                              decoration:
                                                                  BoxDecoration(
                                                                borderRadius:
                                                                    BorderRadius
                                                                        .circular(
                                                                            50),
                                                                color: Colors
                                                                    .white,
                                                              ),
                                                              child: ClipOval(
                                                                child:
                                                                    Image.asset(
                                                                  "assets/images/img_coin.png",
                                                                  fit: BoxFit
                                                                      .fill,
                                                                ),
                                                              ),
                                                            ),
                                                            Container(
                                                              margin:
                                                                  const EdgeInsets
                                                                      .only(
                                                                      left: 20),
                                                              width: 20,
                                                              height: 20,
                                                              decoration:
                                                                  BoxDecoration(
                                                                borderRadius:
                                                                    BorderRadius
                                                                        .circular(
                                                                            50),
                                                                color: Colors
                                                                    .white,
                                                              ),
                                                              child: ClipOval(
                                                                child:
                                                                    Image.asset(
                                                                  "assets/images/img_coin.png",
                                                                  fit: BoxFit
                                                                      .fill,
                                                                ),
                                                              ),
                                                            ),
                                                          ],
                                                        ),
                                                      ),
                                                      Container(
                                                        child: Text(
                                                          "  +" +
                                                              challenges[index]
                                                                      ["users"]
                                                                  .length
                                                                  .toString() +
                                                              " participants",
                                                          style: TextStyle(
                                                            fontFamily:
                                                                'Poppins',
                                                            fontSize: 15,
                                                            color:
                                                                Color.fromARGB(
                                                                    255,
                                                                    28,
                                                                    77,
                                                                    59),
                                                          ),
                                                        ),
                                                      )
                                                    ],
                                                  ),
                                                )
                                              ],
                                            ),
                                            // challenges[index]["participating"] == "true"
                                            //     ?
                                            GestureDetector(
                                              onTap: () {
                                                // addParticipant(index);
                                              },
                                              child: Container(
                                                width: 100,
                                                height: 30,
                                                decoration: BoxDecoration(
                                                  borderRadius:
                                                      BorderRadius.circular(50),
                                                  color: Color.fromARGB(
                                                      255, 208, 239, 229),
                                                ),
                                                child: Center(
                                                  child: Text("Join Now",
                                                      style: TextStyle(
                                                        fontFamily: 'Poppins',
                                                        fontSize: 15,
                                                        color: Color.fromARGB(
                                                            255, 28, 77, 59),
                                                      )),
                                                ),
                                              ),
                                            ),
                                            SimpleCircularProgressBar(
                                              size: 25,
                                              valueNotifier: valueNotifier,
                                              progressStrokeWidth: 5,
                                              backStrokeWidth: 5,
                                              mergeMode: true,
                                              onGetText: (value) {
                                                return Text(
                                                  // '${value.toInt()}',
                                                  (0).toString(),
                                                  style: centerTextStyle,
                                                );
                                              },
                                              progressColors: const [
                                                Colors.cyan,
                                                Colors.purple
                                              ],
                                              backColor:
                                                  Colors.black.withOpacity(0.4),
                                            )
                                            // : Container()
                                          ],
                                        )),
                                  ],
                                )),
                          );
                        },
                      ),
                    )
                  : Container(),
              Container(
                  child: Column(
                children: [
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
                            child: Text("Global Leaderboard",
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
                              itemCount: globalLeaderboard.length,
                              itemBuilder: (BuildContext context, int index) {
                                return ListTile(
                                  title: Text(globalLeaderboard[index]['name']),
                                  subtitle: Text(globalLeaderboard[index]
                                          ['rewards']['points']
                                      .toString()),
                                  leading:
                                      Image.asset('assets/images/img_coin.png'),
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
                    height: MediaQuery.of(context).size.height * 0.35,
                    child: ListView.builder(
                        itemCount: userChallengesLeaderboard.length,
                        itemBuilder: (context, index) {
                          return Container(
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
                                    child: Text(
                                        userChallengesLeaderboard[index]
                                            ['title'],
                                        style: TextStyle(
                                          color:
                                              Color.fromARGB(255, 15, 68, 50),
                                          fontSize: 20,
                                          fontFamily: "Montserrat",
                                          fontWeight: FontWeight.w700,
                                        )),
                                  ),
                                  Container(
                                    height: 200,
                                    child: ListView.builder(
                                      itemCount:
                                          userChallengesLeaderboard[index]
                                                  ['participants']
                                              .length,
                                      itemBuilder:
                                          (BuildContext context, int index1) {
                                        return ListTile(
                                          title: Text(
                                              userChallengesLeaderboard[index]
                                                      ['participants'][index1]
                                                  ["name"]),
                                          subtitle: Text(
                                              userChallengesLeaderboard[index]
                                                          ['participants']
                                                      [index1]["points"]
                                                  .toString()),
                                          leading: Image.asset(
                                              'assets/images/img_coin.png'),
                                        );
                                      },
                                    ),
                                  ),
                                  Container(
                                    width: width,
                                    alignment: Alignment.bottomRight,
                                    child: Text("See all...",
                                        style: TextStyle(
                                          color: Color.fromARGB(
                                              255, 208, 239, 229),
                                          fontSize: 15,
                                          fontFamily: "Montserrat",
                                          fontWeight: FontWeight.w300,
                                        )),
                                  )
                                ]),
                          );
                        }),
                  )
                ],
              )),
            ],
          )),
    ));
  }
}
