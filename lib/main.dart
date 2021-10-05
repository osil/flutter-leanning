import 'package:flutter/material.dart';
import 'package:my01_app/pages/stacks/home_stack.dart';
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
      ),
      // home: const HomePage(title: 'Smart RMU'),
      initialRoute: '/',
      routes: {
        '/': (context) => HomeStack(),
        '/productstack': (context) => ProductStack()
      },
      debugShowCheckedModeBanner: false,
    );
  }
}
