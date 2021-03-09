import 'package:near_me/Auth/register.dart';
import 'package:flutter/material.dart';
import 'package:near_me/Screens/HomeScreen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';
import 'package:rflutter_alert/rflutter_alert.dart';


class Login extends StatefulWidget {
  static const String id = 'Login';
  @override
  _LoginState createState() => _LoginState();
}


class _LoginState extends State<Login> {
  String emailVal, passwordVal;
  String status;
  bool showSpinner = false;
  final _auth = FirebaseAuth.instance;
  @override
  Widget build(BuildContext context) {
    return ModalProgressHUD(
      inAsyncCall: showSpinner,
      child: Scaffold(
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
                          'Login',
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
                SizedBox(height: 100.0),
                Container(
                    padding: EdgeInsets.only(top: 35.0, left: 20.0, right: 20.0),
                    child: Column(
                      children: <Widget>[
                        TextField(
                          keyboardType: TextInputType.emailAddress,
                          style: TextStyle(color: Colors.grey.shade50, fontWeight: FontWeight.bold),
                          decoration: InputDecoration(
                            labelText: 'EMAIL',
                            labelStyle: TextStyle(
                              fontFamily: 'Montserrat',
                              fontWeight: FontWeight.bold,
                              color: Colors.white70,
                            ),
                            hintText: 'Enter your email',
                            hintStyle: TextStyle(
                              fontFamily: 'Montserrat',
                              fontSize: 13.5,
                              fontWeight: FontWeight.bold,
                              color: Colors.white70,
                            ),
                            focusedBorder: UnderlineInputBorder(
                              borderSide: BorderSide(color: Colors.grey),
                            ),
                          ),
                          onChanged: (value) {
                            emailVal = value;
                          },
                        ),
                        SizedBox(height: 10.0),
                        TextField(
                          obscureText: true,
                          style: TextStyle(color: Colors.grey.shade50, fontWeight: FontWeight.bold),
                          decoration: InputDecoration(
                            labelText: 'PASSWORD',
                            labelStyle: TextStyle(
                              fontFamily: 'Montserrat',
                              fontWeight: FontWeight.bold,
                              color: Colors.white70,
                            ),
                            hintText: 'Enter your password',
                            hintStyle: TextStyle(
                              fontSize: 13.5,
                              fontFamily: 'Montserrat',
                              fontWeight: FontWeight.bold,
                              color: Colors.white70,
                            ),
                            focusedBorder: UnderlineInputBorder(
                              borderSide: BorderSide(color: Colors.grey),
                            ),
                          ),
                          onChanged: (value) {
                            passwordVal = value;
                          },
                        ),
                        SizedBox(height: 100.0),
                        Container(
                            height: 60.0,
                            child: Material(
                              borderRadius: BorderRadius.circular(30.0),
                              shadowColor: Color(0xff004e92),
                              color: Color(0xff000428),
                              elevation: 7.0,
                              child: GestureDetector(
                                onTap: () async{
                                  if (emailVal != null && passwordVal != null) {
                                    setState(() {
                                      showSpinner = true;
                                    });
                                    try {
                                      final oldUser = await _auth.signInWithEmailAndPassword(
                                          email: emailVal, password: passwordVal);
                                      if (oldUser != null) {
                                        final SharedPreferences sharedPref =
                                            await SharedPreferences.getInstance();
                                        sharedPref.setString('email', emailVal);
                                        Navigator.pushNamed(context, HomeScreen.id);
                                      }
                                      setState(() {
                                        showSpinner = false;
                                      });
                                    } catch (error) {
                                      print(error.code);
                                      switch (error.code) {
                                        case "invalid-email":
                                          status = 'Invalid Email';
                                          break;
                                        case "wrong-password":
                                          status = 'Wrong password';
                                          break;
                                        case "user-not-found":
                                          status = 'User not found';
                                          break;
                                        case "email-already-exists":
                                          status = 'Email already in use';
                                          break;
                                        case "too-many-requests":
                                          status = 'Too many request';
                                          break;
                                        default:
                                          status = 'Undefined error';
                                          break;
                                      }
                                      setState(() {
                                        showSpinner = false;
                                      });
                                      Alert(context: context, title: status, desc: "Please try again").show();
                                    }
                                  }
                                },
                                child: Center(
                                  child: Text(
                                    'LOGIN',
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
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Text(
                      'New to App?',
                      style: TextStyle(
                        color: Colors.white,
                        fontFamily: 'Montserrat',
                      ),
                    ),
                    FlatButton(
                      onPressed: () {
                        Navigator.pushNamed(context, Register.id);
                      },
                      child: InkWell(
                        child: Text('Register',
                            style: TextStyle(
                                color: Color(0xff000428),
                                fontFamily: 'Montserrat',
                                fontWeight: FontWeight.bold,
                                decoration: TextDecoration.underline)),
                      ),
                    )
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
/*

*/
