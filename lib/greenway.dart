import 'package:flutter/material.dart';
import 'package:groot/open_map_app.dart';

class GreenwayPage extends StatefulWidget {
  const GreenwayPage({super.key});

  @override
  State<GreenwayPage> createState() => _GreenwayPageState();
}

class _GreenwayPageState extends State<GreenwayPage> {
  @override
  Widget build(BuildContext context) {
    return Center(child: ElevatedButton(child: Text("Open Map"),onPressed: () => MapUtils.openMap(-3.823216,-38.481700),),);
  }
}