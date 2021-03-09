import 'package:flutter/material.dart';
import 'package:near_me/Screens/HomeScreen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';


class RegisterDetails extends StatefulWidget {
  static const String id = 'RegisterDetails';
  @override
  _RegisterDetailsState createState() => _RegisterDetailsState();
}


class _RegisterDetailsState extends State<RegisterDetails> {
  String name, age, city, state;
  final _firestore = FirebaseFirestore.instance;
  final _auth = FirebaseAuth.instance;
  User loggedInUser;

  void getCurrentUser() async {
    try {
      final user = _auth.currentUser;
      if (user != null) {
        loggedInUser = user;
      }
    } catch (e) {
      print(e);
    }
  }

  @override
  void initState() {
    getCurrentUser();
    super.initState();
  }

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
              SizedBox(
                height: 50,
              ),
              Container(
                child: Stack(
                  children: <Widget>[
                    Container(
                      padding: EdgeInsets.fromLTRB(15.0, 110.0, 0.0, 0.0),
                      child: Text(
                        'Details',
                        style: TextStyle(
                          fontSize: 80.0,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 5.0),
              Container(
                  padding: EdgeInsets.only(top: 35.0, left: 20.0, right: 20.0),
                  child: Column(
                    children: <Widget>[
                      TextField(
                        style: TextStyle(color: Colors.grey.shade50, fontWeight: FontWeight.bold),
                        decoration: InputDecoration(
                          labelText: 'NAME',
                          labelStyle: TextStyle(
                            fontFamily: 'Montserrat',
                            fontWeight: FontWeight.bold,
                            color: Colors.white70,
                          ),
                          focusedBorder: UnderlineInputBorder(
                            borderSide: BorderSide(color: Colors.grey),
                          ),
                        ),
                        onChanged: (value) {
                          name = value;
                        },
                      ),
                      SizedBox(height: 10.0),
                      TextField(
                        style: TextStyle(color: Colors.grey.shade50, fontWeight: FontWeight.bold),
                        decoration: InputDecoration(
                          labelText: 'AGE',
                          labelStyle: TextStyle(
                            fontFamily: 'Montserrat',
                            fontWeight: FontWeight.bold,
                            color: Colors.white70,
                          ),
                          focusedBorder: UnderlineInputBorder(
                            borderSide: BorderSide(color: Colors.grey),
                          ),
                        ),
                        onChanged: (value) {
                          age = value;
                        },
                      ),
                      SizedBox(height: 5.5),
                      TextField(
                        style: TextStyle(color: Colors.grey.shade50, fontWeight: FontWeight.bold),
                        decoration: InputDecoration(
                          labelText: 'CITY',
                          labelStyle: TextStyle(
                            fontFamily: 'Montserrat',
                            fontWeight: FontWeight.bold,
                            color: Colors.white70,
                          ),
                          focusedBorder: UnderlineInputBorder(
                            borderSide: BorderSide(color: Colors.grey),
                          ),
                        ),
                        onChanged: (value) {
                          city = value;
                        },
                      ),
                      SizedBox(height: 10.0),
                      TextField(
                        style: TextStyle(color: Colors.grey.shade50, fontWeight: FontWeight.bold),
                        decoration: InputDecoration(
                          labelText: 'STATE',
                          labelStyle: TextStyle(
                            fontFamily: 'Montserrat',
                            fontWeight: FontWeight.bold,
                            color: Colors.white70,
                          ),
                          focusedBorder: UnderlineInputBorder(
                            borderSide: BorderSide(color: Colors.grey),
                          ),
                        ),
                        onChanged: (value) {
                          state = value;
                        },
                      ),
                      SizedBox(height: 60.0),
                      Container(
                          height: 60.0,
                          child: Material(
                            borderRadius: BorderRadius.circular(30.0),
                            shadowColor: Color(0xff004e92),
                            color: Color(0xff000428),
                            elevation: 7.0,
                            child: GestureDetector(
                              onTap: () {
                                if (name != null &&
                                    age != null &&
                                    city != null &&
                                    state != null) {
                                  _firestore
                                      .collection('UserDatabase')
                                      .doc(FirebaseAuth.instance.currentUser.uid)
                                      .set({
                                    'Name': name,
                                    'Email': loggedInUser.email,
                                    'Age': age,
                                    'City': city,
                                    'State': state,
                                  });
                                  Navigator.pushNamed(context, HomeScreen.id);
                                }
                              },
                              child: Center(
                                child: Text(
                                  'SIGNUP',
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold,
                                      fontFamily: 'Montserrat'),
                                ),
                              ),
                            ),
                          )),
                      SizedBox(height: 20.0),
                    ],
                  )),
              SizedBox(height: 15.0),
            ],
          ),
        ),
      ),
    );
  }
}
