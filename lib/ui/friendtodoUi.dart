import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'dart:async';

class FriendTodoUi extends StatefulWidget {
  final int id;

  FriendTodoUi({@required this.id});

  @override
  State<StatefulWidget> createState() {
    return FriendTodoScreen();
  }
}

class Todo {
  final int userid;
  final int id;
  final String title;
  final bool completed;

  Todo({this.userid, this.id, this.title, this.completed});

  factory Todo.fromJson(Map<String, dynamic> json) {
    return Todo(
      userid: json['userid'],
      id: json['id'],
      title: json['title'],
      completed: json['completed'],
    );
  }
}

Future<List<Todo>> getTodo(int userid) async {
  final response = await http
      .get('https://jsonplaceholder.typicode.com/todos?userId=${userid}');

  List<Todo> todolist = [];

  if (response.statusCode == 200) {
    var body = json.decode(response.body);
    for (int i = 0; i < body.length; i++) {
      todolist.add(Todo.fromJson(body[i]));
    }
    return todolist;
  } else {
    throw Exception('CAN NOT LOAD');
  }
}

Widget TodoList(BuildContext context, AsyncSnapshot snapshot) {
    List<Todo> listtodos = snapshot.data;
    return new Expanded(
      child: new ListView.builder(
        itemCount: listtodos.length,
        itemBuilder: (BuildContext context, int index) {
          return Card(
            child: new InkWell(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    "${(listtodos[index].id).toString()}",
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 24),
                  ),
                  Padding(padding: EdgeInsets.only(top: 10)),
                  Text(
                    listtodos[index].title,
                    style: TextStyle(fontSize: 16),
                  ),
                  listtodos[index].completed == true ?
                  Text(
                    "Completed",
                    style: TextStyle(fontSize: 16),
                  ):
                  Text(
                    "",
                    style: TextStyle(fontSize: 16),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

class FriendTodoScreen extends State<FriendTodoUi> {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.only(top: 40),
        child: Column(
          children: <Widget>[
            RaisedButton(
              child: Text("Back"),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
            FutureBuilder(
              future: getTodo(widget.id),
              builder: (BuildContext context, AsyncSnapshot snapshot) {
                switch (snapshot.connectionState) {
                  case ConnectionState.none:
                  case ConnectionState.waiting:
                    return new Text('loading...');
                  default:
                    if (snapshot.hasError) {
                      return new Text('Error: ${snapshot.error}');
                    } else {
                      return TodoList(context, snapshot);
                    }
                }
              },
            )
          ],
        ),
      ),
    );
  }
}
