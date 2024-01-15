import 'dart:convert';

import 'package:carousel_slider/carousel_slider.dart';

import 'package:flutter/material.dart';
import 'package:groot/Barcode/barcode_main.dart';
import 'package:groot/Models/user.dart';
import 'package:groot/appbar_main.dart';
import 'package:intl/intl.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:http/http.dart' as http;

class HomePageComponent extends StatefulWidget {
  const HomePageComponent({super.key});

  @override
  State<HomePageComponent> createState() => _HomePageComponentState();
}

class _HomePageComponentState extends State<HomePageComponent> {
  _launchApp() async {
    // final AndroidIntent intent = AndroidIntent(
    //   action: 'action_main',
    //   package: 'com.example.otherapp', // Replace with the correct package name
    //   category: 'android.intent.category.LAUNCHER',
    // );

    // if (await intent.canLaunch()) {
    //   intent.launch();
    // } else {
    //   print('The app is not installed on your device');
    // }
  }

  Map<String, dynamic> user = {
    'profilePictureUrl':
        'https://pixinvent.com/materialize-material-design-admin-template/app-assets/images/user/12.jpg',
    'name': 'Sandeep Rai',
    'email': 'johndoe@example.com',
    'age': 30,
    'location': {'city': 'New York', 'state': 'NY', 'country': 'USA'}
  };

  // Every day challenge object
  Map<String, dynamic> challenge = {
    'name': 'Eco-Warrior',
    'description': 'Take public transport today',
    'points': 15,
    'icon': Icons.person,
    'color': const Color.fromARGB(255, 66, 165, 161),
    'completed': false
  };
  String getDayName() {
    return DateFormat('EEEE').format(DateTime.now());
  }

  // get date and month
  String getDateAndMonth() {
    return DateFormat('MMMM d').format(DateTime.now());
  }

  Future<UserData> getUserData() async {
    final response = await http.post(
      Uri.parse('https://manipal-hackathon-2.onrender.com/api/user/getUser'),
      body: jsonEncode(<String, String>{
        'username': 's',
      }),
      headers: <String, String>{'Content-Type': 'application/json'},
    );
    print(response.body);
    if (response.statusCode == 200) {
      return UserData.fromJson(jsonDecode(response.body));
    } else {
      throw Exception('Failed to load album');
    }
  }

