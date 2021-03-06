import 'package:flutter/material.dart';
import 'package:my01_app/pages/news_page.dart';
import 'package:my01_app/pages/web_view_page.dart';

class NewStack extends StatefulWidget {
  NewStack({Key? key}) : super(key: key);

  @override
  _NewStackState createState() => _NewStackState();
}

class _NewStackState extends State<NewStack> {
  @override
  Widget build(BuildContext context) {
    return Navigator(
      initialRoute: 'newstack/news',
      onGenerateRoute: (RouteSettings settings) {
        WidgetBuilder builder;
        switch (settings.name) {
          case 'newstack/news':
            builder = (BuildContext context) => NewsPage();
            break;
          case 'newstack/webview':
            builder = (BuildContext context) => WebViewPage();
            break;

          default:
            throw Exception('Invalid route: ${settings.name}');
        }
        return MaterialPageRoute<void>(builder: builder, settings: settings);
      },
    );
  }
}
