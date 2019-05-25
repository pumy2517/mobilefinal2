import 'package:flutter/material.dart';
import '../model/userDB.dart';
import '../model/share.dart';
import './profileUi.dart';



class HomeUi extends StatefulWidget {
  final Account _account;
  HomeUi(this._account);

  @override
  State<StatefulWidget> createState() {
    return HomeScreen();
  }
}

class HomeScreen extends State<HomeUi> {
  String quote;

  void initState() {
    super.initState();
    SharedPreferencesUtil.loadQuote().then((value) {
      setState(() {
        this.quote = value;
      });
    });
    print("test");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(
      //   title: Text('HomePAGE'),
      // ),
      body: ListView(
        padding: EdgeInsets.fromLTRB(20, 40, 20, 0),
        children: <Widget>[
          ListTile(
            title: Text("Hello ${widget._account.name}"),
            subtitle: Text("This is my quote ${this.quote} "),
          ),
          RaisedButton(
            child: Text("PROFILE SETUP"),
            onPressed: () {
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (context) => ProfileUi()),
              );
            },
          ),
          RaisedButton(
            child: Text("FRIEND"),
            onPressed: () {
              Navigator.pushNamed(context, "/friend");
            },
          ),
          RaisedButton(
            child: Text("LOGOUT"),
            onPressed: () {
              SharedPreferencesUtil.saveLastLogin(null);
              SharedPreferencesUtil.saveQuote(null);
              Navigator.pushReplacementNamed(context, "/");
            },
          ),
        ],
      ),
    );
  }
}
