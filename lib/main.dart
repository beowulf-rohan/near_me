import 'package:near_me/Auth/login.dart';
import 'package:near_me/Auth/register.dart';
import 'package:near_me/Auth/registerDetails.dart';
import 'package:near_me/Screens/HomeScreen.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_webview_plugin/flutter_webview_plugin.dart';


void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  return runApp(MyApp());
}
String finalEmail;
Widget home = CircularProgressIndicator();

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      routes: {
        Login.id: (context) => Login(),
        Register.id: (context) => Register(),
        RegisterDetails.id: (context) => RegisterDetails(),
        HomeScreen.id: (context) => HomeScreen(),
      },
      home: HomePage(),
    );
  }
}
class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final webView = FlutterWebviewPlugin();

  @override
  void initState() {
    getValidation().whenComplete(() {
      home = finalEmail == null ? Login() : HomeScreen();
    });
    super.initState();
  }

  @override
  void dispose() {
    webView.dispose();
    super.dispose();
  }

  Future getValidation() async {
    final SharedPreferences sharedPref = await SharedPreferences.getInstance();
    String email = sharedPref.getString('email');
    setState(() {
      finalEmail = email;
    });
  }

  Widget build(BuildContext context) {
    return home;
  }
}