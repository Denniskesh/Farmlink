import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';

class WebChatViewPage extends StatefulWidget {
  const WebChatViewPage({super.key});

  @override
  WebChatView createState() => WebChatView();
}

class WebChatView extends State<WebChatViewPage> {
  late InAppWebViewController _webViewController;
  String url = "";
  double progress = 0;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text(''),
        ),
        body: Container(
          child: Column(children: <Widget>[
            Container(
                padding: EdgeInsets.all(10.0),
                child: progress < 1.0
                    ? LinearProgressIndicator(value: progress)
                    : Container()),
            Expanded(
              child: Container(
                margin: const EdgeInsets.all(10.0),
                decoration:
                    BoxDecoration(border: Border.all(color: Colors.blueAccent)),
                child: InAppWebView(
                  initialUrlRequest: URLRequest(
                      url: Uri.parse(
                          'https://web-chat.global.assistant.watson.appdomain.cloud/preview.html?backgroundImageURL=https%3A%2F%2Fau-syd.assistant.watson.cloud.ibm.com%2Fpublic%2Fimages%2Fupx-1fd51635-0096-4cf6-aef9-266726a665f6%3A%3Ae27eeec2-8d01-4057-9b05-27b324228d03&integrationID=a65a0d88-634f-4be5-a881-638569a01d4c&region=au-syd&serviceInstanceID=1fd51635-0096-4cf6-aef9-266726a665f6')),
                  initialOptions: InAppWebViewGroupOptions(
                      crossPlatform: InAppWebViewOptions(
                          // debuggingEnabled: true,
                          )),
                  onWebViewCreated: (InAppWebViewController controller) {
                    _webViewController = controller;
                  },
                  onLoadStart: (InAppWebViewController controller, url) async {
                    setState(() async {});
                  },
                  onLoadStop: (InAppWebViewController controller, url) async {
                    await controller.injectJavascriptFileFromAsset(
                        assetFilePath: "assets/javs.js");
                    setState(() async {});
                  },
                  onProgressChanged:
                      (InAppWebViewController controller, int progress) {
                    setState(() {
                      this.progress = progress / 100;
                    });
                  },
                ),
              ),
            ),
          ]),
        ),
      ),
    );
  }
}
