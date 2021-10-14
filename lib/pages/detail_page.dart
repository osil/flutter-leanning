import 'package:flutter/material.dart';
import 'dart:convert' as convert;
import 'package:http/http.dart' as http;
//import 'package:my01_app/models/detail_product.dart';
import 'package:intl/intl.dart';

class DetailPage extends StatefulWidget {
  DetailPage({Key? key}) : super(key: key);

  @override
  _DetailPageState createState() => _DetailPageState();
}

class _DetailPageState extends State<DetailPage> {
  // ignore: prefer_typing_uninitialized_variables
  var course;
  List<dynamic> chapter = [];
  bool isLoading = true;
  final fNumber = NumberFormat("#,###");

  _getProduct(int id) async {
    var url = Uri.https('api.codingthailand.com', '/api/course/$id');
    var response = await http.get(url);
    if (response.statusCode == 200) {
      //print(response.body);
      Map<String, dynamic> detail = convert.jsonDecode(response.body);

      setState(() {
        chapter = detail['data'];
        isLoading = false;
      });
    } else {
      setState(() {
        isLoading = false;
      });
      // ignore: avoid_print
      print("error api ${response.statusCode}");
    }
  }

  @override
  void initState() {
    // ignore: todo
    // TODO: implement initState
    super.initState();
    // delaye init state
    Future.delayed(Duration.zero, () {
      _getProduct(course['id']);
    });
  }

  @override
  Widget build(BuildContext context) {
    course = ModalRoute.of(context)!.settings.arguments as Map;

    return Scaffold(
      appBar: AppBar(
        title: Text(course['title']),
      ),
      body: isLoading == true
          ? const Center(
              child: CircularProgressIndicator(),
            )
          : ListView.separated(
              itemBuilder: (BuildContext context, int index) {
                return ListTile(
                  title: Text(chapter[index]['ch_title']),
                  subtitle: Text(chapter[index]['ch_dateadd'].toString()),
                  trailing: Chip(
                    avatar: const Icon(Icons.remove_red_eye_outlined),
                    label: Text(fNumber.format(chapter[index]['ch_view'])),
                    backgroundColor: Colors.purpleAccent,
                  ),
                );
              },
              separatorBuilder: (BuildContext context, int index) =>
                  const Divider(),
              itemCount: chapter.length),
    );
  }
}

class ModelRoute {
  static of(BuildContext context) {}
}
