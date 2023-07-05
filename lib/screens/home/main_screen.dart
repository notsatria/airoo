import 'package:flutter/material.dart';

import '../../theme.dart';
import 'home_screen.dart';
import 'log_screen.dart';
import 'profile_screen.dart';

class MainScreen extends StatefulWidget {
  static const routeName = '/main-screen';
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int currIndex = 0;

  @override
  Widget build(BuildContext context) {
    Widget customBottomNav() {
      return BottomAppBar(
        child: BottomNavigationBar(
          currentIndex: currIndex,
          onTap: (value) {
            setState(() {
              currIndex = value;
            });
          },
          type: BottomNavigationBarType.fixed,
          backgroundColor: backgroundColor2,
          items: [
            BottomNavigationBarItem(
              icon: Container(
                margin: const EdgeInsets.only(
                  top: 10,
                  bottom: 5,
                ),
                child: currIndex == 0
                    ? Icon(
                        Icons.home,
                        color: primaryColor,
                      )
                    : Icon(
                        Icons.home_outlined,
                        color: primaryColor,
                      ),
              ),
              label: '',
            ),
            BottomNavigationBarItem(
              icon: Container(
                margin: const EdgeInsets.only(
                  top: 10,
                  bottom: 5,
                ),
                child: currIndex == 1
                    ? Icon(
                        Icons.data_thresholding,
                        color: primaryColor,
                      )
                    : Icon(
                        Icons.data_thresholding_outlined,
                        color: primaryColor,
                      ),
              ),
              label: '',
            ),
            BottomNavigationBarItem(
              icon: Container(
                margin: const EdgeInsets.only(
                  top: 10,
                  bottom: 5,
                ),
                child: currIndex == 2
                    ? Icon(
                        Icons.person,
                        color: primaryColor,
                      )
                    : Icon(
                        Icons.person_outline,
                        color: primaryColor,
                      ),
              ),
              label: '',
            ),
          ],
        ),
      );
    }

    Widget body() {
      switch (currIndex) {
        case 0:
          return HomeScreen();

        case 1:
          return const LogScreen();

        case 2:
          return const ProfileScreen();

        default:
          return HomeScreen();
      }
    }

    return SafeArea(
      child: Scaffold(
        backgroundColor: backgroundColor1,
        bottomNavigationBar: customBottomNav(),
        body: body(),
      ),
    );
  }
}
