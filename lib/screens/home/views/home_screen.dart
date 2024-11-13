import 'package:adhaar_app/utils/extentions/sizedbox_extention.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../prrovider/home_provider.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  HomeProvider read = HomeProvider();
  HomeProvider watch = HomeProvider();

  @override
  void initState() {
    super.initState();
    context.read<HomeProvider>().checkConnection();
  }

  @override
  Widget build(BuildContext context) {
    read = context.read<HomeProvider>();
    watch = context.watch<HomeProvider>();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Home'),
      ),
      body: GridView.builder(
        itemCount: read.webList.length,
        itemBuilder: (BuildContext context, int index) {
          return GestureDetector(
            onTap: () {
              Navigator.pushNamed(context, 'web',
                  arguments: read.webList[index]);
            },
            child: Card(
              shadowColor: Colors.black12,
              margin: const EdgeInsets.all(5),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(read.webList[index].icon),
                  5.h,
                  Text("${read.webList[index].title}"),
                ],
              ),
            ),
          );
        },
        gridDelegate:
            const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2),
      ),
    );
  }
}
