import 'dart:io';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:toast/toast.dart';
import '../model/share.dart';
import '../model/userDB.dart';
import './homeUi.dart';
import './registerUi.dart';

class LoginUi extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return LoginScreen();
  }
}

class LoginScreen extends State<LoginUi> {
  TodoProvider userdb = TodoProvider();
  final _formKey = GlobalKey<FormState>();
  final TextEditingController userid = TextEditingController();
  final TextEditingController password = TextEditingController();

  void initState() {
    super.initState();
    this.userdb.open();
    SharedPreferencesUtil.saveLastLogin(null);
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Form(
          key: _formKey,
          child: Padding(
            padding: const EdgeInsets.all(15.0),
            child: ListView(
              children: <Widget>[
                Image.asset(
                  "images/test.JPG",
                  height: 180,
                ),
                TextFormField(
                  decoration: InputDecoration(
                    labelText: "User ID",
                    prefixIcon: Icon(Icons.account_box),
                  ),
                  controller: userid,
                  keyboardType: TextInputType.text,
                  validator: (value) {
                    if (value.isEmpty) {
                      return "Please fill out this form";
                    }
                  },
                ),
                TextFormField(
                  decoration: InputDecoration(
                      labelText: "Password", 
                      prefixIcon: Icon(Icons.lock)),
                  controller: password,
                  obscureText: true,
                  keyboardType: TextInputType.text,
                  validator: (value) {
                    if (value.isEmpty) {
                      return "Please fill out this form";
                    }
                  },
                ),
                SizedBox(
                  height: 20,
                ),
                RaisedButton(
                  child: Text("LOGIN"),
                  onPressed: () async {
                    if (_formKey.currentState.validate()) {
                      await userdb.open();
                      userdb.getAccountByUserId(userid.text).then((account) {
                        if (account == null ||
                            password.text != account.password) {
                          print("LOGIN FAIL");
                          Toast.show("Invalid user or password", context);
                        } else {
                          print("LOFIN PASS");
                          SharedPreferencesUtil.saveLastLogin(userid.text);
                          SharedPreferencesUtil.saveID(account.id.toString());
                          SharedPreferencesUtil.saveName(account.name);
                          Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                                builder: (context) => HomeUi(account)),
                          );
                        }
                      });
                    }
                  },
                ),
                Container(
                  child: FlatButton(
                    child: Text("Register New Account"),
                    onPressed: () {
                      Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                                builder: (context) => RegisterPage()),
                          );
                    },
                  ),
                  alignment: Alignment.topRight,
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
