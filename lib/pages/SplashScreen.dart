import 'dart:async';

import 'package:flutter/material.dart';
import 'HomeScreen.dart';


class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  void initState() {
    super.initState();
    Future.delayed(Duration(seconds: 3), () {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => HomeScreen()),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Stack(
      alignment: Alignment.center,
      fit: StackFit.expand,
      children: [
        Container(
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          decoration: BoxDecoration(
            color: Colors.white
              // image: DecorationImage(
              //     fit: BoxFit.cover,
              //     image:
              //         AssetImage("assets/images/image-splashBackground.png")
              )

          //),
        ),
        Positioned(
          child: Container(
            alignment: Alignment.center,
            height: 295,
            width: 293,
            // decoration: BoxDecoration(
            //   image: DecorationImage(
            //       image: AssetImage("assets/images/splashLoading.png")),
            // ),
            child: Text(
              "Foodhub",
              style: TextStyle(
                color: Colors.red,
                fontSize: 40,
               // fontFamily: AppFonts.comfortaaRegular,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        )
      ],
    ));
  }
}
