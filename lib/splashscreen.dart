import 'dart:async';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:myhomestay_raya/loginscreen.dart';
import 'package:myhomestay_raya/registrationscreen.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:myhomestay_raya/shared/config.dart';
import '../../models/user.dart';
import 'mainscreen.dart';
import 'package:http/http.dart' as http;

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

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
      body: Stack(alignment: Alignment.center,children:[
        Container(
          decoration: const BoxDecoration(
            image: DecorationImage(
              image: AssetImage('assets/images/home.jpg'),
              fit: BoxFit.cover ))),
      Padding(
        padding: const EdgeInsets.fromLTRB(0, 50, 0, 20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Text("MYHOMESTAY RAYA",
            style: TextStyle(fontSize: 40, fontWeight: FontWeight.bold),
             ),
             SizedBox(
              height: 40, width: 40, child: CircularProgressIndicator()),
              Text(
                "Calm and Fresh",
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
             
            ],
          ),
        ),
      ]),
    );
    
  }

  

}
