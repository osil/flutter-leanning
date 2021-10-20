import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

class WebViewPage extends StatefulWidget {
  WebViewPage({Key? key}) : super(key: key);

  @override
  _WebViewPageState createState() => _WebViewPageState();
}

class _WebViewPageState extends State<WebViewPage> {
  @override
  Widget build(BuildContext context) {

    final news = ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>;

    return Scaffold(
      appBar: AppBar(title: Text(news['name'])),
      body: WebView(
          initialUrl: news['url'],
          javascriptMode: JavascriptMode.unrestricted,
          onProgress: (int progress) {
            //print("WebView is loading (progress : $progress%)");
          },
          onPageStarted: (String url) {
            //print('Page started loading: $url');
          },
          onPageFinished: (String url) {
            //print('Page finished loading: $url');
          },
          gestureNavigationEnabled: false,
      ),
    );
  }
}
