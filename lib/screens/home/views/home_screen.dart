import 'package:adhaar_app/screens/home/prrovider/home_provider.dart';
import 'package:adhaar_app/utils/extentions/sizedbox_extention.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  HomeProvider read = HomeProvider();
  HomeProvider watch = HomeProvider();
  InAppWebViewController? webViewController;
  PullToRefreshController? pullToRefreshController;

  @override
  void initState() {
    pullToRefreshController = kIsWeb
        ? null
        : PullToRefreshController(
            settings: PullToRefreshSettings(color: Colors.blue),
            onRefresh: () {
              if (defaultTargetPlatform == TargetPlatform.android) {
                webViewController!.reload();
              } else if (defaultTargetPlatform == TargetPlatform.iOS) {
                webViewController!.reload();
              }
            },
          );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    read = context.read<HomeProvider>();
    watch = context.watch<HomeProvider>();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Home'),
        actions: [
          IconButton(
            onPressed: () async {
              await webViewController!.goBack();
            },
            icon: const Icon(Icons.arrow_back_ios_new),
          ),
          IconButton(
            onPressed: () {
              webViewController!.reload();
            },
            icon: const Icon(Icons.refresh),
          ),
          IconButton(
            onPressed: () async {
              await webViewController!.goForward();
            },
            icon: const Icon(Icons.arrow_forward_ios),
          ),
        ],
      ),
      drawer: Drawer(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              const Text(
                "Search Engine",
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              const Divider(),
              Expanded(
                child: ListView.builder(
                  itemCount: watch.browserList.length,
                  itemBuilder: (context, index) {
                    bool isSelected = watch.url == watch.browserList[index].url;
                    return ListTile(
                      title: Text(watch.browserList[index].name!),
                      trailing: isSelected
                          ? const Icon(Icons.check, color: Colors.green)
                          : null,
                      onTap: () async {
                        await read.shrHelper
                            .setUrl(watch.browserList[index].url ?? "");
                        await read.changeUrl();
                        Navigator.of(context).pop();
                      },
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
      body: Column(
        children: [
          LinearProgressIndicator(
            value: watch.progress,
          ),
          Expanded(
            child: InAppWebView(
              pullToRefreshController: pullToRefreshController,
              initialUrlRequest: URLRequest(url: WebUri(watch.url)),
              onWebViewCreated: (controller) {
                webViewController = controller;
              },
              onProgressChanged: (controller, progress) {
                read.progress = progress / 100;
              },
              onLoadStop: (controller, url) {
                pullToRefreshController!.endRefreshing();
              },
            ),
          ),
        ],
      ),
    );
  }
}
