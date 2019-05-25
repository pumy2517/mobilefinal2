import 'package:flutter/material.dart';
import './ui/registerUi.dart';
import './ui/loginUi.dart';
import './ui/profileUi.dart';
import './ui/friendUi.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'MobileFinal2_60070067',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      initialRoute: "/",
      routes: {
        "/": (context) => LoginUi(),
        "/register": (context) => RegisterPage(),
        "/profile": (context) => ProfileUi(),
        "/friend": (context) => FriendUi(),
      },
    );
  }
}