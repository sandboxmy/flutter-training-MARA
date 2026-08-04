import 'dart:async';

import 'package:flutter/material.dart';
import 'package:loading_indicator/loading_indicator.dart';

import 'login_screen.dart';

/// Primary color used by To-Do App samples
const Color kPrimary = Color(0xFF6C72C9);

/// LOADING (SPLASH) SCREEN
/// Shows app logo for 2 seconds, then goes to Login.
class LoadingScreen extends StatefulWidget {
  const LoadingScreen({super.key});

  static const String routeName = '/splash';

  @override
  State<LoadingScreen> createState() => _LoadingScreenState();
}

class _LoadingScreenState extends State<LoadingScreen> {
  @override
  void initState() {
    super.initState();

    // Wait 2 seconds, then open Login screen
    Timer(const Duration(seconds: 2), () {
      if (!mounted) return;

      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const LoginScreen()),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kPrimary,
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: const [
            // Icon(
            //   Icons.check_circle_rounded,
            //   size: 80,
            //   color: Colors.white,
            // ),
            SizedBox(
              height: 80,
              width: 80,
              child: LoadingIndicator(
                indicatorType: Indicator.ballSpinFadeLoader,
                colors: [Colors.white, Colors.grey, Colors.blue],
                strokeWidth: 4.0,
                pathBackgroundColor: Colors.black45,
              ),
            ),
            SizedBox(height: 20),
            Text(
              'To-Do App',
              style: TextStyle(
                color: Colors.white,
                fontSize: 28,
                fontWeight: FontWeight.w800,
                letterSpacing: 1.0,
              ),
            ),
            SizedBox(height: 8),
            Text(
              'Stay on top of your tasks',
              style: TextStyle(color: Colors.white70, fontSize: 15),
            ),
          ],
        ),
      ),
    );
  }
}
