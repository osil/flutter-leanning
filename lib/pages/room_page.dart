import 'package:flutter/material.dart';
import 'dart:convert' as convert;
import 'package:http/http.dart' as http;

class RoomPage extends StatefulWidget {
  RoomPage({Key? key}) : super(key: key);

  @override
  _RoomPageState createState() => _RoomPageState();
}

class _RoomPageState extends State<RoomPage> {
  List<dynamic> rooms = [];
  bool isLoading = true;
  _getData() async {
    var url = Uri.https('codingthailand.com', '/api/get_rooms.php');
    var response = await http.get(url);
    if (response.statusCode == 200) {
      //print(response.body);
      final List<dynamic> room = convert.jsonDecode(response.body);

      setState(() {
        rooms = room;
        isLoading = false;
      });
    } else {
      print("error api ${response.statusCode}");
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
    return Scaffold(
      appBar: AppBar(
        title: const Text("ห้องประชุม"),
      ),
      body: isLoading == true
          ? const Center(
              child: CircularProgressIndicator(),
            )
          : ListView.separated(
              itemBuilder: (BuildContext context, int index) {
                return ListTile(
                  title: Text(rooms[index]['name']),
                  subtitle: Text(rooms[index]['id']),
                );
              },
              separatorBuilder: (BuildContext context, int index) =>
                  const Divider(),
              itemCount: rooms.length),
    );
  }
}
