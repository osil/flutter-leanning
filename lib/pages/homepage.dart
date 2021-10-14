// ignore_for_file: file_names

import 'package:flutter/material.dart';
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
        body: Container(
            decoration: const BoxDecoration(
                image: DecorationImage(
                    image: AssetImage('assets/images/bg.jpeg'),
                    fit: BoxFit.cover)),
            child: GridView.count(
              primary: false,
              padding: const EdgeInsets.all(20),
              crossAxisSpacing: 10,
              mainAxisSpacing: 10,
              crossAxisCount: 2,
              children: <Widget>[
                GestureDetector(
                  onTap: () {
                    Navigator.pushNamed(context, 'homestack/company');
                  },
                  child: Container(
                    padding: const EdgeInsets.all(8),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: const <Widget>[
                        Icon(Icons.business, size: 80, color: Colors.purple),
                        Text(
                          'มรม.',
                          style: TextStyle(fontSize: 20),
                        ),
                      ],
                    ),
                    color: Colors.white70,
                  ),
                ),
                Container(
                  padding: const EdgeInsets.all(8),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: const <Widget>[
                      Icon(Icons.map, size: 80, color: Colors.purple),
                      Text(
                        'แผนที่',
                        style: TextStyle(fontSize: 20),
                      ),
                    ],
                  ),
                  color: Colors.white70,
                ),
                Container(
                  padding: const EdgeInsets.all(8),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: const <Widget>[
                      Icon(Icons.camera_alt, size: 80, color: Colors.purple),
                      Text(
                        'กล้อง',
                        style: TextStyle(fontSize: 20),
                      ),
                    ],
                  ),
                  color: Colors.white70,
                ),
                GestureDetector(
                  onTap: () async {
                    formAboutPage = await Navigator.pushNamed(
                        context, 'homestack/about', arguments: {
                      'email': 'tttt@fmail.com',
                      'phone': '08888888'
                    });
                    setState(() {
                      formAboutPage = formAboutPage;
                    });
                  },
                  child: Container(
                    padding: const EdgeInsets.all(8),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        const Icon(Icons.person_pin,
                            size: 80, color: Colors.purple),
                        Text("เกี่ยวกับ ${formAboutPage ?? ""}",
                            textAlign: TextAlign.center,
                            style: const TextStyle(fontSize: 20))
                      ],
                    ),
                    color: Colors.white70,
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    Navigator.pushNamed(context, 'homestack/room');
                  },
                  child: Container(
                    padding: const EdgeInsets.all(8),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: const <Widget>[
                        Icon(Icons.room_preferences_sharp, size: 80, color: Colors.purple),
                        Text(
                          'ห้องประชุม',
                          style: TextStyle(fontSize: 20),
                        ),
                      ],
                    ),
                    color: Colors.white70,
                  ),
                ),
              ],
            )));
  }
}
