// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'package:my01_app/widgets/menu.dart';

class ProductPage extends StatefulWidget {
  const ProductPage({Key? key}) : super(key: key);

  @override
  State<ProductPage> createState() => _ProductPageState();
}

class _ProductPageState extends State<ProductPage> {
  // ignore: prefer_typing_uninitialized_variables
  var formAboutPage;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: MenuItem(),
      appBar: AppBar(
        title: const Text("สินค้า"),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[const Text("สินค้า")],
        ),
      ),
    );
  }
}
