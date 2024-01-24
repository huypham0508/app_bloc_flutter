import 'package:shared_preferences/shared_preferences.dart';

class LocalDataSource {
  LocalDataSource(this.sf);

  final SharedPreferences sf;

  Future<void> saveUserName(String token) async {
    await sf.setString('userName', token);
  }

  Future<String?> getUserName() async {
    return sf.getString('userName');
  }

  Future<void> deleteUserName() async {
    await sf.remove('userName');
  }
}
