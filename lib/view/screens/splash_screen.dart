import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:netflix_clone/view/screens/Navigation.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return AnimatedSplashScreen(
      splash: LottieBuilder.asset('assets/netflix.json'),
      backgroundColor: Colors.black,
      nextScreen: Navigation(),
      splashIconSize: 350,
    );
  }
}
