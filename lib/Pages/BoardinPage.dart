import 'package:audio_record_flutter/Constants.dart';
import 'package:audio_record_flutter/Pages/HomePage.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sk_onboarding_screen/flutter_onboarding.dart';
import 'package:sk_onboarding_screen/sk_onboarding_screen.dart';

class BoardingPage extends StatefulWidget {
  @override
  _BoardingPageState createState() => _BoardingPageState();
}

class _BoardingPageState extends State<BoardingPage> {
  final pages = [
    SkOnboardingModel(
      title: 'Record Anytime',
      description:
          'Have access to unlimited record options for free! data is securly stored',
      titleColor: Colors.black,
      descripColor: kSecondaryColor,
      imagePath: 'images/1.jpg',
    ),
    SkOnboardingModel(
      title: 'Recap your playlist',
      description:
          'Get access to your own playlist when ever you need, data is securly stored',
      titleColor: Colors.black,
      descripColor: kSecondaryColor,
      imagePath: 'images/2.jpg',
    ),
    SkOnboardingModel(
      title: 'Add & remove components',
      description: 'Use delete to delete a album/Record new song to record',
      titleColor: Colors.black,
      descripColor: kSecondaryColor,
      imagePath: 'images/4.jpg',
    ),
  ];

  _handleGetStarted() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    preferences.setBool("isFirstTime", true);
    kReplaceRoute(HomePage(), context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SKOnboardingScreen(
        bgColor: Colors.white,
        themeColor: kPrimaryColor,
        pages: pages,
        skipClicked: (value) => _handleGetStarted(),
        getStartedClicked: (value) => _handleGetStarted(),
      ),
    );
  }
}
