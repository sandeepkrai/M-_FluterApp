import 'package:flutter/material.dart';
import 'package:simple_circular_progress_bar/simple_circular_progress_bar.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class ChallengesPage extends StatefulWidget {
  const ChallengesPage({super.key});

  @override
  State<ChallengesPage> createState() => _ChallengesPageState();
}

class _ChallengesPageState extends State<ChallengesPage> {
  bool gotChallengesData = false;
  final List<dynamic> challenges = [];
  void getChalleges() async {
    final response = await http.get(Uri.parse(
        'https://manipal-hackathon-2.onrender.com/api/admin/getChallenges'));
    final data = response.body;
    final jsonResult = json.decode(data);
    // print(jsonResult);
    setState(() {
      challenges.addAll(jsonResult["challenges"]);
    });
  }

  final List<dynamic> globalLeaderboard = [];
  void getGlobalLeaderboard() async {
    final response = await http.get(Uri.parse(
        'https://manipal-hackathon-2.onrender.com/api/user/globalLeaderboard'));
    final data = response.body;
    final jsonResult = json.decode(data);
    print(jsonResult);
    setState(() {
      // globalLeaderboard.addAll(jsonResult["globalLeaderboard"]);
      // Sort the list in descending order according to the points
      gotChallengesData = true;
      globalLeaderboard.addAll(jsonResult["globalLeaderboard"]);
      globalLeaderboard.sort(
          (a, b) => b['rewards']['points'].compareTo(a['rewards']['points']));
    });
  }

  void addParticipant(int index) {
    // increment the number of participants of the given index of challenges
    setState(() {
      challenges[index]["users"].add({
        "name": "User 1",
        "points": 100,
      });
    });
  }

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
    getChalleges();
    getGlobalLeaderboard();
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
                          return Container(
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
                                                    fontWeight: FontWeight.w600,
                                                  )),
                                              Container(
                                                margin: const EdgeInsets.only(
                                                    top: 10),
                                                child: Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.start,
                                                  children: [
                                                    Container(
                                                      margin:
                                                          const EdgeInsets.only(
                                                              left: 10),
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
                                                              color:
                                                                  Colors.white,
                                                            ),
                                                            child: ClipOval(
                                                              child:
                                                                  Image.asset(
                                                                "assets/images/img_coin.png",
                                                                fit:
                                                                    BoxFit.fill,
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
                                                              color:
                                                                  Colors.white,
                                                            ),
                                                            child: ClipOval(
                                                              child:
                                                                  Image.asset(
                                                                "assets/images/img_coin.png",
                                                                fit:
                                                                    BoxFit.fill,
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
                                                              color:
                                                                  Colors.white,
                                                            ),
                                                            child: ClipOval(
                                                              child:
                                                                  Image.asset(
                                                                "assets/images/img_coin.png",
                                                                fit:
                                                                    BoxFit.fill,
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
                                                          fontFamily: 'Poppins',
                                                          fontSize: 15,
                                                          color: Color.fromARGB(
                                                              255, 28, 77, 59),
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
                                              addParticipant(index);
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
                              ));
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
                                  title: Text(globalLeaderboard[index]
                                      ['profile']['name']),
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
