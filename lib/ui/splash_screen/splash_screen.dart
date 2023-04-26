import 'dart:async';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pxquotes/constants/app_style.dart';

@override
class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    Timer(const Duration(seconds: 3), () {
      Navigator.of(context).pushNamedAndRemoveUntil("/mainscreen", (route) => false);
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SizedBox(
        height: 1.sh,
        width: double.infinity,
        child: Stack(
          alignment: Alignment.center,
          children: [
            Positioned(
              left: 0,
              bottom: 20,
              child: Container(
                height: 200,
                width: 0.8.sw,
                decoration: BoxDecoration(
                  color: const Color(0xff4461F2).withOpacity(0.3),
                  borderRadius: BorderRadius.circular(50),
                ),
              ),
            ),
            Positioned(
              left: 0,
              bottom: 0.5.sh,
              child: Container(
                height: 200,
                width: 0.2.sw,
                decoration: BoxDecoration(
                  color: const Color(0xffDDA82A).withOpacity(1),
                  borderRadius: BorderRadius.circular(50),
                ),
              ),
            ),
            Positioned(
              right: 0,
              bottom: 0.6.sh,
              child: Container(
                height: 200,
                width: 0.2.sw,
                decoration: BoxDecoration(
                  color: const Color(0xffEA4335).withOpacity(1),
                  borderRadius: BorderRadius.circular(50),
                ),
              ),
            ),
            Positioned.fill(
              child: ClipRRect(
                child: BackdropFilter(
                  filter: ImageFilter.blur(
                    sigmaX: 100,
                    sigmaY: 100,
                  ),
                  child: Container(
                    color: Colors.white.withOpacity(
                      0.01,
                    ),
                  ),
                ),
              ),
            ),
            Positioned(
              bottom: 40,
              child: Text(
                "Version 2.0.0+1",
                style: AppStyle.normalStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            Center(
              child: Image.asset(
                "assets/images/app_icon.png",
                height: 0.5.sw,
                width: 0.5.sw,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
