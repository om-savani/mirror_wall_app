import 'package:adhaar_app/routes/all_routes.dart';
import 'package:adhaar_app/screens/home/prrovider/home_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class BookmarkPage extends StatefulWidget {
  const BookmarkPage({super.key});

  @override
  State<BookmarkPage> createState() => _BookmarkPageState();
}

class _BookmarkPageState extends State<BookmarkPage> {
  HomeProvider read = HomeProvider();
  HomeProvider watch = HomeProvider();
  @override
  Widget build(BuildContext context) {
    read = context.read<HomeProvider>();
    watch = context.watch<HomeProvider>();
    return Scaffold(
      appBar: AppBar(
        title: const Text('Bookmark'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView.builder(
          itemCount: watch.bookmark.length,
          itemBuilder: (context, index) {
            return ListTile(
              title: watch.bookmark.isEmpty
                  ? const Text('No History')
                  : Text(watch.bookmark[index]),
              onTap: () {
                Navigator.pushNamed(context, AllRoutes.webPage,
                    arguments: watch.bookmark[index]);
              },
            );
          },
        ),
      ),
    );
  }
}
