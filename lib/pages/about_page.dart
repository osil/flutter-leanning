import 'package:flutter/material.dart';

class AboutPage extends StatefulWidget {
  AboutPage({Key? key}) : super(key: key);

  @override
  _AboutPageState createState() => _AboutPageState();
}

class _AboutPageState extends State<AboutPage> {
  @override
  Widget build(BuildContext context) {
    final arguments = ModalRoute.of(context)!.settings.arguments as Map;

    return Scaffold(
      appBar: AppBar(
        title: const Text("About Page"),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Text("About Page"),
            const SizedBox(height: 30),
            Text(arguments['email']),
            Text(arguments['phone']),
            ElevatedButton(
                onPressed: () {
                  Navigator.pop(context, 'Sent BY About Page');
                },
                child: const Text("Home")),
            ElevatedButton(
                onPressed: () {
                  Navigator.pushNamed(context, 'homestack/contact');
                },
                child: const Text("Contact Page"))
          ],
        ),
      ),
    );
  }
}

class ModelRoute {
  static of(BuildContext context) {}
}
