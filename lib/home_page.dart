import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:groot/appbar_main.dart';
import 'package:groot/challenges.dart';
import 'package:groot/communityPost.dart';
import 'package:groot/greenpoints.dart';
import 'package:groot/greenway.dart';
import 'package:groot/homepage_component.dart';
import 'package:groot/map.dart';
import 'package:intl/intl.dart';
import 'bottom_navigation.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  // get today day name

  void _onItemTapped(int index) {
    setState(() {
      _currentIndex = index;
    });
  }

  int _currentIndex = 0;
  static List<Widget> _widgetOptions = <Widget>[
    HomePageComponent(),
    ChallengesPage(),
    GreenPointsPage(),
    MyApp(),
    CommunityForum(),
  ];

  @override
  Widget build(BuildContext context) {
    final colorShcemeWhite = Theme.of(context).colorScheme.copyWith(
          primary: Colors.white,
          secondary: Colors.white,
          onSurface: Colors.white,
        );
    // media query height and width
    final double width = MediaQuery.of(context).size.width;
    return SafeArea(
        child: Scaffold(
            backgroundColor: const Color.fromARGB(255, 230, 224, 199),
            body: _widgetOptions.elementAt(_currentIndex),
            bottomNavigationBar: Container(
              height: 80.0,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(20.0),
                  topRight: Radius.circular(20.0),
                ),
                color: Color.fromARGB(255, 28, 77, 59),
              ),
              child: BottomNavigationBar(
                type: BottomNavigationBarType.fixed,
                currentIndex: _currentIndex,
                backgroundColor: Colors.transparent,
                selectedItemColor: colorShcemeWhite.onSurface,
                unselectedItemColor:
                    colorShcemeWhite.onSurface.withOpacity(.60),
                onTap: _onItemTapped,
                items: [
                  BottomNavigationBarItem(
                    label: 'Home',
                    icon: SvgPicture.asset(
                      'assets/images/icon_home.svg',
                      color: _currentIndex == 0
                          ? Colors.white
                          : Colors.white.withOpacity(0.6),
                    ),
                  ),
                  BottomNavigationBarItem(
                    label: 'Challenges',
                    icon: SvgPicture.asset(
                      'assets/images/icon_medal.svg',
                      color: _currentIndex == 1
                          ? Colors.white
                          : Colors.white.withOpacity(0.6),
                    ),
                  ),
                  BottomNavigationBarItem(
                    label: 'GreenPoints',
                    icon: SvgPicture.asset(
                      'assets/images/icon_greenPoints.svg',
                      color: _currentIndex == 2
                          ? Colors.white
                          : Colors.white.withOpacity(0.6),
                    ),
                  ),
                  BottomNavigationBarItem(
                    label: 'Greenway',
                    icon: SvgPicture.asset(
                      'assets/images/icon_location.svg',
                      color: _currentIndex == 3
                          ? Colors.white
                          : Colors.white.withOpacity(0.6),
                    ),
                  ),
                  BottomNavigationBarItem(
                    label: 'Edu',
                    icon: SvgPicture.asset(
                      'assets/images/icon_reader.svg',
                      color: _currentIndex == 4
                          ? Colors.white
                          : Colors.white.withOpacity(0.6),
                    ),
                  ),
                ],
              ),
            )));
  }
}
