import 'dart:async';
import 'dart:convert';

import 'constants.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AppSharedPreferences {
  static Future<SharedPreferences> getInstance() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs;
  }

  static Future<void> clear() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.clear();
  }

  static Future<List<int>> getFavorites() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    List<String> d = prefs.getStringList(SharedPreferenceKeys.Favorites);
    if (d == null) {
      d = [];
      prefs.setStringList(SharedPreferenceKeys.Favorites, d);
      return [];
    } else {
      List<int> parsedD = d.map((s) => int.parse(s)).toList();
      return parsedD;
    }
  }

  static Future<void> setFavorites(List<int> f) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    List<String> parsedF = f.map((i) => i.toString()).toList();
    return prefs.setStringList(SharedPreferenceKeys.Favorites, parsedF);
  }
}