import 'package:adhaar_app/screens/home/prrovider/home_provider.dart';
import 'package:adhaar_app/screens/home/views/home_screen.dart';
import 'package:adhaar_app/screens/webview/view/web_page.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider.value(value: HomeProvider()),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        routes: {
          '/': (context) => const HomeScreen(),
          'web': (context) => const WebPage(),
        },
      ),
    );
  }
}
