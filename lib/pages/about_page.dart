import 'package:flutter/material.dart';
import 'dart:convert' as convert;
import 'package:http/http.dart' as http;

class AboutPage extends StatefulWidget {
  AboutPage({Key? key}) : super(key: key);

  @override
  _AboutPageState createState() => _AboutPageState();
}

class _AboutPageState extends State<AboutPage> {
  Future<Map<String, dynamic>> _getData() async {
    var url = Uri.https('api.codingthailand.com', '/api/version');
    var response = await http.get(url);
    if (response.statusCode == 200) {
      //print(response.body);
      final Map<String, dynamic> version = convert.jsonDecode(response.body);
      return version;
    } else {
      throw Exception("Failed to load version ${response.statusCode}");
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _getData();
  }

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
            FutureBuilder<Map<String, dynamic>>(
              future: _getData(),
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  return Text(snapshot.data!['data']['version']);
                } else if (snapshot.hasError) {
                  return Text('${snapshot.error}');
                }

                // By default, show a loading spinner.
                return const CircularProgressIndicator();
              },
            ),
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
