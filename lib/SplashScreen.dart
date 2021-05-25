import 'dart:async';
import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:quiz_app/home.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  Void initState() {
    super.initState();
    Timer(Duration(seconds: 3), () {
      Navigator.of(context)
          .pushReplacement(MaterialPageRoute(builder: (context) => HomePage()));
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.indigo,
      body: Center(
        child: Text(
          'Quiz Expert',
          style: TextStyle(
            fontSize: 50,
            color: Colors.white,
          ),
        ),
      ),
    );
  }
}
