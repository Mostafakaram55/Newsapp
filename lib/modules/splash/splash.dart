import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:ymcs/modules/business/business_screen.dart';
import 'package:ymcs/presentation/presentation_screen.dart';

class Splash extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return AnimatedSplashScreen(
      duration: 400,
      backgroundColor: Colors.deepOrange,
      splashIconSize: 250,
      splash: Column(
        children: [
          Center(
            child: Text(
                'News APP',
              style: TextStyle(
                color: Colors.white,
                fontSize: 50,
                fontWeight: FontWeight.bold
              ),
            ),
          ),
        ],
      ),
      nextScreen:Bresentation(),
    );
  }
}
