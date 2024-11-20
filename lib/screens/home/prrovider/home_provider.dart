import 'dart:async';
import 'package:adhaar_app/helper/shr_helper.dart';
import 'package:adhaar_app/model/browser_model.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';

class HomeProvider with ChangeNotifier {
  HomeProvider() {
    initMethods();
  }

  Connectivity connectivity = Connectivity();
  ShrHelper shrHelper = ShrHelper();
  double progress = 0;
  late String url;
  String currentUrl = "";
  ThemeMode themeMode = ThemeMode.light;
  bool isDark = false;
  List<String> searchHistory = [];
  List<String> bookmark = [];
  List<BrowsersModel> browserList = [
    BrowsersModel(
      name: "Google Chrome",
      url: "https://www.google.com/",
    ),
    BrowsersModel(
      name: "Yahoo",
      url: "https://in.search.yahoo.com/?fr2=inr",
    ),
    BrowsersModel(
      name: "DuckDuckGo",
      url: "https://duckduckgo.com/",
    ),
  ];

  bool isConnected = false;

  void checkConnection() async {
    StreamSubscription<List<ConnectivityResult>> results = (await Connectivity()
        .onConnectivityChanged
        .listen((List<ConnectivityResult> result) {
      if (result.contains(ConnectivityResult.none)) {
        isConnected = false;
      } else {
        isConnected = true;
      }
      notifyListeners();
    }));
  }

  void initMethods() {
    changeUrl();
    getThemeMode();
    getSearchHistory();
    getBookmark();
  }

  void changeProgress(double value) {
    progress = value;
    notifyListeners();
  }

  Future<void> changeUrl() async {
    url = await shrHelper.getUrl();
    notifyListeners();
  }

  changeThemeMode(bool value) async {
    isDark = value;
    themeMode = isDark ? ThemeMode.dark : ThemeMode.light;
    shrHelper.setThemeMode(isDark);
    notifyListeners();
  }

  void getThemeMode() async {
    isDark = await shrHelper.getThemeMode();
    themeMode = isDark ? ThemeMode.dark : ThemeMode.light;
    notifyListeners();
  }

  void saveSearchHistory(String value) async {
    searchHistory.add(value);
    shrHelper.setSearchHistory(searchHistory);
    notifyListeners();
  }

  void getSearchHistory() async {
    searchHistory = await shrHelper.getSearchHistory();
    notifyListeners();
  }

  void saveBookmark(String value) async {
    bookmark.add(value);
    shrHelper.setBookmark(bookmark);
    notifyListeners();
  }

  void getBookmark() async {
    bookmark = await shrHelper.getBookmark();
    notifyListeners();
  }

  // void getCurrentUrl(String url) async {
  //   currentUrl = url;
  //   notifyListeners();
  // }
}
