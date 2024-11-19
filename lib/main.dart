import 'package:adhaar_app/routes/all_routes.dart';
import 'package:adhaar_app/screens/home/prrovider/home_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer(
      builder: (BuildContext context, value, Widget? child) {
        return MultiProvider(
          providers: [
            ChangeNotifierProvider.value(value: HomeProvider()),
          ],
          child: MaterialApp(
            debugShowCheckedModeBanner: false,
            routes: AllRoutes.routes,
          ),
        );
      },
      child: MultiProvider(
        providers: [
          ChangeNotifierProvider.value(value: HomeProvider()),
        ],
        child: Consumer<HomeProvider>(
          builder: (BuildContext context, value, Widget? child) {
            value.changeUrl();
            value.url = value.shrHelper.getUrl() as String;
            return MaterialApp(
              // darkTheme: ThemeData(
              //   brightness: value.isDark ? Brightness.dark : Brightness.light,
              // ),
              // themeMode: value.themeMode,
              // theme: ThemeData(
              //   useMaterial3: true,
              //   brightness: value.isDark ? Brightness.dark : Brightness.light,
              // ),
              themeMode: ThemeMode.system,
              debugShowCheckedModeBanner: false,
              routes: AllRoutes.routes,
            );
          },
        ),
      ),
    );
  }
}
