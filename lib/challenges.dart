import 'dart:math';

import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:groot/Models/challenges.dart';
import 'package:groot/Models/globalLeaderboard.dart';
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
      "status": "Join Now",
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
      "status": "Join Now",
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
    // ... rest of the challenges
  ];
  Future<ChallengesModel> getChallenges() async {
    final response = await http.post(
      Uri.parse(
          'https://manipal-hackathon-2.onrender.com/api/admin/getChallenges'),
      body: jsonEncode(<String, String>{
        "userId": "659812ab1939157018e05cb5",
      }),
      headers: <String, String>{'Content-Type': 'application/json'},
    );
    final data = response.body;
    final jsonResult = json.decode(data);
    // print(jsonResult);
    return ChallengesModel.fromJson(jsonResult);
  }

  Future<GlobalLeaderBoardModel> getGlobalLeaderboard() async {
    final response = await http.post(
      Uri.parse(
          'https://manipal-hackathon-2.onrender.com/api/user/globalLeaderboard'),
      body: jsonEncode(<String, String>{"userId": "6532de1bfe788f7cf822ae53"}),
      headers: <String, String>{'Content-Type': 'application/json'},
    );
    final data = response.body;
    final jsonResult = json.decode(data);
    // print(jsonResult);
    return GlobalLeaderBoardModel.fromJson(jsonResult);
  }

  void handleButtonClick(int index) {
    setState(() {
      if (challenges[index]["status"] == "Join Now") {
        challenges[index]["status"] = "Participating";
        challenges[index]["users"].add({
          "name": "User 1",
          "points": 100,
        });
      } else {
        challenges[index]["status"] = "Finished";
        challenges[index]["users"].remove({
          "name": "User 1",
          "points": 100,
        });
      }
    });
  }

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
          "points": 1200,
        },
        {
          "name": "User 2",
          "points": 1100,
        },
        {
          "name": "User 3",
          "points": 1000,
        },
        {
          "name": "User 4",
          "points": 1000,
        },
        {
          "name": "User 5",
          "points": 900,
        },
        {
          "name": "User 6",
          "points": 800,
        },
      ]
    },
    {
      "title": "Challenge 2",
      "participants": [
        {
          "name": "User 1",
          "points": 1200,
        },
        {
          "name": "User 2",
          "points": 1100,
        },
        {
          "name": "User 3",
          "points": 1000,
        },
        {
          "name": "User 4",
          "points": 1000,
        },
        {
          "name": "User 5",
          "points": 900,
        },
        {
          "name": "User 6",
          "points": 800,
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

  Position? _currentPosition;
  Future<void> _getCurrentPosition() async {
    final hasPermission = await _handleLocationPermission();
    if (!hasPermission) return;
    await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.high)
        .then((Position position) {
      setState(() => _currentPosition = position);
      print(_currentPosition);
    }).catchError((e) {
      debugPrint(e);
    });
  }

  Future<bool> _handleLocationPermission() async {
    bool serviceEnabled;
    LocationPermission permission;

    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          content: Text(
              'Location services are disabled. Please enable the services')));
      return false;
    }
    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Location permissions are denied')));
        return false;
      }
    }
    if (permission == LocationPermission.deniedForever) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          content: Text(
              'Location permissions are permanently denied, we cannot request permissions.')));
      return false;
    }
    return true;
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
                body: FutureBuilder(
                  future:
                      Future.wait([getChallenges(), getGlobalLeaderboard()]),
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                      ChallengesModel challengesData = snapshot.data?[0]
                          as ChallengesModel; // First future result
                      GlobalLeaderBoardModel globalLeaderboardData =
                          snapshot.data?[1] as GlobalLeaderBoardModel;
                      print(globalLeaderboardData
                          .globalLeaderboard); // Second future result
                      return TabBarView(
                        children: [
                          Container(
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
                                                    challenge:
                                                        challenges[index]))));
                                  },
                                  child: Container(
                                      margin: EdgeInsets.all(10),
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(10),
                                        color:
                                            Color.fromARGB(25, 299, 190, 142),
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
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                                children: [
                                                  Column(
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    children: [
                                                      Container(
                                                        width: 150,
                                                        child: Text(
                                                            challenges[index]
                                                                    ["title"]
                                                                .toString(),
                                                            overflow:
                                                                TextOverflow
                                                                    .ellipsis,
                                                            softWrap: true,
                                                            style: TextStyle(
                                                              fontFamily:
                                                                  'Poppins',
                                                              fontSize: 20,
                                                              color: Color
                                                                  .fromARGB(
                                                                      255,
                                                                      28,
                                                                      77,
                                                                      59),
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w600,
                                                            )),
                                                      ),
                                                      Container(
                                                        margin: const EdgeInsets
                                                            .only(top: 10),
                                                        child: Row(
                                                          mainAxisAlignment:
                                                              MainAxisAlignment
                                                                  .start,
                                                          children: [
                                                            Container(
                                                              margin:
                                                                  const EdgeInsets
                                                                      .only(
                                                                      left: 10),
                                                              child: Stack(
                                                                children: [
                                                                  Container(
                                                                    width: 20,
                                                                    height: 20,
                                                                    decoration:
                                                                        BoxDecoration(
                                                                      borderRadius:
                                                                          BorderRadius.circular(
                                                                              50),
                                                                      color: Colors
                                                                          .white,
                                                                    ),
                                                                    child:
                                                                        ClipOval(
                                                                      child: Image
                                                                          .asset(
                                                                        "assets/images/img_coin.png",
                                                                        fit: BoxFit
                                                                            .fill,
                                                                      ),
                                                                    ),
                                                                  ),
                                                                  Container(
                                                                    margin: const EdgeInsets
                                                                        .only(
                                                                        left:
                                                                            10),
                                                                    width: 20,
                                                                    height: 20,
                                                                    decoration:
                                                                        BoxDecoration(
                                                                      borderRadius:
                                                                          BorderRadius.circular(
                                                                              50),
                                                                      color: Colors
                                                                          .white,
                                                                    ),
                                                                    child:
                                                                        ClipOval(
                                                                      child: Image
                                                                          .asset(
                                                                        "assets/images/img_coin.png",
                                                                        fit: BoxFit
                                                                            .fill,
                                                                      ),
                                                                    ),
                                                                  ),
                                                                  Container(
                                                                    margin: const EdgeInsets
                                                                        .only(
                                                                        left:
                                                                            20),
                                                                    width: 20,
                                                                    height: 20,
                                                                    decoration:
                                                                        BoxDecoration(
                                                                      borderRadius:
                                                                          BorderRadius.circular(
                                                                              50),
                                                                      color: Colors
                                                                          .white,
                                                                    ),
                                                                    child:
                                                                        ClipOval(
                                                                      child: Image
                                                                          .asset(
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
                                                                "  +"
                                                                "${challenges[index]['users']?.length ?? 0} participants",
                                                                style:
                                                                    TextStyle(
                                                                  fontFamily:
                                                                      'Poppins',
                                                                  fontSize: 15,
                                                                  color: Color
                                                                      .fromARGB(
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
                                                      _getCurrentPosition();
                                                      handleButtonClick(index);
                                                    },
                                                    child: Container(
                                                      width: 100,
                                                      height: 30,
                                                      decoration: BoxDecoration(
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(50),
                                                        color: Color.fromARGB(
                                                            255, 208, 239, 229),
                                                      ),
                                                      child: Center(
                                                        child: Text(
                                                            challenges[index][
                                                                    "status"] ??
                                                                "Join Now",
                                                            style: TextStyle(
                                                              fontFamily:
                                                                  'Poppins',
                                                              fontSize: 15,
                                                              color: Color
                                                                  .fromARGB(
                                                                      255,
                                                                      28,
                                                                      77,
                                                                      59),
                                                            )),
                                                      ),
                                                    ),
                                                  ),
                                                  SimpleCircularProgressBar(
                                                    size: 30,
                                                    valueNotifier:
                                                        valueNotifier,
                                                    progressStrokeWidth: 5,
                                                    backStrokeWidth: 5,
                                                    mergeMode: true,
                                                    onGetText: (value) {
                                                      return Text(
                                                        // '${value.toInt()}',
                                                        ('0%').toString(),
                                                        style: centerTextStyle,
                                                      );
                                                    },
                                                    progressColors: const [
                                                      Colors.cyan,
                                                      Colors.purple
                                                    ],
                                                    backColor: Colors.black
                                                        .withOpacity(0.4),
                                                  )
                                                  // : Container()
                                                ],
                                              )),
                                        ],
                                      )),
                                );
                              },
                            ),
                          ),
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
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Container(
                                        child: Text("Global Leaderboard",
                                            style: TextStyle(
                                              color: Color.fromARGB(
                                                  255, 15, 68, 50),
                                              fontSize: 20,
                                              fontFamily: "Montserrat",
                                              fontWeight: FontWeight.w700,
                                            )),
                                      ),
                                      Container(
                                        height: 200,
                                        child: ListView.builder(
                                          itemCount: globalLeaderboard.length,
                                          itemBuilder: (BuildContext context,
                                              int index) {
                                            return ListTile(
                                              title: Text(
                                                  globalLeaderboard[index]
                                                          ["name"] ??
                                                      "User ${index + 1}"),
                                              subtitle: Text(
                                                  globalLeaderboard[index]
                                                          ["rewards"]["points"]
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
                                                  255, 15, 68, 50),
                                              fontSize: 15,
                                              fontFamily: "Montserrat",
                                              fontWeight: FontWeight.w300,
                                            )),
                                      )
                                    ]),
                              ),
                              Container(
                                height:
                                    MediaQuery.of(context).size.height * 0.35,
                                child: ListView.builder(
                                    itemCount: userChallengesLeaderboard.length,
                                    itemBuilder: (context, index) {
                                      return Container(
                                        margin: EdgeInsets.only(
                                            top: 10,
                                            bottom: 10,
                                            left: 10,
                                            right: 10),
                                        padding: EdgeInsets.only(
                                            top: 20,
                                            bottom: 20,
                                            left: 20,
                                            right: 20),
                                        decoration: BoxDecoration(
                                          color: Colors.white,
                                          borderRadius:
                                              BorderRadius.circular(20),
                                        ),
                                        child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Container(
                                                child: Text(
                                                    userChallengesLeaderboard[
                                                        index]['title'],
                                                    style: TextStyle(
                                                      color: Color.fromARGB(
                                                          255, 15, 68, 50),
                                                      fontSize: 20,
                                                      fontFamily: "Montserrat",
                                                      fontWeight:
                                                          FontWeight.w700,
                                                    )),
                                              ),
                                              Container(
                                                height: 200,
                                                child: ListView.builder(
                                                  itemCount:
                                                      userChallengesLeaderboard[
                                                                  index]
                                                              ['participants']
                                                          .length,
                                                  itemBuilder:
                                                      (BuildContext context,
                                                          int index1) {
                                                    return ListTile(
                                                      title: Text(
                                                          userChallengesLeaderboard[
                                                                      index][
                                                                  'participants']
                                                              [index1]["name"]),
                                                      subtitle: Text(
                                                          userChallengesLeaderboard[
                                                                          index]
                                                                      [
                                                                      'participants']
                                                                  [
                                                                  index1]["points"]
                                                              .toString()),
                                                      leading: Image.asset(
                                                          'assets/images/img_coin.png'),
                                                    );
                                                  },
                                                ),
                                              ),
                                              Container(
                                                width: width,
                                                alignment:
                                                    Alignment.bottomRight,
                                                child: Text("See all...",
                                                    style: TextStyle(
                                                      color: Color.fromARGB(
                                                          255, 208, 239, 229),
                                                      fontSize: 15,
                                                      fontFamily: "Montserrat",
                                                      fontWeight:
                                                          FontWeight.w300,
                                                    )),
                                              )
                                            ]),
                                      );
                                    }),
                              )
                            ],
                          )),
                        ],
                      );
                    } else if (snapshot.hasError) {
                      return Center(child: Text(snapshot.error.toString()));
                    } else {
                      return Center(child: CircularProgressIndicator());
                    }
                  },
                ))));
  }
}
