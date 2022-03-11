import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:login_project1/screens/main_screen.dart';
import 'package:firebase_core/firebase_core.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,

      title: 'Login project',
      theme: ThemeData(
        primaryColor: Colors.black,
      ),
      home: const Login(title: 'Logins'),
    );
  }
}

class Login extends StatefulWidget {
  const Login({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
        backgroundColor: Colors.blue[900],
        centerTitle: true,
        leading: IconButton(
          onPressed: () {
            print("menu2");
          },
          icon: Icon(Icons.menu),
        ),
        actions: [
          IconButton(onPressed: (){
            print("search");
          }, icon: Icon(Icons.search))
        ],
      ),
      body: const LoginSignupScreen(),
    );
  }
}
