import 'dart:async';

import 'package:flutter/material.dart';
import 'package:myhomestay_raya/loginscreen.dart';
import 'registrationscreen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {

  @override
  void initState() {
    super.initState();
    Timer(
        const Duration(seconds: 3),
        () => Navigator.pushReplacement(context,
            MaterialPageRoute(builder: (content) => const LoginScreen())));
  }

  @override
  Widget build(BuildContext context) {
   return Scaffold(
        body: Center(
      child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: const [
            Text("WELCOME TO HOMESTAY RAYA",
                style: TextStyle(
                  fontSize: 40,
                  fontWeight: FontWeight.bold,
                )),
            SizedBox(height: 30, width: 30, child: CircularProgressIndicator()),
            Text("Version 2.0",
            style: TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            )),

          ]),
    ),
    backgroundColor:Colors.white10);
  }
}
