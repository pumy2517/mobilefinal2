import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import './friendtodoUi.dart';
import 'dart:convert';
import 'dart:async';

class FriendUi extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return FriendScreen();
  }
}

Future<List<User>> fetchUsers() async {
  final response = await http.get('https://jsonplaceholder.typicode.com/users');

  List<User> userApi = [];

  if (response.statusCode == 200) {
    var body = json.decode(response.body);
    for (int i = 0; i < body.length; i++) {
      var user = User.fromJson(body[i]);
      userApi.add(user);
    }
    return userApi;
  } else {
    throw Exception('Failed to load post');
  }
}

class User {
  final int id;
  final String name;
  final String email;
  final String phone;
  final String website;

  User({this.id, this.name, this.email, this.phone, this.website});

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json['id'],
      name: json['name'],
      email: json['email'],
      phone: json['phone'],
      website: json['website'],
    );
  }
}

class FriendScreen extends State<FriendUi> {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.only(top: 40),
        child: Column(
          children: <Widget>[
            Row(
              children: <Widget>[
                Expanded(
                  flex: 1,
                  child: RaisedButton(
                    child: Text("Back"),
                    onPressed: () {
                      Navigator.pop(context);
                    },
                  ),
                ),
              ],
            ),
            FutureBuilder(
              future: fetchUsers(),
              builder: (BuildContext context, AsyncSnapshot snapshot) {
                switch (snapshot.connectionState) {
                  case ConnectionState.none:
                  case ConnectionState.waiting:
                    return new Text('Please wait data is loading');
                  default:
                    if (snapshot.hasError) {
                      return new Text('Error: ${snapshot.error}');
                    } else {
                      return FriendList(context, snapshot);
                    }
                }
              },
            )
          ],
        ),
      ),
    );
  }

  Widget FriendList(BuildContext context, AsyncSnapshot snapshot) {
    List<User> values = snapshot.data;
    return new Expanded(
      child: new ListView.builder(
        itemCount: values.length,
        itemBuilder: (BuildContext context, int index) {
          return Card(
            child: new InkWell(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    "${(values[index].id).toString()} : ${values[index].name}",
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 24),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 10),
                    child: Text(
                      values[index].email,
                      style: TextStyle(fontSize: 16),
                    ),
                  ),
                  Text(
                    values[index].phone,
                    style: TextStyle(fontSize: 16),
                  ),
                  Text(
                    values[index].website,
                    style: TextStyle(fontSize: 16),
                  ),
                ],
              ),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => FriendTodoUi(
                        id: values[index].id, name: values[index].name),
                  ),
                );
              },
            ),
          );
        },
      ),
    );
  }
}
