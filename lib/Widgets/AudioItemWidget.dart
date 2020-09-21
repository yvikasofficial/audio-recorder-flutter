import 'package:assets_audio_player/assets_audio_player.dart';
import 'package:flutter/material.dart';

class AudioItemWidget extends StatefulWidget {
  final String url;
  AudioItemWidget({this.url});
  @override
  _AudioItemWidgetState createState() => _AudioItemWidgetState();
}

class _AudioItemWidgetState extends State<AudioItemWidget> {
  final assetsAudioPlayer = AssetsAudioPlayer();

  @override
  void initState() {
    super.initState();
    assetsAudioPlayer.open(
      Audio.file(widget.url),
      autoStart: false,
      loopMode: LoopMode.single,
    );
  }

  bool _isPlaying = false;
  _handleStopMusic() async {
    await assetsAudioPlayer.playOrPause();
  }

  @override
  Widget build(BuildContext context) {
    List list = widget.url.split("/");
    return GestureDetector(
      onTap: () => _handleStopMusic(),
      child: StreamBuilder<Object>(
          stream: assetsAudioPlayer.isPlaying,
          builder: (context, snapshot) {
            return Container(
              margin: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              height: 100,
              width: double.infinity,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(10),
              ),
              child: Row(
                children: [
                  Image.asset("images/cd.png"),
                  Expanded(
                    child: Text(
                      list[list.length - 1],
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                        fontSize: 18,
                      ),
                    ),
                  ),
                  snapshot.data
                      ? Icon(
                          Icons.pause,
                          size: 30,
                        )
                      : Icon(
                          Icons.play_arrow,
                          size: 30,
                        ),
                  SizedBox(width: 10),
                ],
              ),
            );
          }),
    );
  }
}