  @override
  Widget build(BuildContext context) {
    // media query height and width
    final double width = MediaQuery.of(context).size.width;
    return Scaffold(
        body: SafeArea(
            child: SingleChildScrollView(
                child: FutureBuilder(
      future: Future.wait([getUserData()]),
      builder: ((context, snapshot) {
        if (snapshot.hasData) {
          return Container(
            child: Container(
              margin: const EdgeInsets.only(left: 10, right: 10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  AppBarMain(user: user),
                  Container(
                    margin: const EdgeInsets.only(top: 10, bottom: 30),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          child: Text(
                            "Hi, ${snapshot.data?[0].user?.profile?.name}",
                            style: const TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                                color: Color.fromARGB(255, 28, 77, 59)),
                          ),
                        ),
                        Container(
                          child: Text(
                              DateFormat('MMMM d y').format(DateTime.now()),
                              style: const TextStyle(
                                  fontSize: 15,
                                  color: Color.fromARGB(255, 28, 77, 59))),
                        )
                      ],
                    ),
                  ),
                  GestureDetector(
                    onTap: () async {
                      _launchApp();
                    },
                    child: CarouselSlider(
                      options: CarouselOptions(
                        height: 200.0,
                        pageSnapping: false,
                        enlargeCenterPage: true,
                        viewportFraction: 1,
                        autoPlay: true,
                      ),
                      items: [1, 2, 3, 4, 5].map((i) {
                        return Builder(
                          builder: (BuildContext context) {
                            return Container(
                                width: MediaQuery.of(context).size.width,
                                margin:
                                    const EdgeInsets.symmetric(horizontal: 5.0),
                                decoration: BoxDecoration(
                                  color:
                                      const Color.fromARGB(255, 66, 165, 161),
                                  borderRadius: BorderRadius.circular(30),
                                ),
                                child: Row(
                                  // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Container(
                                      width: MediaQuery.of(context).size.width *
                                          0.4,
                                      margin: const EdgeInsets.only(
                                          left: 20, top: 10),
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceAround,
                                        children: [
                                          Container(
                                            child: Text(
                                              challenge["name"] +
                                                  "\n" +
                                                  getDayName(),
                                              style: TextStyle(
                                                fontSize: width * 0.065,
                                                fontWeight: FontWeight.bold,
                                                color: const Color.fromARGB(
                                                    255, 239, 184, 18),
                                              ),
                                            ),
                                          ),
                                          Container(
                                            margin:
                                                const EdgeInsets.only(top: 10),
                                            child: Text(
                                              challenge["description"],
                                              style: const TextStyle(
                                                fontSize: 15,
                                                color: Colors.white,
                                              ),
                                            ),
                                          ),
                                          Container(
                                            margin:
                                                const EdgeInsets.only(top: 10),
                                            child: Row(
                                              children: [
                                                Container(
                                                    child: const Icon(
                                                  Icons.calendar_month_outlined,
                                                  color: Colors.white,
                                                )),
                                                Container(
                                                  margin: const EdgeInsets.only(
                                                      left: 10),
                                                  child: Text(
                                                    getDateAndMonth(),
                                                    style: TextStyle(
                                                      fontSize: width * 0.05,
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      color: Colors.white,
                                                    ),
                                                  ),
                                                )
                                              ],
                                            ),
                                          )
                                        ],
                                      ),
                                    ),
                                    Container(
                                      width: MediaQuery.of(context).size.width *
                                          0.45,
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceAround,
                                        children: [
                                          Container(
                                            width: 100,
                                            margin: const EdgeInsets.only(
                                              top: 10,
                                            ),
                                            decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(50),
                                              color: Colors.white,
                                            ),
                                            child: Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.center,
                                                children: [
                                                  Container(
                                                    child: const Icon(
                                                      Icons.star,
                                                    ),
                                                  ),
                                                  Container(
                                                    margin:
                                                        const EdgeInsets.only(
                                                            left: 10),
                                                    child: Text(
                                                      challenge["points"]
                                                          .toString(),
                                                      style: TextStyle(
                                                        fontSize: width * 0.05,
                                                        fontWeight:
                                                            FontWeight.bold,
                                                        color: Colors.black,
                                                      ),
                                                    ),
                                                  )
                                                ]),
                                          ),
                                          Container(
                                            child: Image.asset(
                                              'assets/images/tempo.png',
                                              width: 130,
                                              height: 140,
                                              fit: BoxFit.cover,
                                            ),
                                          )
                                        ],
                                      ),
                                    )
                                  ],
                                ));
                          },
                        );
                      }).toList(),
                    ),
                  ),
                  Container(
                    margin: const EdgeInsets.only(top: 20, left: 10, right: 10),
                    padding:
                        const EdgeInsets.only(top: 20, left: 10, right: 10),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(30),
                        color: const Color.fromARGB(255, 161, 197, 162)),
                    child: Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Container(
                            margin: const EdgeInsets.only(bottom: 20),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Container(
                                  child: const Text(
                                    "Progress Tracker",
                                    style: TextStyle(
                                      fontSize: 22,
                                      fontWeight: FontWeight.bold,
                                      color: Color.fromARGB(255, 15, 68, 50),
                                    ),
                                  ),
                                ),
                                Container(
                                  width: 80,
                                  height: 30,
                                  margin: const EdgeInsets.only(
                                    top: 10,
                                  ),
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(50),
                                    color: Colors.white,
                                  ),
                                  child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        GestureDetector(
                                          onTap: () async {
                                            // var result = await BarcodeScanner.scan();

                                            //         print(result.type); // The result type (barcode, cancelled, failed)
                                            //         print(result.rawContent); // The barcode content
                                            //         print(result.format); // The barcode format (as enum)
                                            //         print(result.formatNote);
                                          },
                                          child: Container(
                                            margin:
                                                const EdgeInsets.only(left: 10),
                                            child: Text(
                                              "Track trip",
                                              style: TextStyle(
                                                fontSize: width * 0.04,
                                                color: Colors.black,
                                              ),
                                            ),
                                          ),
                                        )
                                      ]),
                                ),
                              ],
                            ),
                          ),
                          Container(
                            margin: const EdgeInsets.only(bottom: 20),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Container(
                                  margin: const EdgeInsets.only(left: 10),
                                  child: Row(children: [
                                    Container(
                                      margin: const EdgeInsets.only(right: 10),
                                      child: Image.asset(
                                          "assets/images/icon_bus.png"),
                                    ),
                                    Container(
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          const Text(
                                            "Public Transport Trips",
                                            style: TextStyle(
                                                fontSize: 12,
                                                fontWeight: FontWeight.bold),
                                          ),
                                          // Create a % bar indicator of completion
                                          Container(
                                            width: 100,
                                            height: 10,
                                            margin:
                                                const EdgeInsets.only(top: 10),
                                            decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(50),
                                              color: Colors.white,
                                            ),
                                            child: Stack(
                                              children: [
                                                Container(
                                                  width: 100,
                                                  height: 10,
                                                  decoration: BoxDecoration(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            50),
                                                    color: Colors.grey[300],
                                                  ),
                                                ),
                                                Container(
                                                  width: 50,
                                                  height: 10,
                                                  decoration: BoxDecoration(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            50),
                                                    color: Colors.orange,
                                                  ),
                                                ),
                                              ],
                                            ),
                                          )
                                        ],
                                      ),
                                    ),
                                  ]),
                                ),
                                Container(
                                  width: 80,
                                  height: 30,
                                  alignment: Alignment.center,
                                  margin: const EdgeInsets.only(
                                    top: 10,
                                  ),
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(50),
                                    color:
                                        const Color.fromARGB(255, 28, 77, 59),
                                  ),
                                  child: Container(
                                    alignment: Alignment.center,
                                    margin: const EdgeInsets.only(left: 10),
                                    child: Text(
                                      snapshot.data![0].user?.trips!.length
                                              .toString() ??
                                          "",
                                      style: TextStyle(
                                        fontSize: width * 0.04,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.white,
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Container(
                            margin: const EdgeInsets.only(bottom: 20),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Container(
                                  child: Row(children: [
                                    Container(
                                      child: Image.asset(
                                          "assets/images/icon_shoe.png"),
                                    ),
                                    Container(
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          const Text(
                                            "Walking Steps",
                                            style: TextStyle(
                                                fontSize: 12,
                                                fontWeight: FontWeight.bold),
                                          ),
                                          Container(
                                            width: 100,
                                            height: 10,
                                            margin:
                                                const EdgeInsets.only(top: 10),
                                            decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(50),
                                              color: Colors.white,
                                            ),
                                            child: Stack(
                                              children: [
                                                Container(
                                                  width: 100,
                                                  height: 10,
                                                  decoration: BoxDecoration(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            50),
                                                    color: Colors.grey[300],
                                                  ),
                                                ),
                                                Container(
                                                  width: 50,
                                                  height: 10,
                                                  decoration: BoxDecoration(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            50),
                                                    color: Colors.orange,
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ]),
                                ),
                                Container(
                                  width: 80,
                                  height: 30,
                                  alignment: Alignment.center,
                                  margin: const EdgeInsets.only(
                                    top: 10,
                                  ),
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(50),
                                    color:
                                        const Color.fromARGB(255, 28, 77, 59),
                                  ),
                                  child: Container(
                                    alignment: Alignment.center,
                                    margin: const EdgeInsets.only(left: 10),
                                    child: Text(
                                      "282",
                                      style: TextStyle(
                                        fontSize: width * 0.04,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.white,
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Container(
                            margin: const EdgeInsets.only(bottom: 20),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Container(
                                  child: Row(children: [
                                    Container(
                                      child: Image.asset(
                                          "assets/images/icon_leaf.png"),
                                    ),
                                    Container(
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          const Text(
                                            "Carbon Emission Reduced",
                                            style: TextStyle(
                                                fontSize: 12,
                                                fontWeight: FontWeight.bold),
                                          ),
                                          Container(
                                            width: 100,
                                            height: 10,
                                            margin:
                                                const EdgeInsets.only(top: 10),
                                            decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(50),
                                              color: Colors.white,
                                            ),
                                            child: Stack(
                                              children: [
                                                Container(
                                                  width: 100,
                                                  height: 10,
                                                  decoration: BoxDecoration(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            50),
                                                    color: Colors.grey[300],
                                                  ),
                                                ),
                                                Container(
                                                  width: 50,
                                                  height: 10,
                                                  decoration: BoxDecoration(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            50),
                                                    color: Colors.orange,
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ]),
                                ),
                                Container(
                                  width: 80,
                                  height: 30,
                                  alignment: Alignment.center,
                                  margin: const EdgeInsets.only(
                                    top: 10,
                                  ),
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(50),
                                    color:
                                        const Color.fromARGB(255, 28, 77, 59),
                                  ),
                                  child: Container(
                                    alignment: Alignment.center,
                                    margin: const EdgeInsets.only(left: 10),
                                    child: Text(
                                      "82g",
                                      style: TextStyle(
                                        fontSize: width * 0.04,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.white,
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Container(
                            margin: const EdgeInsets.only(bottom: 20),
                            child: const Text("See more..",
                                style: TextStyle(
                                  fontSize: 15,
                                  fontWeight: FontWeight.bold,
                                  color: Color.fromARGB(255, 28, 77, 59),
                                )),
                          )
                        ]),
                  ),
                  Container(
                    margin: const EdgeInsets.only(
                        top: 20, left: 10, right: 10, bottom: 20),
                    padding:
                        const EdgeInsets.only(top: 20, left: 10, right: 10),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(30),
                      color: Colors.white,
                    ),
                    child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            margin: const EdgeInsets.only(bottom: 10),
                            child: const Text("Average Local Progress:",
                                style: TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                  color: Color.fromARGB(255, 28, 77, 59),
                                )),
                          ),
                          Container(
                            margin: const EdgeInsets.only(bottom: 10),
                            child: Row(
                              children: [
                                Column(
                                  children: [
                                    Row(
                                      children: [
                                        Container(
                                          margin:
                                              const EdgeInsets.only(right: 10),
                                          child: Text(". Avg. Green Points",
                                              style: TextStyle(
                                                fontSize: width * 0.04,
                                                fontWeight: FontWeight.w300,
                                                color: Colors.black,
                                              )),
                                        ),
                                        Container(
                                          height: 30,
                                          alignment: Alignment.center,
                                          margin: const EdgeInsets.only(
                                            top: 10,
                                          ),
                                          decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(50),
                                              color: const Color.fromARGB(
                                                  255, 28, 77, 69)),
                                          child: Container(
                                            alignment: Alignment.center,
                                            margin: const EdgeInsets.only(
                                              left: 10,
                                              right: 10,
                                            ),
                                            child: Text(
                                              "15",
                                              style: TextStyle(
                                                fontSize: width * 0.04,
                                                fontWeight: FontWeight.bold,
                                                color: Colors.white,
                                              ),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                    Row(
                                      children: [
                                        Container(
                                          margin:
                                              const EdgeInsets.only(right: 10),
                                          child: Text(". Local Achievements",
                                              style: TextStyle(
                                                fontSize: width * 0.04,
                                                fontWeight: FontWeight.w300,
                                                color: Colors.black,
                                              )),
                                        ),
                                        Container(
                                          height: 30,
                                          alignment: Alignment.center,
                                          margin: const EdgeInsets.only(
                                            top: 10,
                                          ),
                                          decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(50),
                                            color: const Color.fromARGB(
                                                255, 28, 77, 69),
                                          ),
                                          child: Container(
                                            alignment: Alignment.center,
                                            margin: const EdgeInsets.only(
                                              left: 10,
                                              right: 10,
                                            ),
                                            child: Text(
                                              "15",
                                              style: TextStyle(
                                                fontSize: width * 0.04,
                                                fontWeight: FontWeight.bold,
                                                color: Colors.white,
                                              ),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                                Row(
                                  children: [
                                    // Stacke two three images
                                    Container(
                                      margin: const EdgeInsets.only(left: 10),
                                      child: Stack(
                                        children: [
                                          Container(
                                            width: 40,
                                            height: 40,
                                            decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(50),
                                              color: Colors.white,
                                            ),
                                            child: ClipOval(
                                              child: Image.network(
                                                user["profilePictureUrl"],
                                                fit: BoxFit.fill,
                                              ),
                                            ),
                                          ),
                                          Container(
                                            margin:
                                                const EdgeInsets.only(left: 10),
                                            width: 40,
                                            height: 40,
                                            decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(50),
                                              color: Colors.white,
                                            ),
                                            child: ClipOval(
                                              child: Image.network(
                                                user["profilePictureUrl"],
                                                fit: BoxFit.fill,
                                              ),
                                            ),
                                          ),
                                          Container(
                                            margin:
                                                const EdgeInsets.only(left: 30),
                                            width: 40,
                                            height: 40,
                                            decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(50),
                                              color: Colors.white,
                                            ),
                                            child: ClipOval(
                                              child: Image.network(
                                                user["profilePictureUrl"],
                                                fit: BoxFit.fill,
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    Container(
                                      margin: const EdgeInsets.only(left: 10),
                                      child: Text("+56",
                                          style: TextStyle(
                                            fontSize: width * 0.04,
                                            fontWeight: FontWeight.bold,
                                            color: Colors.black,
                                          )),
                                    ),
                                  ],
                                )
                              ],
                            ),
                          )
                        ]),
                  )
                ],
              ),
            ),
          );
        } else if (snapshot.hasError) {
          return Container(
            child: Text("Got Error"),
          );
        } else {
          return Container(
            child: Text("Loading"),
          );
        }
      }),
    ))));
  }
}
