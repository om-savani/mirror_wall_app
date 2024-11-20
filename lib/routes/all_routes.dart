import 'package:adhaar_app/screens/home/views/home_screen.dart';
import 'package:adhaar_app/screens/search%20History/views/search_hostory_page.dart';
import 'package:flutter/material.dart';

import '../screens/bookmark/views/bookmark_page.dart';
import '../screens/webview/view/web_page.dart';

class AllRoutes {
  static const String home = '/';
  static const String bookmark = 'bookmark';
  static const String searchHistory = 'searchHistory';
  static const String webPage = 'webPage';

  static Map<String, Widget Function(BuildContext)> routes = {
    home: (context) => const HomeScreen(),
    bookmark: (context) => const BookmarkPage(),
    searchHistory: (context) => const SearchHostoryPage(),
    webPage: (context) => const WebPage(),
  };
}
