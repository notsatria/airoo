import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../theme.dart';
import 'home/main_screen.dart';
import 'sign_up_screen.dart';

class LoginScreen extends StatefulWidget {
  static const routeName = '/login-screen';

  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _auth = FirebaseAuth.instance;
  bool _isLoading = false;

  @override
  Widget build(BuildContext context) {
    Widget header() {
      return Container(
        margin: const EdgeInsets.only(top: 50),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Selamat Datang',
              style: primaryTextStyle.copyWith(
                fontSize: 28,
                fontWeight: bold,
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            Text(
              'Masukkan informasi anda dengan benar untuk menggunakan aplikasi Gas Detector',
              style: primaryTextStyle.copyWith(
                fontSize: 16,
              ),
            ),
          ],
        ),
      );
    }

    Widget emailInput() {
      return Container(
        margin: const EdgeInsets.only(top: 50),
        child: Container(
          padding: const EdgeInsets.all(12.0),
          height: 50,
          decoration: BoxDecoration(
            color: backgroundColor2,
            borderRadius: BorderRadius.circular(8),
          ),
          child: Center(
            child: TextFormField(
              controller: _emailController,
              style: primaryTextStyle,
              decoration: InputDecoration.collapsed(
                hintText: 'E-mail',
                hintStyle: primaryTextStyle,
              ),
            ),
          ),
        ),
      );
    }

    Widget passwordInput() {
      return Container(
        margin: const EdgeInsets.only(top: 20),
        child: Container(
          padding: const EdgeInsets.all(12.0),
          height: 50,
          decoration: BoxDecoration(
            color: backgroundColor2,
            borderRadius: BorderRadius.circular(8),
          ),
          child: Center(
            child: TextFormField(
              controller: _passwordController,
              style: primaryTextStyle,
              obscureText: true,
              decoration: InputDecoration.collapsed(
                hintText: 'Password',
                hintStyle: primaryTextStyle,
              ),
            ),
          ),
        ),
      );
    }

    Widget forgotPassword() {
      return TextButton(
        onPressed: () {},
        child: Text(
          'Lupa Password?',
          style: primaryTextStyle.copyWith(
            fontSize: 16,
            color: primaryColor,
            fontWeight: semiBold,
          ),
        ),
      );
    }

    Widget buttonLogin() {
      return Container(
        width: double.infinity,
        margin: const EdgeInsets.only(top: 30),
        height: 50,
        child: ElevatedButton(
          onPressed: () async {
            setState(() {
              _isLoading = true;
            });

            try {
              final email = _emailController.text;
              final password = _passwordController.text;

              await _auth.signInWithEmailAndPassword(
                email: email,
                password: password,
              );
              Navigator.pushReplacementNamed(context, MainScreen.routeName);
            } catch (e) {
              final snackbar = SnackBar(content: Text(e.toString()));
              ScaffoldMessenger.of(context).showSnackBar(snackbar);
            } finally {
              setState(() {
                _isLoading = false;
              });
            }
          },
          style: ElevatedButton.styleFrom(
            backgroundColor: primaryColor,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8),
            ),
          ),
          child: Text(
            'Masuk',
            style: whiteTextStyle.copyWith(
              fontSize: 16,
              fontWeight: bold,
            ),
          ),
        ),
      );
    }

    Widget textSignUp() {
      return Container(
        margin: EdgeInsets.only(top: defaultMargin),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Belum punya akun?',
              style: primaryTextStyle.copyWith(fontSize: 16),
            ),
            const SizedBox(
              width: 5,
            ),
            GestureDetector(
              onTap: () {
                Navigator.pushNamed(context, SignUpScreen.routeName);
              },
              child: Text(
                'Daftar',
                style: primaryTextStyle.copyWith(
                  fontSize: 16,
                  fontWeight: semiBold,
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
        backgroundColor: backgroundColor1,
        body: Container(
          margin: EdgeInsets.symmetric(horizontal: defaultMargin),
          child: Stack(
            children: [
              Column(
                children: [
                  header(),
                  emailInput(),
                  passwordInput(),
                  const SizedBox(height: 20),
                  buttonLogin(),
                  textSignUp(),
                ],
              ),
              _isLoading
                  ? const Center(
                      child: CircularProgressIndicator(),
                    )
                  : const SizedBox(),
            ],
          ),
        ),
      ),
    );
  }
}
