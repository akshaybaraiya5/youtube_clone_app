import 'package:flutter/material.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

import 'dart:async';

import 'home_screen.dart';
class SpashView extends StatefulWidget {
  const SpashView({super.key});

  @override
  State<SpashView> createState() => _SpashViewState();
}

class _SpashViewState extends State<SpashView> {

  void initState() {
    super.initState();
    Timer(Duration(seconds: 3),
            ()=>Navigator.pushReplacement(context,
            MaterialPageRoute(builder:
                (context) =>
                HomeScreen()
            )
        )
    );
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
      child:   Image.asset("assets/images/splash_youtube.webp",height: 160,),
      ),
    );
  }
}
