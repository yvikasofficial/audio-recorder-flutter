import 'package:assets_audio_player/assets_audio_player.dart';
import 'package:audio_record_flutter/Constants.dart';
import 'package:audio_record_flutter/Pages/MusicPages/AddNewRecord.dart';
import 'package:audio_record_flutter/Providers/AudioProvider.dart';
import 'package:audio_record_flutter/Widgets/AudioItemWidget.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final assetsAudioPlayer = AssetsAudioPlayer();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var provider = Provider.of<AudioProvider>(context);
    return Scaffold(
      floatingActionButton: new FloatingActionButton(
        elevation: 0.0,
        child: new Icon(Icons.playlist_add),
        backgroundColor: kPrimaryColor,
        onPressed: () => kRoute(AddNewRecordingPage(), context),
      ),
      body: SafeArea(
        child: Consumer<AudioProvider>(
          builder: (context, value, child) {
            int len;
            if (value.getAllAudiosList() != null)
              len = value.getAllAudiosList().length;

            return Column(
              children: [
                _appBar(),
                value.getAllAudiosList() != null
                    ? Expanded(
                        child: ListView.builder(
                          itemCount: len,
                          itemBuilder: (context, index) {
                            return AudioItemWidget(
                              url: provider.getAllAudiosList()[len - index - 1],
                            );
                          },
                        ),
                      )
                    : Container(),
              ],
            );
          },
        ),
      ),
    );
  }

  _appBar() {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      width: double.infinity,
      height: 60,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
        boxShadow: [
          BoxShadow(
            color: Colors.black12,
            offset: Offset(0, 2),
            blurRadius: 6,
          )
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          IconButton(icon: Icon(Icons.list), onPressed: () {}),
          Text(
            "Songs",
            style: TextStyle(
              fontSize: 20,
            ),
          ),
          IconButton(icon: Icon(Icons.search), onPressed: () {}),
        ],
      ),
    );
  }
}
