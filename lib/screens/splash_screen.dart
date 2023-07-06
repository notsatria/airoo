import 'dart:async';

import 'package:flutter/material.dart';

import '../theme.dart';
import 'slide_screen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    // TODO: implement initState
    Timer(const Duration(seconds: 3), () {
      Navigator.pushReplacementNamed(context, SlideScreen.routeName);
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: primaryColor,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Airoo',
              style: subtitleTextStyle.copyWith(
                fontSize: 52,
                fontWeight: bold,
                color: secondaryColor,
              ),
            ),
            Text(
              'Gas Leak Detector',
              style: subtitleTextStyle.copyWith(
                fontSize: 20,
                fontWeight: reguler,
                color: backgroundColor1,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
