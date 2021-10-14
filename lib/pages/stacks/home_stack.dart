import 'package:flutter/material.dart';
import 'package:my01_app/pages/about_page.dart';
import 'package:my01_app/pages/company_page.dart';
import 'package:my01_app/pages/homepage.dart';
import 'package:my01_app/pages/contact_page.dart';
import 'package:my01_app/pages/room_page.dart';

class HomeStack extends StatefulWidget {
  HomeStack({Key? key}) : super(key: key);

  @override
  _HomeStackState createState() => _HomeStackState();
}

class _HomeStackState extends State<HomeStack> {
  @override
  Widget build(BuildContext context) {
    return Navigator(
      initialRoute: 'homestack/home',
      onGenerateRoute: (RouteSettings settings) {
        WidgetBuilder builder;
        switch (settings.name) {
          case 'homestack/home':
            builder =
                (BuildContext context) => const HomePage(title: 'Smart RMU');
            break;
          case 'homestack/about':
            builder = (BuildContext context) => AboutPage();
            break;
          case 'homestack/contact':
            builder = (BuildContext context) => ContactPage();
            break;
          case 'homestack/company':
            builder = (BuildContext context) => CompanyPage();
            break;
          case 'homestack/room':
            builder = (BuildContext context) => RoomPage();
            break;
          default:
            throw Exception('Invalid route: ${settings.name}');
        }
        return MaterialPageRoute<void>(builder: builder, settings: settings);
      },
    );
  }
}
