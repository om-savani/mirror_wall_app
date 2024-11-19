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
  // String? selectedUrl;

  @override
  void initState() {
    pullToRefreshController = kIsWeb
        ? null
        : PullToRefreshController(
            settings: PullToRefreshSettings(color: Colors.red),
            onRefresh: () {
              if (defaultTargetPlatform == TargetPlatform.android) {
                webViewController!.reload();
              } else if (defaultTargetPlatform == TargetPlatform.iOS) {
                webViewController!.reload();
              }
            },
          );
    context.read<HomeProvider>().changeUrl();
    super.initState();
  }

  @override
  void dispose() {
    pullToRefreshController!.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    read = context.read<HomeProvider>();
    watch = context.watch<HomeProvider>();
    print("URL====: ${watch.url}");

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
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              30.h,
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
                        String selectedUrl = watch.browserList[index].url ?? "";
                        await read.shrHelper.setUrl(selectedUrl);
                        await read.changeUrl();
                        Navigator.of(context).pop();
                        webViewController?.loadUrl(
                          urlRequest: URLRequest(url: WebUri(watch.url)),
                        );
                      },
                    );
                  },
                ),
              ),
              10.h,
              Row(
                children: [
                  const Text("Dark Mode"),
                  5.w,
                  Switch(
                    value: watch.isDark,
                    onChanged: (value) {
                      webViewController?.setSettings(
                          settings: InAppWebViewSettings());
                      read.changeThemeMode(value);
                      print("Dark Mode:=== ${watch.isDark}");
                      print("ThemeMode:=== ${watch.themeMode}");
                    },
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
      body: Column(
        children: [
          Visibility(
            visible: read.progress < 1.0,
            child: LinearProgressIndicator(
              value: watch.progress,
            ),
          ),
          Expanded(
            child: InAppWebView(
              pullToRefreshController: pullToRefreshController,
              initialUrlRequest: URLRequest(
                  url: WebUri(watch.url ?? "https://www.google.com/")),
              onWebViewCreated: (controller) {
                webViewController = controller;
              },
              onProgressChanged: (controller, progress) {
                read.progress = progress / 100;
                if (progress == 100) pullToRefreshController!.endRefreshing();
              },
              onLoadStop: (controller, url) {
                pullToRefreshController!.endRefreshing();
              },
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        child: const Icon(Icons.bookmark),
      ),
    );
  }
}
