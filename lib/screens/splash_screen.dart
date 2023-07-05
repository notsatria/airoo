import 'dart:async';

import 'package:flutter/material.dart';

import '../theme.dart';
import 'login_screen.dart';

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
      Navigator.pushReplacementNamed(context, LoginScreen.routeName);
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
                fontSize: 40,
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
