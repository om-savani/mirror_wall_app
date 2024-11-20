import 'package:adhaar_app/screens/home/prrovider/home_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SearchHostoryPage extends StatefulWidget {
  const SearchHostoryPage({super.key});

  @override
  State<SearchHostoryPage> createState() => _SearchHostoryPageState();
}

class _SearchHostoryPageState extends State<SearchHostoryPage> {
  HomeProvider read = HomeProvider();
  HomeProvider watch = HomeProvider();
  @override
  Widget build(BuildContext context) {
    read = context.read<HomeProvider>();
    watch = context.watch<HomeProvider>();
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () => Navigator.pop(context),
          icon: const Icon(Icons.arrow_back_ios_new),
        ),
        title: const Text('Search History'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView.builder(
          itemCount: watch.searchHistory.length,
          itemBuilder: (context, index) {
            return ListTile(
              title: watch.searchHistory.isEmpty
                  ? const Text('No History')
                  : Text(watch.searchHistory[index]),
            );
          },
        ),
      ),
    );
  }
}
