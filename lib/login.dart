import 'dart:convert';

import 'package:animated_snack_bar/animated_snack_bar.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:groot/home_page.dart';
import 'package:groot/homepage_component.dart';
import 'package:groot/imageupload.dart';
import 'package:groot/signup.dart';
import 'package:http/http.dart' as http;

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  // Declare the controllers for email and password fields
  final usernameController = TextEditingController();
  final passwordController = TextEditingController();
  String? _currentAddress;
  Position? _currentPosition;

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

  // Declare a boolean variable to show or hide the password
  bool obscurePassword = true;

  // Declare a method to validate the email and password inputs
  Future<bool> validateLogin() async {
    // Get the email and password values from the controllers
    String username = usernameController.text;
    String password = passwordController.text;

    // Check if the email and password are not empty
    if (username.isNotEmpty && password.isNotEmpty) {
      // TODO: Perform the login logic with the email and password
      var response = await http.post(
        Uri.parse("https://manipal-hackathon-2.onrender.com/api/user/login"),
        body: jsonEncode(<String, String>{
          'username': username.toString(),
          'password': password.toString(),
        }),
        headers: <String, String>{'Content-Type': 'application/json'},
      );
      print('Response status: ${response.statusCode}');
      print('Response body: ${response.body}');
      // save
      if (response.statusCode == 200) {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => MyHomePage(
                      title: '',
                    )));
        return true;
      } else {
        return false;
      }
    } else {
      // TODO: Show an error message to the user
      print('Please enter your email and password');
    }
    return false;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 230, 224, 199),
      appBar: AppBar(
        title: Text('Login Screen'),
        centerTitle: true,
        flexibleSpace: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [
                Color.fromARGB(255, 28, 77, 59),
                Color.fromARGB(255, 96, 204, 165),
              ],
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
            ),
          ),
        ),
      ),
      body: Container(
        // decoration: BoxDecoration(
        //   gradient: LinearGradient(
        //     colors: [
        //       Color.fromARGB(255, 175, 196, 190),
        //       Color.fromARGB(255, 177, 209, 198),
        //     ],
        //     begin: Alignment.topCenter,
        //     end: Alignment.bottomCenter,
        //   ),
        // ),
        child: Padding(
          padding: EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // A text field for the email input
              TextField(
                controller: usernameController,
                decoration: InputDecoration(
                  labelText: 'Username',
                  hintText: 'Enter your Username',
                  border: OutlineInputBorder(),
                ),
                keyboardType: TextInputType.emailAddress,
              ),
              SizedBox(height: 16.0),
              // A text field for the password input
              TextField(
                controller: passwordController,
                decoration: InputDecoration(
                  labelText: 'Password',
                  hintText: 'Enter your password',
                  border: OutlineInputBorder(),
                  // A suffix icon to toggle the password visibility
                  suffixIcon: IconButton(
                    icon: Icon(obscurePassword
                        ? Icons.visibility_off
                        : Icons.visibility),
                    onPressed: () {
                      // Change the value of obscurePassword and rebuild the widget
                      setState(() {
                        obscurePassword = !obscurePassword;
                      });
                    },
                  ),
                ),
                obscureText: obscurePassword,
              ),
              SizedBox(height: 16.0),
              // A button to perform the login action
              GestureDetector(
                onTap: () {
                  _handleLocationPermission();
                  _getCurrentPosition();
                  validateLogin();
                  AnimatedSnackBar.rectangle(
                    'Success',
                    'Login Successful!',
                    type: AnimatedSnackBarType.success,
                    brightness: Brightness.light,
                    duration: Duration(seconds: 2),
                  ).show(
                    context,
                  );
                  // Navigator.pushReplacement(
                  //     context,
                  //     MaterialPageRoute(
                  //         builder: (context) => MyHomePage(
                  //               title: '',
                  //             )));
                },
                child: Container(
                  height: 60,
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [
                        Color.fromARGB(255, 28, 77, 59),
                        Color.fromARGB(255, 96, 204, 165),
                      ],
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                    ),
                    borderRadius: BorderRadius.circular(16.0),
                  ),
                  child: Center(
                      child: Text(
                    'Login',
                    style: TextStyle(fontSize: 24.0, color: Colors.white),
                  )),
                  // onPressed: validateLogin,
                ),
              ),
              GestureDetector(
                  onTap: () => {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => SignupScreen()))
                      },
                  child: Container(
                    margin: EdgeInsets.only(top: 16.0),
                    child: Align(
                        alignment: Alignment.centerRight,
                        child: Text(
                          "Don't have account? Signup!",
                          style: TextStyle(
                            fontSize: 15,
                            color: Colors.blue,
                          ),
                        )),
                  )),
            ],
          ),
        ),
      ),
    );
  }
}
