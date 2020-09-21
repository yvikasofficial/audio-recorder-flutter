import 'package:flutter/cupertino.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AudioProvider extends ChangeNotifier {
  SharedPreferences preferences;
  List list;

  initilize() async {
    preferences = await SharedPreferences.getInstance();
  }

  getAllAudiosList() {
    return preferences.getStringList("audios");
  }

  addNewAudio(String url) {
    List<String> list = preferences.getStringList("audios");
    if (list == null) {
      list = [];
    }
    list.add(url);
    preferences.setStringList("audios", list);
    notifyListeners();
  }
}
