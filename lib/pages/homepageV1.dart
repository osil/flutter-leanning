// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'package:my01_app/widgets/logo.dart';
import 'package:my01_app/widgets/menu.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  // ignore: prefer_typing_uninitialized_variables
  var formAboutPage;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: MenuItem(),
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Logo(),
            const Text("Smart RMU"),
            Text("Form About Page Is ${formAboutPage ?? ""}"),
            ElevatedButton(
              child: const Text("About"),
              onPressed: () async {
                formAboutPage = await Navigator.pushNamed(
                    context, 'homestack/about', arguments: {
                  'email': 'tttt@fmail.com',
                  'phone': '08888888'
                });
                setState(() {
                  formAboutPage = formAboutPage;
                });
              },
            )
          ],
        ),
      ),
    );
  }
}
