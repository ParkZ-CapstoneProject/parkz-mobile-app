import 'package:shared_preferences/shared_preferences.dart';

class PreferenceManager {
  static Future<SharedPreferences> getInstance() async {
    return await SharedPreferences.getInstance();
  }

  static Future<void> setLatitude(double lat) async {
    SharedPreferences prefs = await getInstance();
    await prefs.setDouble('Latitude', lat);
  }

  static Future<double?> getLatitude() async {
    SharedPreferences prefs = await getInstance();
    return prefs.getDouble('Latitude');
  }

  static Future<void> setLongitude(double long) async {
    SharedPreferences prefs = await getInstance();
    await prefs.setDouble('Longitude', long);
  }

  static Future<double?> getLongitude() async {
    SharedPreferences prefs = await getInstance();
    return prefs.getDouble('Longitude');
  }

  static Future<void> setAddress(String address) async {
    SharedPreferences prefs = await getInstance();
    await prefs.setString('Address', address);
  }

  static Future<String?> getAddress() async {
    SharedPreferences prefs = await getInstance();
    return prefs.getString('Address');
  }


}
