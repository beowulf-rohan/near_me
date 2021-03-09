import 'package:flutter/material.dart';
import 'package:near_me/Auth/login.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HomeScreen extends StatefulWidget {
  static const String id = 'HomeScreen';
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [Color(0xff000428), Color(0xff004e92)]),
          ),
          child: ListView(
            scrollDirection: Axis.vertical,
            children: <Widget>[
              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: <Widget>[
                  FlatButton(
                    child: Icon(Icons.logout),
                    onPressed: () async {
                      SharedPreferences sharedPreference =
                      await SharedPreferences.getInstance();
                      sharedPreference.remove('email');
                      Navigator.pushReplacement(context,
                          MaterialPageRoute(builder: (BuildContext context) => Login()));
                    },
                  ),
                ],
              )
            ],
          )
        ),
      ),
    );
  }
}
