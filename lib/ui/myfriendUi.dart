import 'package:flutter/material.dart';

class MyFriendUi extends StatefulWidget{
  final int id;
  final String name;
  
  MyFriendUi({Key key, @required this.id, @required this.name}) : super(key: key);
  
  @override
  State<StatefulWidget> createState() {
    
    return MyFriendScreen();
  }
}

class MyFriendScreen extends State<MyFriendUi>{
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        title: Text("My Friend"),
      ),
      body: ListView(
        children: <Widget>[
          Text(
              "${widget.id.toString()} : ${widget.name}",
              style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 24)
            ),
            RaisedButton(
              child: Text("TODOS"),
              onPressed: (){
              //   Navigator.push(
              //   context,
              //   MaterialPageRoute(
              //     builder: (context) => TodoPage(id: widget.id),
              //   ),
              // );
              },
            ),
            RaisedButton(
              child: Text("POST"),
              onPressed: (){
              //   Navigator.push(
              //   context,
              //   MaterialPageRoute(
              //     builder: (context) => PostPage(id: widget.id),
              //   ),
              // );
              },
            ),
            RaisedButton(
              child: Text("ALBUMS"),
              onPressed: (){
              //   Navigator.push(
              //   context,
              //   MaterialPageRoute(
              //     builder: (context) => AlbumPage(id: widget.id),
              //   ),
              // );
              },
            ),
            RaisedButton(
              child: Text("BACK"),
              onPressed: (){
                Navigator.pop(context);
              },
            )
        ],
      ),
      
    );
  }

}