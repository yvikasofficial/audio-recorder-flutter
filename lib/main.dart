import 'package:assets_audio_player/assets_audio_player.dart';
import 'package:audio_record_flutter/Pages/BoardinPage.dart';
import 'package:audio_record_flutter/Pages/SplashPage.dart';
import 'package:audio_record_flutter/Providers/AudioProvider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => AudioProvider()),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Musicify',
        theme: ThemeData(
          primarySwatch: Colors.blue,
          fontFamily: 'SF',
          visualDensity: VisualDensity.adaptivePlatformDensity,
        ),
        home: SplashPage(),
      ),
    );
  }
}
