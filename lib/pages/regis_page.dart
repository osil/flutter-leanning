import 'package:another_flushbar/flushbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:intl/intl.dart';
import 'dart:convert' as convert;
import 'package:http/http.dart' as http;

class RegisPage extends StatefulWidget {
  RegisPage({Key? key}) : super(key: key);

  @override
  _RegisPageState createState() => _RegisPageState();
}

class _RegisPageState extends State<RegisPage> {
  final _formKey = GlobalKey<FormBuilderState>();

  void _register(Map<String, dynamic> values) async {
    var url = Uri.https('api.codingthailand.com', '/api/register');
    var response = await http.post(url,
        headers: {'Content-Type': 'application/json'},
        body: convert.jsonEncode({
          'name': values['name'],
          'email': values['email'],
          'password': values['password'],
          'dob': values['dob'].toString().substring(0, 10)
        }));

    final feedback = convert.jsonDecode(response.body);
    if (response.statusCode == 201) {
      Flushbar(
        icon: Icon(
          Icons.check_box_outlined,
          size: 28.0,
          color: Colors.green[500],
        ),
        title: "${feedback['message']}",
        message:
            "ยินดีตอนรับคุณ ${feedback['data']['user']['name']} อีเมล์ ${feedback['data']['user']['email']}",
        duration: const Duration(seconds: 5),
      ).show(context);

      //กลับหน้า login
      Future.delayed(const Duration(seconds: 3), () {
        Navigator.of(context, rootNavigator: true)
                  .pushNamedAndRemoveUntil('/', (route) => false);
        
      });
    } else {
      Flushbar(
        icon: Icon(
          Icons.error_outline_outlined,
          size: 28.0,
          color: Colors.red[800],
        ),
        title: "${feedback['message']}",
        message: "เกิดข้อผิดพลาด ${feedback['errors']['email'][0]}",
        duration: const Duration(seconds: 5),
      ).show(context);
    }
  }

  @override
  Widget build(BuildContext context) {
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
      appBar: AppBar(
        title: const Text("Register"),
      ),
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
                const Text("Register Smart RMU",
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
                    // ignore: prefer_const_literals_to_create_immutables
                    initialValue: {
                      'name': '',
                      'email': '',
                      'password': '',
                    },
                    child: Column(
                      children: [
                        FormBuilderTextField(
                          //autovalidateMode: AutovalidateMode.onUserInteraction,
                          autofocus: false,
                          maxLines: 1,
                          name: 'name',
                          keyboardType: TextInputType.text,
                          decoration: const InputDecoration(
                            labelText: 'ชื่อ - สกุล',
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
                                errorText: 'กรุณากรอกชื่อ-สกุล')
                          ]),
                        ),
                        _sizebox,
                        FormBuilderTextField(
                          //autovalidateMode: AutovalidateMode.onUserInteraction,
                          autofocus: false,
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
                                errorText: 'กรุณากรอกอีเมล์'),
                            FormBuilderValidators.email(context,
                                errorText: 'รูปแบบอีเมล์ไม่ถูกต้อง')
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
                                errorText: 'กรุณากรอกรหัสผ่าน'),
                          ]),
                        ),
                        _sizebox,
                        FormBuilderDateTimePicker(
                          name: 'dob',
                          // onChanged: _onChanged,
                          inputType: InputType.date,
                          format: DateFormat("yyyy-MM-dd"),
                          decoration: const InputDecoration(
                            labelText: 'วันเกิด',
                            errorStyle: TextStyle(color: Colors.purple),
                            filled: true,
                            fillColor: Colors.white38,
                            border: OutlineInputBorder(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(9.0))),
                          ),
                          //initialTime: TimeOfDay(hour: 8, minute: 0),
                          //initialValue: DateTime.now(),
                          enabled: true,
                          validator: FormBuilderValidators.compose([
                            FormBuilderValidators.required(context,
                                errorText: 'กรุณาระบุวันที่'),
                          ]),
                        ),
                        _sizebox,
                        SizedBox(
                          width: 200,
                          height: 50,
                          child: ElevatedButton(
                              child: const Text(
                                'Register',
                                style: TextStyle(fontSize: 20),
                              ),
                              style: raisedButtonStyle,
                              onPressed: () {
                                if (_formKey.currentState!.saveAndValidate()) {
                                  //print(_formKey.currentState!.value);
                                  _register(_formKey.currentState!.value);
                                } else {
                                  print("validation failed");
                                }
                              }),
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
