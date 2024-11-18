import 'package:adhaar_app/screens/home/views/home_screen.dart';
import 'package:flutter/material.dart';

import '../screens/bookmark/views/bookmark_page.dart';

class AllRoutes {
  static const String home = '/';
  static const String bookmark = 'bookmark';

  static Map<String, Widget Function(BuildContext)> routes = {
    home: (context) => const HomeScreen(),
    bookmark: (context) => const BookmarkPage(),
  };
}
