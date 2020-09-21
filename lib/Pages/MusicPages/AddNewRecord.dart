import 'dart:io';

import 'package:audio_record_flutter/Constants.dart';
import 'package:audio_record_flutter/Providers/AudioProvider.dart';
import 'package:flutter/material.dart';
import 'package:file/local.dart';
import 'package:flutter_audio_recorder/flutter_audio_recorder.dart';
import 'package:path_provider/path_provider.dart';
import 'package:provider/provider.dart';
import 'package:stop_watch_timer/stop_watch_timer.dart';
import 'package:toast/toast.dart';

class AddNewRecordingPage extends StatefulWidget {
  @override
  _AddNewRecordingPageState createState() => _AddNewRecordingPageState();
}

class _AddNewRecordingPageState extends State<AddNewRecordingPage> {
  bool _isRecording = false;
  bool onPause = false;
  LocalFileSystem localFileSystem = LocalFileSystem();
  FlutterAudioRecorder recorder;
  final StopWatchTimer _stopWatchTimer = StopWatchTimer();

  @override
  void initState() {
    super.initState();
  }

  _hanldeStartRecording() async {
    await recorder.start();

    setState(() {
      _isRecording = true;
    });
    _stopWatchTimer.onExecute.add(StopWatchExecute.start);
  }

  _handleStopRecording() async {
    var provider = Provider.of<AudioProvider>(context, listen: false);
    var result = await recorder.stop();
    print(result.duration);
    print(result.path);
    File file = localFileSystem.file(result.path);
    provider.addNewAudio(file.path);
    print(file.path);
    setState(() {
      _isRecording = false;
    });
    Navigator.pop(context);
    Toast.show("Audio recorded!", context,
        duration: Toast.LENGTH_SHORT, gravity: Toast.BOTTOM);
  }

  _handlePauseRecording() async {
    await recorder.pause();

    setState(() {
      onPause = true;
    });
    _stopWatchTimer.onExecute.add(StopWatchExecute.stop);
  }

  _handleResumeRecording() async {
    await recorder.resume();

    setState(() {
      onPause = false;
    });
    _stopWatchTimer.onExecute.add(StopWatchExecute.start);
  }

  _showStartRecording() {
    return GestureDetector(
      onTap: () async {
        bool hasPermission = await FlutterAudioRecorder.hasPermissions;
        final tempPath = await getApplicationSupportDirectory();
        if (hasPermission) {
          recorder = FlutterAudioRecorder(
              "${tempPath.path}/AUD_${DateTime.now().microsecondsSinceEpoch}.aac",
              audioFormat: AudioFormat.AAC);
          await recorder.initialized;
          _hanldeStartRecording();
        }
      },
      child: Column(
        children: [
          Container(
            padding: EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: kSecondaryColor.withOpacity(0.7),
              borderRadius: BorderRadius.circular(30),
            ),
            child: Text(
              "Start Recording",
              style: TextStyle(
                color: Colors.white,
                fontSize: 20,
              ),
            ),
          ),
        ],
      ),
    );
  }

  _showTimer() {
    return StreamBuilder<int>(
      stream: _stopWatchTimer.rawTime,
      initialData: 0,
      builder: (context, snap) {
        final value = snap.data;
        final displayTime = StopWatchTimer.getDisplayTime(value);
        return Column(
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.all(8),
              child: Text(
                displayTime,
                style: TextStyle(
                  fontSize: 40,
                  fontFamily: 'Helvetica',
                  color: Colors.white.withOpacity(0.5),
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ],
        );
      },
    );
  }

  _showStopRecording() {
    return Column(
      children: [
        _showTimer(),
        SizedBox(height: 20),
        !onPause
            ? GestureDetector(
                onTap: () => _handlePauseRecording(),
                child: CircleAvatar(
                  backgroundColor: kPrimaryColor,
                  radius: 30,
                  child: Icon(
                    Icons.pause,
                    size: 30,
                    color: Colors.white,
                  ),
                ),
              )
            : GestureDetector(
                onTap: () => _handleResumeRecording(),
                child: CircleAvatar(
                  backgroundColor: kPrimaryColor,
                  radius: 30,
                  child: Icon(
                    Icons.play_arrow,
                    size: 30,
                    color: Colors.white,
                  ),
                ),
              ),
        SizedBox(height: 40),
        GestureDetector(
          onTap: () => _handleStopRecording(),
          child: Container(
            padding: EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: kSecondaryColor.withOpacity(0.7),
              borderRadius: BorderRadius.circular(30),
            ),
            child: Text(
              "Stop Recording",
              style: TextStyle(
                color: Colors.white,
                fontSize: 18,
              ),
            ),
          ),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage("images/gradient.jpg"),
            fit: BoxFit.cover,
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            _recordLogo(),
            Container(),
            _isRecording ? _showStopRecording() : _showStartRecording(),
          ],
        ),
      ),
    );
  }

  _recordLogo() {
    return CircleAvatar(
      radius: 110,
      backgroundColor: Color(0xFF9C3455).withOpacity(0.3),
      child: CircleAvatar(
        backgroundColor: Color(0xFF9C3455).withOpacity(0.3),
        radius: 100,
        child: CircleAvatar(
          backgroundColor: kPrimaryColor,
          radius: 80,
          child: Icon(
            Icons.mic,
            size: 60,
            color: Colors.white,
          ),
        ),
      ),
    );
  }
}
