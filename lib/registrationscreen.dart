import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:fluttertoast/fluttertoast.dart';
import 'package:myhomestay_raya/models/user.dart';


import 'shared/config.dart';

class RegistrationScreen extends StatefulWidget {
  const RegistrationScreen({super.key, required User user});

  @override
  State<RegistrationScreen> createState() => _RegistrationScreenState();
}

class _RegistrationScreenState extends State<RegistrationScreen> {
  @override
  void initState() {
    super.initState();
  }

  final TextEditingController _nameEditingController = TextEditingController();
  final TextEditingController _emailEditingController = TextEditingController();
  final TextEditingController _phoneEditingController = TextEditingController();
  final TextEditingController _passEditingController = TextEditingController();
  final TextEditingController _repassEditingController =
      TextEditingController();

  bool _isChecked = false;
  bool _passwordVisible = false;
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: const Text("Registration Form")),
        body: Center(
          child: SingleChildScrollView(
            child: Card(
              elevation: 8,
              margin: EdgeInsets.all(8),
              child: Container(
                padding: EdgeInsets.all(16),
                child: Form(
                  child: Column(children: [
                    TextFormField(
                        controller: _nameEditingController,
                        keyboardType: TextInputType.text,
                        validator: (val) => val!.isEmpty || (val.length < 3)
                            ? "name must be longer than 3"
                            : null,
                        decoration: const InputDecoration(
                            labelText: 'Name',
                            labelStyle: TextStyle(),
                            icon: Icon(Icons.person),
                            focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(width: 2.0),
                            ))),
                    TextFormField(
                        controller: _emailEditingController,
                        keyboardType: TextInputType.emailAddress,
                        validator: (val) => val!.isEmpty ||
                                !val.contains("@") ||
                                val.contains(".")
                            ? "enter a valid email"
                            : null,
                        decoration: const InputDecoration(
                            labelText: 'Email',
                            labelStyle: TextStyle(),
                            icon: Icon(Icons.email),
                            focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(width: 1.0),
                            ))),
                    TextFormField(
                        controller: _phoneEditingController,
                      validator: (val) => val!.isEmpty || (val.length < 15)
                          ?"Please enter valid phone number"
                          : null,
                        keyboardType: TextInputType.phone,
                        decoration: const InputDecoration(
                            labelText: 'Phone',
                            labelStyle: TextStyle(),
                            icon: Icon(Icons.phone),
                            focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(width: 2.0),
                            ))),
                    TextFormField(
                      controller: _passEditingController,
                        keyboardType: TextInputType.visiblePassword,
                        validator: (val) => validatePassword(val.toString()),
                        obscureText: _passwordVisible,
                        decoration: InputDecoration(
                          labelText: 'Password',
                          labelStyle: const TextStyle(),
                          icon: Icon(Icons.password),
                          focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(width: 2.0),
                          ),
                          suffixIcon: IconButton(
                            icon: Icon(
                              _passwordVisible
                                  ? Icons.visibility
                                  : Icons.visibility_off,
                            ),
                            onPressed: () {
                              setState(() {
                                _passwordVisible = !_passwordVisible;
                              });
                            },
                          ),
                        )),
                    TextFormField(
                       controller: _repassEditingController,
                        keyboardType: TextInputType.visiblePassword,
                        obscureText: _passwordVisible,
                        decoration: InputDecoration(
                          labelText: 'Re-Password',
                          labelStyle: TextStyle(),
                          icon: Icon(Icons.password),
                          focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(width: 2.0),
                          ),
                          suffixIcon: IconButton(
                            icon: Icon(
                              _passwordVisible
                                  ? Icons.visibility
                                  : Icons.visibility_off,
                            ),
                            onPressed: () {
                              setState(() {
                                _passwordVisible = !_passwordVisible;
                              });
                            },
                          ),
                        )),
                    const SizedBox(
                      height: 8,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Checkbox(
                          value: _isChecked,
                          onChanged: (bool? value) {
                            setState(() {
                              _isChecked = value!;
                            });
                          },
                        ),
                        Flexible(
                          child: GestureDetector(
                            
                            child: const Text('Agree with terms',
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                )),
                          ),
                        ),
                        MaterialButton(
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(5.0)),
                          minWidth: 115,
                          height: 50,
                          elevation: 10,
                          onPressed: _registerAccountUser,
                          color: Theme.of(context).colorScheme.primary,
                          child: const Text('Register'),
                        ),
                      ],
                    ),
                  ]),
                ),
              ),
            ),
          ),
        ));
  }

  String? validatePassword(String value) {
    String pattern = r'^(?=.*?[A‐Z])(?=.*?[a‐z])(?=.*?[0‐9])(?=.*?[!@#$%^&*~]).{8,}$';
    RegExp regex = RegExp(pattern);
    if (value.isEmpty) {
      return 'Please enter password';
    } else {
      if (!regex.hasMatch(value)) {
        return 'Please follow the password rules';
      } else {
        return null;
      }
    }
  }

  void _registerAccountUser() {
    String _name = _nameEditingController.text;
    String _email = _emailEditingController.text;
    String _phone = _phoneEditingController.text;
    String _pass = _passEditingController.text;
    String _repass = _passEditingController.text;

    
    if (!_isChecked) {
      Fluttertoast.showToast(
          msg: "Please Accept Term",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 1,
          fontSize: 14.0);
      return;
    }
    if (_pass != _repass) {
      Fluttertoast.showToast(
          msg: "Please check your passsword",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 1,
          fontSize: 14.0);
      return;
    }

    //If everything good proceed with dialog
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(20.0))),
          title: const Text(
            "Register new account?",
            style: TextStyle(),
          ),
          content: const Text("Are you sure?", style: TextStyle()),
          actions: <Widget>[
            TextButton(
              child: Text(
                "Yes",
                style: TextStyle(),
              ),
              onPressed: () {
                Navigator.of(context).pop();
                _registerUser(_name, _email, _phone, _pass);
              },
            ),
            TextButton(
              child: const Text(
                "No",
                style: TextStyle(),
              ),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }
}

void _registerUser(String name, String email, String phone, String pass) {
  try {
    http.post(Uri.parse("http:// 172.20.10.11/homestayraya_db/php/register_user.php"),
     body: {
      "name": name,
      "email": email,
      "phone": phone,
      "password": pass,
      "register": "register",
    }).then((response) {
       print(response.body);
       var data = jsonDecode(response.body);
       if (response.statusCode == 200 && data['status'] == "success") {
        Fluttertoast.showToast(
            msg: "Success",
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.BOTTOM,
            timeInSecForIosWeb: 1,
            fontSize: 14.0);
        return;
      } else {
        Fluttertoast.showToast(
            msg: "Failed",
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.BOTTOM,
            timeInSecForIosWeb: 1,
            fontSize: 14.0);
        return;
      }
      

      //print(response.body);
    });
  } catch (e) {
    print(e.toString());
  }
}
