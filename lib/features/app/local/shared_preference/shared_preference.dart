import 'package:firebase_auth/firebase_auth.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SharedPreferenceStorage {
  void saveUID(User uid) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('uid', uid.uid);
  }

  Future<String?> getUID() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString('uid');
  }
}
