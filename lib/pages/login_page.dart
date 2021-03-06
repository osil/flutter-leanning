import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'dart:convert' as convert;
import 'package:http/http.dart' as http;

class LoginPage extends StatefulWidget {
  LoginPage({Key? key}) : super(key: key);

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _formKey = GlobalKey<FormBuilderState>();
  void _checkLogin(Map<String, dynamic> values) async {
    try {
      var url = Uri.https('api.codingthailand.com', '/api/login');
      var response = await http.post(url,
          headers: {'Content-Type': 'application/json'},
          body: convert.jsonEncode(
              {'email': values['email'], 'password': values['password']}));
      if (response.statusCode == 200) {
        print(response.body);
      } else {
        print(response.body);
      }
    } catch (e) {
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    final logo = Hero(
      tag: 'hero',
      child: CircleAvatar(
        backgroundColor: Colors.transparent,
        radius: 68.0,
        child: Image.asset('assets/images/rmu.png'),
      ),
    );

    final ButtonStyle raisedButtonStyle = ElevatedButton.styleFrom(
      //onPrimary: Colors.lightGreenAccent,
      //primary: Colors.lightGreenAccent,
      //minimumSize: Size(88, 36),
      padding: const EdgeInsets.all(12),
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(9.0)),
      ),
    );

    // ignore: prefer_const_constructors
    final _sizebox = SizedBox(
      height: 20,
    );

    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
              image: AssetImage('assets/images/bg.jpeg'), fit: BoxFit.cover),
        ),
        child: Center(
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(20),
            child: Column(
              children: [
                logo,
                _sizebox,
                const Text("SMART RMU",
                    style: TextStyle(
                        fontSize: 20,
                        color: Colors.black,
                        fontWeight: FontWeight.w500)),
                _sizebox,
                Padding(
                  padding: const EdgeInsets.all(8),
                  child: FormBuilder(
                    key: _formKey,
                    //autovalidateMode: AutovalidateMode.always,
                    initialValue: {
                      'email': '',
                      'password': '',
                    },
                    child: Column(
                      children: [
                        FormBuilderTextField(
                          autovalidateMode: AutovalidateMode.onUserInteraction,
                          autofocus: true,
                          maxLines: 1,
                          name: 'email',
                          keyboardType: TextInputType.emailAddress,
                          decoration: const InputDecoration(
                            labelText: 'Email',
                            //icon: Icon(Icons.email),
                            errorStyle: TextStyle(color: Colors.purple),
                            filled: true,
                            fillColor: Colors.white38,
                            border: OutlineInputBorder(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(9.0))),
                          ),
                          validator: FormBuilderValidators.compose([
                            FormBuilderValidators.required(context,
                                errorText: '?????????????????????????????????????????????'),
                            FormBuilderValidators.email(context,
                                errorText: '??????????????????????????????????????????????????????????????????')
                          ]),
                        ),
                        _sizebox,
                        FormBuilderTextField(
                          autofocus: false,
                          maxLines: 1,
                          obscureText: true,
                          name: 'password',
                          keyboardType: TextInputType.visiblePassword,
                          decoration: const InputDecoration(
                            labelText: 'Password',
                            //icon: Icon(Icons.password),
                            errorStyle: TextStyle(color: Colors.purple),
                            filled: true,
                            fillColor: Colors.white38,
                            border: OutlineInputBorder(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(9.0))),
                          ),
                          validator: FormBuilderValidators.compose([
                            FormBuilderValidators.required(context,
                                errorText: '???????????????????????????????????????????????????'),
                          ]),
                        ),
                        _sizebox,
                        SizedBox(
                          width: 200,
                          height: 50,
                          child: ElevatedButton(
                              child: const Text(
                                'Login',
                                style: TextStyle(fontSize: 20),
                              ),
                              style: raisedButtonStyle,
                              onPressed: () {
                                if (_formKey.currentState!.saveAndValidate()) {
                                  //print(_formKey.currentState!.value);
                                  _checkLogin(_formKey.currentState!.value);
                                } else {
                                  print("validation failed");
                                }
                              }),
                        ),
                        _sizebox,
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: <Widget>[
                            Expanded(
                              child: MaterialButton(
                                child: const Text(
                                  '?????????????????????????????????',
                                  style: TextStyle(color: Colors.black87),
                                ),
                                onPressed: () {
                                  Navigator.pushNamed(context, '/regis');
                                },
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
