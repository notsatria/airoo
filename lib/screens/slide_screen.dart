import 'package:flutter/material.dart';
import 'package:intro_slider/intro_slider.dart';

import '../theme.dart';
import 'login_screen.dart';

class SlideScreen extends StatefulWidget {
  static const routeName = '/slide-screen';
  const SlideScreen({super.key});

  @override
  State<SlideScreen> createState() => _SlideScreenState();
}

class _SlideScreenState extends State<SlideScreen> {
  List<ContentConfig> listSliderContent = [];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    listSliderContent.add(
      ContentConfig(
        description:
            'Airoo memudahkan anda untuk memantau kualitas udara di sekitar anda secara realtime tanpa harus keluar rumah',
        pathImage: 'assets/gas.png',
        widthImage: 300,
        backgroundColor: secondaryColor,
        styleDescription: whiteTextStyle.copyWith(
          fontSize: 16,
          fontWeight: medium,
        ),
      ),
    );
    listSliderContent.add(
      ContentConfig(
        description:
            'Airoo menggunakan sensor gas dengan teknologi MQ-2 untuk mendeteksi kebocoran gas di udara',
        pathImage: 'assets/sensor.png',
        widthImage: 300,
        backgroundColor: secondaryColor,
        styleDescription: whiteTextStyle.copyWith(
          fontSize: 16,
          fontWeight: medium,
        ),
      ),
    );
    listSliderContent.add(
      ContentConfig(
        description:
            'Airoo akan memberikan notifikasi kepada anda jika terdeteksi kebocoran gas di rumah anda',
        pathImage: 'assets/notification.png',
        widthImage: 300,
        backgroundColor: secondaryColor,
        styleDescription: whiteTextStyle.copyWith(
          fontSize: 16,
          fontWeight: medium,
        ),
      ),
    );
  }

  void onDonePress() {
    Navigator.pushReplacementNamed(context, LoginScreen.routeName);
  }

  void onSkipPress() {
    Navigator.pushReplacementNamed(context, LoginScreen.routeName);
  }

  @override
  Widget build(BuildContext context) {
    return IntroSlider(
      key: UniqueKey(),
      listContentConfig: listSliderContent,
      onDonePress: onDonePress,
      onSkipPress: onSkipPress,
      nextButtonStyle: TextButton.styleFrom(
        foregroundColor: backgroundColor1,
      ),
      skipButtonStyle: TextButton.styleFrom(
        foregroundColor: primaryColor,
      ),
      doneButtonStyle: TextButton.styleFrom(
        foregroundColor: primaryColor,
      ),
    );
  }
}
