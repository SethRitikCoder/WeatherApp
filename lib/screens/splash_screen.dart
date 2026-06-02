import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_application_1/screens/home_screen.dart';

import 'package:lottie/lottie.dart';
import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';


class MySplashScreen extends StatefulWidget {
  const MySplashScreen({super.key});

  @override
  State<MySplashScreen> createState() => _MySplashScreenState();
}

class _MySplashScreenState extends State<MySplashScreen> {
  double scale = 0.0;
  @override
  void initState() {
    callback();

    scale = 1.0;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final screenheight = MediaQuery.of(context).size.height;
    final screenwidth = MediaQuery.of(context).size.width;
    return Scaffold(
      body: Container(
        height: screenheight,
        width: screenwidth,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
              Colors.indigo,
              Colors.lightBlue,
              // Colors.tealAccent.withValues(alpha: 0.3),
              // Colors.lightBlue.withValues(alpha: 0.7),
            ],
            begin: AlignmentGeometry.topCenter,
            end: AlignmentGeometry.bottomCenter,
          ),
        ),
        child: Stack(
          children: [
            Positioned(
              top: screenheight * 0.18,
              left: screenwidth * 0.1,
              child: SizedBox(
                height: screenwidth * 0.8,
                width: screenwidth * 0.8,
                child: LottieBuilder.asset(
                  "assets/animation/3fa5861e-1161-11ee-99e6-1f2f34566ebe.json",
                  animate: true,
                  repeat: false,
                ),
              ),
            ),

            // Positioned(
            //   top: screenheight * 0.2,
            //   left: screenwidth * 0.27,
            //   child: AnimatedScale(
            //     scale: scale,
            //     duration: Duration(seconds: 2),
            //     child: Uihelper.customText(
            //       data: "cdgfchfg",
            //       size: 20,
            //       color: Colors.black,
            //     ),
            //   ),
            // ),
            Positioned(
              top: screenheight * 0.44,
              left: screenwidth * 0.30,
              child: AnimatedTextKit(
                animatedTexts: [
                  WavyAnimatedText(
                    "Mausam App",
                    textStyle: TextStyle(
                      fontSize: 25,
                      fontWeight: FontWeight.bold,
                      fontFamily: "Inter24",
                      color: Colors.white.withValues(alpha: 1),
                    ),
                  ),
                ],
                isRepeatingAnimation: false,
              ),
            ),
            Positioned(
              top: screenheight * 0.478,
              left: screenwidth * 0.42,
              child: AnimatedTextKit(
                animatedTexts: [
                  TypewriterAnimatedText(
                    "Made By Ritik",

                    textStyle: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      fontFamily: "Caveat",
                      color: Colors.white70,
                    ),
                  ),
                ],
                isRepeatingAnimation: false,
                totalRepeatCount: 1,
                repeatForever: false,
                displayFullTextOnTap: true,
              ),
            ),
            Positioned(
              top: screenheight * 0.54,
              left: screenwidth * 0.44,
              child: SpinKitCircle(color: Colors.white, size: 40.0),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> callback() async {
    await Future.delayed(Duration(seconds: 7), () {
      if (!mounted) return;
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => MyWeatherScreen()),
      );
    });
  }
}
