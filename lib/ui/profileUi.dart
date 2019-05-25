import 'package:flutter/material.dart';
import '../model/share.dart';
import '../model/userDB.dart';
import './homeUi.dart';
import '../model/fileio.dart';

class ProfileUi extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return ProfileScreen();
  }
}

class ProfileScreen extends State<ProfileUi> {
  final _formKey = GlobalKey<FormState>();
  TodoProvider userdb = TodoProvider();
  static String quote;
  static Account _account;
  TextEditingController username = TextEditingController();
  TextEditingController password = TextEditingController();
  TextEditingController name = TextEditingController();
  TextEditingController age = TextEditingController();
  TextEditingController quotefield = TextEditingController();

  bool isNumeric(String s) {
    if (s == null) {
      return false;
    }
    return double.parse(s, (e) => null) != null;
  }

  int countSpace(String s) {
    int result = 0;
    for (int i = 0; i < s.length; i++) {
      if (s[i] == ' ') {
        result += 1;
      }
    }
    return result;
  }

  void initState() {
    super.initState();
    this.userdb.open();
    print("testfuckyou");
    FileIo filedata = FileIo();
    SharedPreferencesUtil.loadLastId().then((value) async {
      await userdb.open();
      await userdb.getAccount(int.parse(value)).then((values) {
        setState(() {
          _account = values;
          username.text = _account.userid;
          password.text = _account.password;
          name.text = _account.name;
          age.text = _account.age.toString();
        });
      });
    });
    filedata.readCounter().then((value){
      setState(() {
        ProfileScreen.quote = value;
        quotefield.text = quote;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Form(
            key: _formKey,
            child: ListView(
              children: <Widget>[
                TextFormField(
                    controller: username,
                    decoration: InputDecoration(
                      border: new OutlineInputBorder(
                          borderSide: new BorderSide(color: Colors.black)),
                      labelText: "UserId",
                    ),
                    validator: (value) {
                      if (value.isEmpty) {
                        return "Please fill out this form";
                      } else if (value.length < 6 || value.length > 12) {
                        return "User Id length must between 6 - 12";
                      }
                    }),
                SizedBox(
                  height: 10,
                ),
                TextFormField(
                    controller: name,
                    decoration: InputDecoration(
                      border: new OutlineInputBorder(
                          borderSide: new BorderSide(color: Colors.black)),
                      labelText: "Name",
                    ),
                    validator: (value) {
                      if (value.isEmpty) {
                        return "Please fill out this form";
                      }
                      if (countSpace(value) != 1) {
                        return "Please fill Name Correctly";
                      }
                    }),
                SizedBox(
                  height: 10,
                ),
                TextFormField(
                    controller: age,
                    decoration: InputDecoration(
                      border: new OutlineInputBorder(
                          borderSide: new BorderSide(color: Colors.black)),
                      labelText: "Age",
                    ),
                    validator: (value) {
                      if (value.isEmpty) {
                        return "Please fill Age";
                      } else if (!isNumeric(value) ||
                          int.parse(value) < 10 ||
                          int.parse(value) > 80) {
                        return "Age must Between 10 to 80";
                      }
                    }),
                SizedBox(
                  height: 10,
                ),
                TextFormField(
                    controller: password,
                    obscureText: true,
                    decoration: InputDecoration(
                      border: new OutlineInputBorder(
                          borderSide: new BorderSide(color: Colors.black)),
                      labelText: "Password",
                    ),
                    validator: (value) {
                      if (value.isEmpty || value.length <= 6) {
                        return "Password must longer than 6";
                      }
                    }),
                SizedBox(
                  height: 10,
                ),
                TextFormField(
                  controller: quotefield,
                  decoration: InputDecoration(
                    border: new OutlineInputBorder(
                        borderSide: new BorderSide(color: Colors.black)),
                    labelText: "Quote",
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                Row(
                  children: <Widget>[
                    Expanded(
                      flex: 1,
                      child: RaisedButton(
                        child: Text("SAVE"),
                        onPressed: () async {
                          if (_formKey.currentState.validate()) {
                            await userdb.open();
                            await userdb.update(Account(
                                id: _account.id,
                                userid: username.text,
                                name: name.text,
                                age: int.parse(age.text),
                                password: password.text));

                            _account.userid = username.text;
                            _account.name = name.text;
                            _account.age = int.parse(age.text);
                            _account.password = password.text;
                            SharedPreferencesUtil.saveName(name.text);
                            FileIo filedata = FileIo();
                            await filedata.writeCounter(quotefield.text);
                            Navigator.pushReplacement(
                              context,
                              new MaterialPageRoute(
                                  builder: (context) => HomeUi(_account)),
                            );
                          }
                        },
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ));
  }
}
