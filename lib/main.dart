import 'package:flutter/material.dart';
import 'map.dart';

void main() {
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
        primarySwatch: Colors.blue,
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
  TextEditingController idController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
        backgroundColor: Colors.redAccent,
        centerTitle: true,
        leading: IconButton(
          onPressed: () {
            print("menu");
          },
          icon: Icon(Icons.menu),
        ),
        actions: [
          IconButton(onPressed: (){
            print("search");
          }, icon: Icon(Icons.search))
        ],
      ),
      body: Builder(
        builder:(context){ return GestureDetector(
          onTap: (){
            FocusScope.of(context).unfocus();
          },
          child: SingleChildScrollView(
            child: Column(
              children: [
                Padding(padding: EdgeInsets.only(top: 50)),
                const Center(
                  child: Image(
                    image: AssetImage("assets/kong1.gif"),
                    width: 170.0,
                    height: 190.0,
                  ),
                ),
                Form(
                  child: Theme(
                    data: ThemeData(
                      inputDecorationTheme: const InputDecorationTheme(
                        labelStyle: TextStyle(
                          // color: Colors.teal,
                          fontSize: 15.0
                        )
                      )
                    ),
                    child: Container(
                      padding: const EdgeInsets.all(40),
                      child: Column(
                        children: [
                          TextField(
                            controller: idController,
                            decoration: const InputDecoration(
                              labelText: 'ID'
                            ),
                            keyboardType: TextInputType.emailAddress,
                          ),
                          TextField(
                            controller: passwordController,
                            decoration: const InputDecoration(
                                labelText: 'password'
                            ),
                            keyboardType: TextInputType.text,
                            obscureText: true,
                          ),
                          const SizedBox(height: 40.0,),
                          ButtonTheme(
                            minWidth: 100.0,
                              height: 50.0,
                            child: MaterialButton(
                              color: Colors.orangeAccent,
                              child: Icon(
                                Icons.arrow_forward,
                                color: Colors.white,
                                size: 35.0,
                              ),
                              onPressed: (){
                                if(idController.text == "dice" && passwordController.text == "1234"){
                                  Navigator.push(context, MaterialPageRoute(builder: (ctx) => MapView()));
                                }else if(idController.text == "dice" && passwordController.text != "1234"){
                                  showSnackBar2(context);
                                }else if(idController.text != "dice" && passwordController.text =="1234"){
                                  showSnackBar3(context);
                                }
                              }, )
                            ,),
                        ],
                      ),
                    )),
                )
              ],
            ),
          ),
        );
      }
      ));
  }
}

void showSnackBar(BuildContext context){

  Scaffold.of(context).showSnackBar(
      const SnackBar(
        content: Text("로그인 정보를 확인하세요", textAlign: TextAlign.center, ),
        duration: Duration(seconds: 2),
        backgroundColor: Colors.blue,
      ));
}

void showSnackBar2 (BuildContext context){

  Scaffold.of(context).showSnackBar(
      const SnackBar(
        content: Text("비밀번호가 일치하지 않습니다", textAlign: TextAlign.center, ),
        duration: Duration(seconds: 2),
        backgroundColor: Colors.blue,
      ));
}

void showSnackBar3 (BuildContext context){

  Scaffold.of(context).showSnackBar(
      const SnackBar(
        content: Text("dice의 철자를 확인하세요", textAlign: TextAlign.center, ),
        duration: Duration(seconds: 2),
        backgroundColor: Colors.blue,
      ));
}