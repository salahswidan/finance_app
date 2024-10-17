import 'dart:async';

import 'package:finance_app/color/colors.dart';
import 'package:finance_app/page/home_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    Timer(Duration(seconds: 2), () {
      Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (context) => HomePage()));
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SvgPicture.asset('assets/logo.svg'),
            SizedBox(
              height: 40,
            ),
            Text(
              'Finance',
              style: TextStyle(
                  fontSize: 24,
                  color: KPrimaryGreen,
                  fontWeight: FontWeight.bold),
            ),
          ],
        ),
      ),
    );
  }
}
