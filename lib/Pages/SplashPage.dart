import 'dart:async';

import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:audio_record_flutter/Constants.dart';
import 'package:audio_record_flutter/Pages/BoardinPage.dart';
import 'package:audio_record_flutter/Pages/HomePage.dart';
import 'package:audio_record_flutter/Providers/AudioProvider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SplashPage extends StatefulWidget {
  @override
  _SplashPageState createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  _handlePageRoute() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    bool isFirstTime = preferences.getBool("isFirstTime");
    if (isFirstTime == null)
      kReplaceRoute(BoardingPage(), context);
    else
      kReplaceRoute(HomePage(), context);
  }

  @override
  void initState() {
    Provider.of<AudioProvider>(context, listen: false).initilize();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Timer(Duration(seconds: 5), () => _handlePageRoute());
    return Scaffold(
      backgroundColor: kPrimaryColor,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Image.asset(
            "images/logo.png",
            height: 200,
          ),
          Container(),
          Container(),
          Container(),
          SizedBox(
            width: double.infinity,
            child: TextLiquidFill(
              text: 'MUSICIFY',
              waveColor: Colors.white,
              boxBackgroundColor: kPrimaryColor,
              textStyle: TextStyle(
                fontSize: 60.0,
                fontWeight: FontWeight.bold,
                fontFamily: 'RR',
              ),
              boxHeight: 100.0,
            ),
          ),
        ],
      ),
    );
  }
}
