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
  TextEditingController _industry = TextEditingController();

  Future<bool> signup() async {
    final username = _usernameController.text;
    final email = _emailController.text;
    final password = _passwordController.text;
    final name = _nameController.text;
    final location = _locationController.text;
    final age = _age.text;
    final industry = _industry.text;

    var response = await http.post(
      Uri.parse("https://manipal-hackathon-2.onrender.com/api/user/register"),
      body: jsonEncode(<String, String>{
        'username': username.toString(),
        'email': email.toString(),
        'password': password.toString(),
        'name': name.toString(),
        'resident_location': location.toString().toLowerCase(),
        'age': age.toString(),
        'industry': industry.toString().toLowerCase(),
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
