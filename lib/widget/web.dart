import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

class WebRoute extends StatefulWidget {
  @override
  _WebRouteState createState() => _WebRouteState();
}

class _WebRouteState extends State<WebRoute> {

  static const String htmlString = '''
<!DOCTYPE html><html>
<head><title>Navigation Delegate Example</title></head>
<body>
<p>
The navigation delegate is set to block navigation to the youtube website.
</p>
<ul>
<ul><a href="https://www.youtube.com/">https://www.youtube.com/</a></ul>
<ul><a href="https://www.google.com/">https://www.google.com/</a></ul>
</ul>
</body>
</html>
''';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('浏览器'),
      ),
      body: WebView(
        initialUrl: 'https://flutterchina.club',
//        initialUrl:
//            'data:text/html;base64,${base64Encode(const Utf8Encoder().convert(htmlString))}',
        javascriptMode: JavascriptMode.unrestricted,
//        onWebViewCreated: (WebViewController webViewController) {
//          _controller.complete(webViewController);
//        },
//        javascriptChannels: <JavascriptChannel>[
//          _toasterJavascriptChannel(context),
//        ].toSet(),
      ),
    );
  }

  JavascriptChannel _toasterJavascriptChannel(BuildContext context) {
    return JavascriptChannel(
        name: 'Toaster',
        onMessageReceived: (JavascriptMessage message) {
          Scaffold.of(context).showSnackBar(
            SnackBar(content: Text(message.message)),
          );
        });
  }
}
