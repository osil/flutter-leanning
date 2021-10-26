import 'package:flutter/material.dart';
import 'package:my01_app/pages/login_page.dart';
import 'package:my01_app/pages/regis_page.dart';
import 'package:my01_app/pages/stacks/home_stack.dart';
import 'package:my01_app/pages/stacks/new_stack.dart';
import 'package:my01_app/pages/stacks/product_stack.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.purple,
        //brightness: Brightness.light,
        //primaryColor: Colors.blueGrey
      ),
      // home: const HomePage(title: 'Smart RMU'),
      initialRoute: '/',
      routes: {
        //'/': (context) => HomeStack(),
        '/': (context) => LoginPage(),
        '/regis': (context) => RegisPage(),
        '/homestack': (context) => HomeStack(),
        '/productstack': (context) => ProductStack(),
        '/newstack': (context) => NewStack()

      },
      debugShowCheckedModeBanner: false,
    );
  }
}
