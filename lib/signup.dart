import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:groot/home_page.dart';
import 'package:groot/login.dart';
import 'package:http/http.dart' as http;

class SignupScreen extends StatefulWidget {
  @override
  _SignupScreenState createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  TextEditingController _usernameController = TextEditingController();
  TextEditingController _emailController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();
  TextEditingController _nameController = TextEditingController();
  TextEditingController _locationController = TextEditingController();
  TextEditingController _age = TextEditingController();
  TextEditingController _isDisabled = TextEditingController();
  TextEditingController _disabilityName = TextEditingController();
  TextEditingController _disabilityCard = TextEditingController();
  TextEditingController _isExServiceMan = TextEditingController();
  TextEditingController _servicemaIdCard = TextEditingController();
  TextEditingController _industry = TextEditingController();
  bool? _isServiceman = false;
  bool? _isDisabledBool = false;

  Future<bool> signup() async {
    final username = _usernameController.text;
    final email = _emailController.text;
    final password = _passwordController.text;
    final name = _nameController.text;
    final location = _locationController.text;
    final age = _age.text;
    final industry = _industry.text;
    final isDisabled = _isDisabledBool;
    final disabilityName = _disabilityName.text;
    final disabilityCard = _disabilityCard.text;
    final isExServiceMan = _isServiceman;
    final servicemaIdCard = _servicemaIdCard.text;
    print(isDisabled);
    var response = await http.post(
      Uri.parse("https://manipal-hackathon-2.onrender.com/api/user/register"),
      body: jsonEncode(<String, dynamic>{
        'username': username.toString(),
        'email': email.toString(),
        'password': password.toString(),
        'name': name.toString(),
        'resident_location': location.toString().toLowerCase(),
        'age': age.toString(),
        'industry': industry.toString().toLowerCase(),
        'isDisabled': isDisabled,
        'disabilityName': disabilityName.toString(),
        'disabilityIdCard': disabilityCard.toString(),
        'isExServiceman': isExServiceMan,
        'servicemanIdCard': servicemaIdCard.toString(),
      }),
      headers: <String, String>{'Content-Type': 'application/json'},
    );
    print('Response status: ${response.statusCode}');
    print('Response body: ${response.body}');
    // save
    if (response.statusCode == 200) {
      return true;
    } else {
      return false;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Sign Up'),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              TextFormField(
                controller: _usernameController,
                decoration: InputDecoration(
                  labelText: 'Username',
                ),
              ),
              SizedBox(height: 20),
              TextFormField(
                controller: _emailController,
                decoration: InputDecoration(
                  labelText: 'Email',
                ),
              ),
              SizedBox(height: 20),
              TextFormField(
                controller: _passwordController,
                decoration: InputDecoration(
                  labelText: 'Password',
                ),
                obscureText: true, // Hide the password
              ),
              SizedBox(height: 20),
              TextFormField(
                controller: _nameController,
                decoration: InputDecoration(
                  labelText: 'Name',
                ),
              ),
              SizedBox(height: 20),
              TextFormField(
                controller: _locationController,
                decoration: InputDecoration(
                  labelText: 'Location',
                ),
              ),
              SizedBox(height: 20),
              TextFormField(
                controller: _age,
                decoration: InputDecoration(
                  labelText: 'Age',
                ),
              ),
              SizedBox(height: 20),
              TextFormField(
                controller: _industry,
                decoration: InputDecoration(
                  labelText: 'Industry',
                ),
              ),
              SizedBox(height: 20),
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  // Existing form fields...

                  SizedBox(height: 20),

                  Row(
                    children: <Widget>[
                      Radio(
                        value: false,
                        groupValue: _isDisabledBool,
                        onChanged: (bool? value) {
                          setState(() {
                            _isDisabledBool = value;
                          });
                        },
                      ),
                      Text('Not Disabled'),
                    ],
                  ),

                  Row(
                    children: <Widget>[
                      Radio(
                        value: true,
                        groupValue: _isDisabledBool,
                        onChanged: (bool? value) {
                          setState(() {
                            _isDisabledBool = value;
                          });
                        },
                      ),
                      Text('Is Disabled'),
                    ],
                  ),

                  SizedBox(height: 20),
                ],
              ),
              SizedBox(height: 20),
              _isDisabledBool!
                  ? TextFormField(
                      controller: _disabilityName,
                      decoration: InputDecoration(
                        labelText: 'Disability Name',
                      ),
                    )
                  : SizedBox(height: 0),
              SizedBox(height: 20),
              _isDisabledBool!
                  ? TextFormField(
                      controller: _disabilityCard,
                      decoration: InputDecoration(
                        labelText: 'Disability Card',
                      ),
                    )
                  : SizedBox(height: 0),
              SizedBox(height: 20),

// ...

              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  // Existing form fields...

                  SizedBox(height: 20),

                  Row(
                    children: <Widget>[
                      Radio(
                        value: false,
                        groupValue: _isServiceman,
                        onChanged: (bool? value) {
                          setState(() {
                            _isServiceman = value;
                          });
                        },
                      ),
                      Text('Not a Serviceman'),
                    ],
                  ),

                  Row(
                    children: <Widget>[
                      Radio(
                        value: true,
                        groupValue: _isServiceman,
                        onChanged: (bool? value) {
                          setState(() {
                            _isServiceman = value;
                          });
                        },
                      ),
                      Text('Is a Serviceman'),
                    ],
                  ),

                  SizedBox(height: 20),
                ],
              ),
              _isServiceman!
                  ? TextFormField(
                      controller: _servicemaIdCard,
                      decoration: InputDecoration(
                        labelText: 'Serviceman Id Card',
                      ),
                    )
                  : SizedBox(height: 0),
              ElevatedButton(
                onPressed: () async {
                  // Handle the sign-up logic here
                  final username = _usernameController.text;
                  final email = _emailController.text;
                  final password = _passwordController.text;
                  final name = _nameController.text;
                  final location = _locationController.text;
                  final age = _age.text;
                  final industry = _industry.text;

                  // You can add validation and registration logic here
                  // For example, you can call an authentication API or save the data to a database.

                  print('Username: $username');
                  print('Email: $email');
                  print('Password: $password');
                  bool signupSuccess = await signup();
                  if (signupSuccess) {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => LoginScreen()));
                  }
                },
                child: Text('Sign Up'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
