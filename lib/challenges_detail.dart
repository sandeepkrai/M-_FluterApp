import 'package:flutter/material.dart';

class ChallengeDetailPage extends StatelessWidget {
  final Map<String, dynamic> challenge;

  ChallengeDetailPage({required this.challenge});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Challenge Details"),
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
      ),
      body: SingleChildScrollView(
        child: Container(
          margin: EdgeInsets.all(10),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            color: Color.fromARGB(25, 299, 190, 142),
          ),
          child: Column(
            children: [
              Container(
                child: Image.asset("assets/images/challenges_temp.png"),
              ),
              Container(
                margin:
                    EdgeInsets.only(top: 10, left: 10, right: 10, bottom: 10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      challenge["title"],
                      style: TextStyle(
                        fontFamily: 'Poppins',
                        fontSize: 20,
                        color: Color.fromARGB(255, 28, 77, 59),
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    Container(
                      margin: const EdgeInsets.only(top: 10),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          // Display the coins and participants
                          // (You can adapt this part based on your data)
                          Container(
                            margin: const EdgeInsets.only(left: 10),
                            child: Stack(
                              children: [
                                Container(
                                  width: 20,
                                  height: 20,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(50),
                                    color: Colors.white,
                                  ),
                                  child: ClipOval(
                                    child: Image.asset(
                                      "assets/images/img_coin.png",
                                      fit: BoxFit.fill,
                                    ),
                                  ),
                                ),
                                // Add more coin icons if needed
                              ],
                            ),
                          ),
                          Container(
                            child: Text(
                              "  +" +
                                  challenge["users"].length.toString() +
                                  " participants",
                              style: TextStyle(
                                fontFamily: 'Poppins',
                                fontSize: 15,
                                color: Color.fromARGB(255, 28, 77, 59),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
