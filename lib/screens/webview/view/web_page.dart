// import 'package:adhaar_app/model/web_models.dart';
// import 'package:adhaar_app/screens/home/prrovider/home_provider.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_inappwebview/flutter_inappwebview.dart';
// import 'package:provider/provider.dart';
//
// class WebPage extends StatefulWidget {
//   const WebPage({super.key});
//
//   @override
//   State<WebPage> createState() => _WebPageState();
// }
//
// class _WebPageState extends State<WebPage> {
//   InAppWebViewController? webViewController;
//
//   @override
//   Widget build(BuildContext context) {
//     final read = context.read<HomeProvider>();
//     final watch = context.watch<HomeProvider>();
//     final WebModels models =
//         ModalRoute.of(context)!.settings.arguments as WebModels;
//
//     return Scaffold(
//       appBar: AppBar(
//         title: Text("${models.title}"),
//         actions: [
//           IconButton(
//             onPressed: () async {
//               await webViewController!.goBack();
//             },
//             icon: const Icon(Icons.arrow_back_ios_new),
//           ),
//           IconButton(
//             onPressed: () async {
//               await webViewController!.goForward();
//             },
//             icon: const Icon(Icons.arrow_forward_ios),
//           ),
//         ],
//       ),
//       body: Column(
//         children: [
//           LinearProgressIndicator(
//             value: watch.progress,
//           ),
//           Expanded(
//             child: RefreshIndicator(
//               onRefresh: () async {
//                 if (webViewController != null) {
//                   await webViewController!.reload();
//                 }
//               },
//               child: SingleChildScrollView(
//                 child: SizedBox(
//                   height: MediaQuery.of(context).size.height,
//                   child: InAppWebView(
//                     onProgressChanged: (controller, progress) {
//                       read.changeProgress(progress / 100);
//                     },
//                     onWebViewCreated: (controller) {
//                       webViewController = controller;
//                     },
//                     initialUrlRequest: URLRequest(
//                       url: WebUri('${models.url}'),
//                     ),
//                   ),
//                 ),
//               ),
//             ),
//           )
//         ],
//       ),
//     );
//   }
// }
