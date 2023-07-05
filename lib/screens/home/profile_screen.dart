import 'package:flutter/material.dart';

import '../../theme.dart';

class ProfileScreen extends StatelessWidget {
  static const routeName = '/profile-screen';
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    Widget profileHeader() {
      return Container(
        margin: const EdgeInsets.only(
          top: 20,
        ),
        child: ListTile(
          leading: const CircleAvatar(
            radius: 30,
            backgroundImage: NetworkImage(
              'https://i.pravatar.cc/150?img=12',
            ),
          ),
          title: Text(
            'Muhammad Fadli',
            style: primaryTextStyle.copyWith(
              fontSize: 18,
              fontWeight: bold,
            ),
          ),
          subtitle: Text(
            'muhammadfadli@gmail.com',
            style: primaryTextStyle.copyWith(
              fontSize: 14,
            ),
          ),
          trailing: IconButton(
            icon: Icon(
              Icons.exit_to_app,
              color: alertColor,
              size: 30,
            ),
            onPressed: () {
              //
            },
          ),
        ),
      );
    }

    Widget accountProfileBlock() {
      return Container(
        margin: EdgeInsets.only(top: defaultMargin),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 14.0),
              child: Text(
                'Akun Saya',
                style: primaryTextStyle.copyWith(
                  fontWeight: bold,
                  fontSize: 16,
                ),
              ),
            ),
            GestureDetector(
              onTap: () {
                // Navigator.pushNamed(context, EditProfileScreen.routeName);
              },
              child: const ListTile(
                leading: Text(
                  'Edit Profil',
                ),
                trailing: Icon(
                  Icons.chevron_right_rounded,
                ),
              ),
            ),
            GestureDetector(
              onTap: () {
                //
              },
              child: const ListTile(
                leading: Text(
                  'Change Password',
                ),
                trailing: Icon(
                  Icons.chevron_right_rounded,
                ),
              ),
            ),
            GestureDetector(
              onTap: () {
                //
              },
              child: const ListTile(
                leading: Text(
                  'Informasi',
                ),
                trailing: Icon(
                  Icons.chevron_right_rounded,
                ),
              ),
            ),
          ],
        ),
      );
    }

    Widget generalProfileBlock() {
      return Container(
        margin: const EdgeInsets.only(top: 10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 14.0),
              child: Text(
                'General',
                style: primaryTextStyle.copyWith(
                  fontWeight: bold,
                  fontSize: 16,
                ),
              ),
            ),
            GestureDetector(
              onTap: () {
                //
              },
              child: const ListTile(
                leading: Text(
                  'Privacy & Policy',
                ),
                trailing: Icon(
                  Icons.chevron_right_rounded,
                ),
              ),
            ),
            GestureDetector(
              onTap: () {
                //
              },
              child: const ListTile(
                leading: Text(
                  'Terms of Service',
                ),
                trailing: Icon(
                  Icons.chevron_right_rounded,
                ),
              ),
            ),
            GestureDetector(
              onTap: () {
                //
              },
              child: const ListTile(
                leading: Text(
                  'Rate App',
                ),
                trailing: Icon(
                  Icons.chevron_right_rounded,
                ),
              ),
            ),
          ],
        ),
      );
    }

    return SafeArea(
      child: Scaffold(
          resizeToAvoidBottomInset: false,
          body: Container(
            margin: EdgeInsets.symmetric(
              horizontal: defaultMargin,
            ),
            child: Column(
              children: [
                profileHeader(),
                accountProfileBlock(),
                generalProfileBlock(),
              ],
            ),
          )),
    );
  }
}
