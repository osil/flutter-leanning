import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';

class LoginPage extends StatefulWidget {
  LoginPage({Key? key}) : super(key: key);

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _formKey = GlobalKey<FormBuilderState>();
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
      padding: EdgeInsets.all(12),
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(9.0)),
      ),
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
                          autovalidateMode: AutovalidateMode.always,
                          autofocus: true,
                          maxLines: 1,
                          name: 'email',
                          keyboardType: TextInputType.emailAddress,
                          decoration: const InputDecoration(
                            labelText: 'Email',
                            icon: Icon(Icons.email),
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
                        const SizedBox(
                          height: 20,
                        ),
                        FormBuilderTextField(
                          autofocus: false,
                          maxLines: 1,
                          obscureText: true,
                          name: 'password',
                          keyboardType: TextInputType.visiblePassword,
                          decoration: const InputDecoration(
                            labelText: 'Password',
                            icon: Icon(Icons.password),
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
                        const SizedBox(
                          height: 20,
                        ),
                        SizedBox(
                          width: 200,
                          height: 50,
                          child: ElevatedButton(
                              child: const Text(
                                'Login',
                                style: TextStyle(fontSize: 20),
                              ),
                              style: raisedButtonStyle,
                              onPressed: () {}),
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
