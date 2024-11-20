import 'package:adhaar_app/model/web_models.dart';
import 'package:adhaar_app/screens/home/prrovider/home_provider.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:provider/provider.dart';

class WebPage extends StatefulWidget {
  const WebPage({super.key});

  @override
  State<WebPage> createState() => _WebPageState();
}

class _WebPageState extends State<WebPage> {
  InAppWebViewController? webViewController;
  PullToRefreshController? pullToRefreshController;

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
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final read = context.read<HomeProvider>();
    final watch = context.watch<HomeProvider>();
    final arguments = ModalRoute.of(context)!.settings.arguments;

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
            onPressed: () => Navigator.pop(context),
            icon: const Icon(Icons.arrow_back_ios_new)),
        title: const Text("Bookmark"),
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
      body: Column(
        children: [
          LinearProgressIndicator(
            value: watch.progress,
          ),
          Expanded(
            child: InAppWebView(
              pullToRefreshController: pullToRefreshController,
              onProgressChanged: (controller, progress) {
                read.changeProgress(progress / 100);
              },
              onWebViewCreated: (controller) {
                webViewController = controller;
              },
              onLoadStop: (controller, url) {
                pullToRefreshController!.endRefreshing();
              },
              initialUrlRequest: URLRequest(
                url: WebUri('$arguments'),
              ),
            ),
          )
        ],
      ),
    );
  }
}
