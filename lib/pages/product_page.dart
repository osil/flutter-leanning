// ignore_for_file: file_names

import 'package:flutter/material.dart';
//import 'package:my01_app/models/product.dart';
import 'package:my01_app/widgets/menu.dart';
import 'dart:convert' as convert;
import 'package:http/http.dart' as http;

class ProductPage extends StatefulWidget {
  const ProductPage({Key? key}) : super(key: key);

  @override
  State<ProductPage> createState() => _ProductPageState();
}

class _ProductPageState extends State<ProductPage> {
  List<dynamic> course = [];
  bool isLoading = true;

  _getProduct() async {
    var url = Uri.https('api.codingthailand.com', '/api/course');
    var response = await http.get(url);
    if (response.statusCode == 200) {
      //print(response.body);
      final Map<String, dynamic> product = convert.jsonDecode(response.body);

      setState(() {
        course = product['data'];
        isLoading = false;
      });
    } else {
      setState(() {
        isLoading = false;
      });
      print("error api ${response.statusCode}");
    }
  }

  // ignore: prefer_typing_uninitialized_variables
  @override
  void initState() {
    // ignore: todo
    // TODO: implement initState
    super.initState();
    _getProduct();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: MenuItem(),
      appBar: AppBar(
        title: const Text("Course"),
      ),
      body: isLoading == true
          ? const Center(
              child: CircularProgressIndicator(),
            )
          : ListView.separated(
              itemBuilder: (BuildContext context, int index) {
                return ListTile(
                  leading: Container(
                    height: 80,
                    width: 80,
                    decoration: BoxDecoration(
                      shape: BoxShape.rectangle,
                      image: DecorationImage(
                          image: NetworkImage(course[index]['picture'])),
                    ),
                  ),
                  title: Text(course[index]['title']),
                  subtitle: Text(course[index]['detail']),
                  trailing: const Icon(Icons.arrow_right_sharp),
                  onTap: () {
                    Navigator.pushNamed(context, 'productstack/detail',
                        arguments: {
                          'id': course[index]['id'],
                          'title': course[index]['title']
                        });
                  },
                );
              },
              separatorBuilder: (BuildContext context, int index) =>
                  const Divider(),
              itemCount: course.length),
    );
  }
}
