import 'package:flutter/material.dart';

class Footer extends StatefulWidget {
  const Footer({Key? key}) : super(key: key);

  @override
  _FooterState createState() => _FooterState();
}

class _FooterState extends State<Footer> {
  String companyName = "Smart RMU";

  void _changeCompanyName() {
    setState(() {
      companyName = "RMU";
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Text(companyName),
        ElevatedButton(
            onPressed: _changeCompanyName, child: const Text('Click Me!'))
      ],
    );
  }
}
