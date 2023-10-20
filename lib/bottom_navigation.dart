import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class BottomNavigationCustom extends StatefulWidget {
  @override
  _BottomNavigationCustomState createState() => _BottomNavigationCustomState();
}

class _BottomNavigationCustomState extends State<BottomNavigationCustom> {
  int _currentIndex = 0;
  @override
  Widget build(BuildContext context) {
    final colorShcemeWhite = Theme.of(context).colorScheme.copyWith(
          primary: Colors.white,
          secondary: Colors.white,
          onSurface: Colors.white,
        );
    return Container(
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
        unselectedItemColor: colorShcemeWhite.onSurface.withOpacity(.60),
        selectedLabelStyle: TextStyle(
          color: Colors.white,
        ),
        unselectedLabelStyle: TextStyle(
          color: Colors.white,
        ),
        onTap: (value) {
          // Respond to item press.
          setState(() => _currentIndex = value);
        },
        items: [
          BottomNavigationBarItem(
            label: 'Home',
            icon: SvgPicture.asset(
              'assets/images/icon_home.svg',
            ),
          ),
          BottomNavigationBarItem(
            label: 'Challenges',
            icon: SvgPicture.asset(
              'assets/images/icon_medal.svg',
            ),
          ),
          BottomNavigationBarItem(
            label: 'Groot',
            icon: SvgPicture.asset(
              'assets/images/icon_reader.svg',
            ),
          ),
          BottomNavigationBarItem(
            label: 'GreenPoints',
            icon: SvgPicture.asset(
              'assets/images/icon_greenPoints.svg',
            ),
          ),
          BottomNavigationBarItem(
            label: 'Greenway',
            icon: SvgPicture.asset(
              'assets/images/icon_location.svg',
            ),
          ),
        ],
      ),
    );
  }
}
