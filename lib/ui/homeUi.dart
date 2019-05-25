import 'package:flutter/material.dart';
import '../model/userDB.dart';
import '../model/share.dart';
import './profileUi.dart';
import '../model/fileio.dart';


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
  String name;

  void initState() {
    super.initState();
    FileIo filedata = FileIo();
    filedata.readCounter().then((value){
      setState(() {
        quote = value;
      });
    });
    SharedPreferencesUtil.loadName().then((value){
      setState(() {
        name = value; 
      });
    });
    print("test");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        padding: EdgeInsets.fromLTRB(20, 40, 20, 0),
        children: <Widget>[
          ListTile(
            title: Text("Hello ${this.name}"),
            subtitle: Text('This is my quote "${this.quote}" '),
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
            child: Text("MY FRIEND"),
            onPressed: () {
              Navigator.pushNamed(context, "/friend");
            },
          ),
          RaisedButton(
            child: Text("SIGN OUT"),
            onPressed: () {
              SharedPreferencesUtil.saveLastLogin(null);
              SharedPreferencesUtil.saveID(null);
              SharedPreferencesUtil.saveName(null);
              Navigator.pushReplacementNamed(context, "/");
            },
          ),
        ],
      ),
    );
  }
}
