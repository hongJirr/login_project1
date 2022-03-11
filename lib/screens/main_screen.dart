import 'package:flutter/material.dart';
import 'package:login_project1/palette.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'chat_screen.dart';

class LoginSignupScreen extends StatefulWidget {
  const LoginSignupScreen({Key? key}) : super(key: key);

  @override
  _LoginSignupScreenState createState() => _LoginSignupScreenState();
}

class _LoginSignupScreenState extends State<LoginSignupScreen> {
  final _authentication = FirebaseAuth.instance;

  bool isSingupScreen = true;
  bool showSpinner = false;

  final _formKey = GlobalKey<FormState>();
  String userName = "";
  String userEmail = "";
  String userPassword = "";

  void _tryValidation(){
    final isValid = _formKey.currentState!.validate();
    if(isValid){
      _formKey.currentState!.save();
    }
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Palette.backgroundColor,
      body: ModalProgressHUD(
        inAsyncCall: showSpinner,
        child: GestureDetector(
          onTap: (){
            FocusScope.of(context).unfocus();
          },
          child: Stack(
            children: [
              //배경
              Positioned(
                top: 0,
                right: 0,
                left: 0,
                child: Container(
                height: 300,
                decoration: const BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage("assets/blue.jpg"),
                    fit: BoxFit.fill
                  )
                ),
                child: Container(
                  padding: const EdgeInsets.only(top: 90, left: 20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      RichText(text: TextSpan(
                        text: "Welcome",
                        style: const TextStyle(letterSpacing: 1.0, fontSize: 25, color: Colors.white),
                        children: [
                          TextSpan(
                            text: isSingupScreen ? " to Kongji Chat": " Back",
                            style: const TextStyle(letterSpacing: 1.0, fontSize: 25, color: Colors.white, fontWeight: FontWeight.bold),
                          )
                        ]
                      ),
                      ),
                      SizedBox(height: 5.0,),
                      Text( '${isSingupScreen ? 'singup' : 'singin'} to continue',
                        style: const TextStyle(
                          letterSpacing: 1.0,
                          color: Colors.white
                        )),
                    ],
                  ),
                ),
              )),
              //Form
              AnimatedPositioned(
                top: 180,
                  duration: const Duration(milliseconds: 500),
                  curve: Curves.easeIn,
                  child: AnimatedContainer(
                    padding: EdgeInsets.all(20.0),
                    height: isSingupScreen ? 300.0 : 270.0,
                    width: MediaQuery.of(context).size.width - 40,
                    margin: EdgeInsets.symmetric(horizontal: 20.0),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(15.0),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.3),
                          blurRadius: 15,
                          spreadRadius: 5
                        )
                      ]
                    ),
                    duration: Duration(milliseconds: 500),
                    curve: Curves.easeIn,
                    child: SingleChildScrollView(
                      padding: EdgeInsets.only(bottom: 20),
                      child: Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              GestureDetector(
                                onTap: (){
                                  setState(() {
                                    isSingupScreen = false;
                                  });
                                },
                                child: Column(
                                  children: [
                                    Text('LOGIN',
                                      style: TextStyle( fontSize: 16,
                                          fontWeight: FontWeight.bold,
                                          color: !isSingupScreen ? Palette.activaColor : Palette.textColor1),),
                                    if(!isSingupScreen)
                                    Container(
                                      margin: EdgeInsets.only(top: 5),
                                      height: 2, width: 55, color: Colors.orange,
                                    )
                                  ],
                                ),
                              ),
                              GestureDetector(
                                onTap: (){
                                  setState(() {
                                    isSingupScreen = true;
                                  });
                                },
                                child: Column(
                                  children: [
                                    Text('SIGNUP',
                                      style: TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.bold,
                                          color: isSingupScreen ? Palette.activaColor : Palette.textColor1),),
                                    if(isSingupScreen)
                                    Container(
                                      margin: EdgeInsets.only(top: 5),
                                      height: 2, width: 55, color: Colors.orange,
                                    )
                                  ],
                                ),
                              )
                            ],
                          ),
                          if(isSingupScreen)
                          Container(
                            margin: EdgeInsets.only(top: 20),
                            child: Form(
                              key: _formKey,
                              child: Column(
                                children: [
                                  TextFormField(
                                    key: const ValueKey(1),
                                    validator: (value){
                                      if(value!.isEmpty || value.length < 4){
                                        return 'Please enter at least 4 characters.';
                                      }
                                      return null;
                                    },
                                    onSaved: (value){
                                      userName = value!;
                                    },
                                    onChanged: (value){
                                      userName = value;
                                    },
                                    decoration: const InputDecoration(
                                      prefixIcon: Icon(Icons.account_circle,  color: Palette.iconColor),
                                      enabledBorder: OutlineInputBorder(
                                        borderSide: BorderSide(
                                          color: Palette.textColor1
                                        ),
                                        borderRadius: BorderRadius.all(Radius.circular(35.0))
                                      ),
                                      focusedBorder: OutlineInputBorder(
                                          borderSide: BorderSide(
                                              color: Palette.textColor1
                                          ),
                                          borderRadius: BorderRadius.all(Radius.circular(35.0))
                                      ),
                                      hintText: "User name",
                                      hintStyle: TextStyle(
                                        fontSize: 14,
                                        color: Palette.textColor1
                                      ),
                                      contentPadding: EdgeInsets.all(10)
                                    ),
                                  ),
                                  const SizedBox(height: 8,),
                                  TextFormField(
                                    key: const ValueKey(2),
                                    validator: (value){
                                      if(value!.isEmpty || !value.contains('@')){
                                        return 'Please enter a valid email.';
                                      }
                                      return null;
                                    },
                                    onSaved: (value){
                                      userEmail = value!;
                                    },
                                    onChanged: (value){
                                      userEmail = value;
                                    },
                                    keyboardType: TextInputType.emailAddress,
                                    decoration: const InputDecoration(
                                        prefixIcon: Icon(Icons.email,  color: Palette.iconColor),
                                        enabledBorder: OutlineInputBorder(
                                            borderSide: BorderSide(
                                                color: Palette.textColor1
                                            ),
                                            borderRadius: BorderRadius.all(Radius.circular(35.0))
                                        ),
                                        focusedBorder: OutlineInputBorder(
                                            borderSide: BorderSide(
                                                color: Palette.textColor1
                                            ),
                                            borderRadius: BorderRadius.all(Radius.circular(35.0))
                                        ),
                                        hintText: "email",
                                        hintStyle: TextStyle(
                                            fontSize: 14,
                                            color: Palette.textColor1
                                        ),
                                        contentPadding: EdgeInsets.all(10)
                                    ),
                                  ),
                                  const SizedBox(height: 8,),
                                  TextFormField(
                                    key: const ValueKey(3),
                                    validator: (value){
                                      if(value!.isEmpty || value.length < 6){
                                        return 'Password must be at least 6 characters long.';
                                      }
                                      return null;
                                    },
                                    onSaved: (value){
                                      userPassword = value!;
                                    },
                                    onChanged: (value){
                                      userPassword = value;
                                    },
                                    obscureText: true,
                                    decoration: const InputDecoration(
                                        prefixIcon: Icon(Icons.password_outlined,  color: Palette.iconColor),
                                        enabledBorder: OutlineInputBorder(
                                            borderSide: BorderSide(
                                                color: Palette.textColor1
                                            ),
                                            borderRadius: BorderRadius.all(Radius.circular(35.0))
                                        ),
                                        focusedBorder: OutlineInputBorder(
                                            borderSide: BorderSide(
                                                color: Palette.textColor1
                                            ),
                                            borderRadius: BorderRadius.all(Radius.circular(35.0))
                                        ),
                                        hintText: "password",
                                        hintStyle: TextStyle(
                                            fontSize: 14,
                                            color: Palette.textColor1
                                        ),
                                        contentPadding: EdgeInsets.all(10)
                                    ),
                                  )
                                ],
                              ),
                            ),
                          ),
                          if(!isSingupScreen)
                          Container(
                            padding: const EdgeInsets.only(top: 20),
                            child: Form(
                              key: _formKey,
                              child: Column(
                                children: [
                                  TextFormField(
                                    key: const ValueKey(4),
                                    validator: (value){
                                      if(value!.isEmpty || !value.contains('@')){
                                        return 'Please enter a valid email.';
                                      }
                                      return null;
                                    },
                                    onSaved: (value){
                                      userEmail = value!;
                                    },
                                    onChanged: (value){
                                      userEmail = value;
                                    },
                                    keyboardType: TextInputType.emailAddress,
                                    decoration: const InputDecoration(
                                      prefixIcon: Icon(Icons.email, color: Palette.textColor1,),
                                      enabledBorder: OutlineInputBorder(
                                        borderRadius: BorderRadius.all(Radius.circular(35.0)),
                                        borderSide: BorderSide(color: Palette.textColor1),
                                    ),
                                    hintText: "email",
                                      hintStyle: TextStyle(
                                        fontSize: 14,
                                        color: Palette.textColor1
                                      ),
                                      contentPadding: EdgeInsets.all(10),
                                      focusedBorder: OutlineInputBorder(
                                        borderRadius: BorderRadius.all(Radius.circular(35.0)),
                                        borderSide: BorderSide(color: Palette.textColor1),
                                      ),
                                  ),
                                  ),
                                  const SizedBox(height: 10,),
                                  TextFormField(
                                      key: const ValueKey(5),
                                      validator: (value){
                                        if(value!.isEmpty || value.length < 6){
                                          return 'Password must be at least 6 characters long.';
                                        }
                                        return null;
                                      },
                                      onSaved: (value){
                                        userPassword = value!;
                                      },
                                      onChanged: (value){
                                        userPassword = value;
                                      },
                                      obscureText: true,
                                      decoration: const InputDecoration(
                                        prefixIcon: Icon(Icons.password_outlined, color: Palette.textColor1,),
                                        enabledBorder: OutlineInputBorder(
                                          borderRadius: BorderRadius.all(Radius.circular(35.0)),
                                          borderSide: BorderSide( color: Palette.textColor1),
                                        ),
                                        hintText: "password",
                                        hintStyle: TextStyle(
                                          fontSize: 14,
                                          color: Palette.textColor1
                                        ),
                                        contentPadding: EdgeInsets.all(10),
                                        focusedBorder: OutlineInputBorder(
                                          borderRadius: BorderRadius.all(Radius.circular(35.0)),
                                          borderSide: BorderSide( color: Palette.textColor1),
                                        ),
                                      )
                                  )],
                              ),

                            ),
                          )
                        ],
                      ),
                    ),

                  )),
              //버튼
              AnimatedPositioned(
                top: isSingupScreen ? 430 : 400,
                right: 0,
                left: 0,
                duration: const Duration(milliseconds: 500),
                curve: Curves.easeIn,
                child: Center(
                  child: Container(
                    padding: const EdgeInsets.all(15),
                    height: 90,
                      width: 90,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(50),
                    ),
                    child: GestureDetector(
                      onTap: () async {
                        setState(() {
                          showSpinner = true;
                        });
                        if(isSingupScreen){
                          _tryValidation();

                          try{
                            final newUser = await _authentication.createUserWithEmailAndPassword(
                                email: userEmail,
                                password: userPassword
                            );
                            if(newUser.user != null){
                              Navigator.push(context, MaterialPageRoute(builder: (ctx){
                                return ChatScreen();
                              }));
                              setState(() {
                                showSpinner = false;
                              });
                            }
                          }catch(e){
                            print(e);
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(content:
                                Text("Please check your email and password"),
                                backgroundColor: Colors.blue[900],
                              )
                            );
                          }
                        }
                        if(!isSingupScreen){
                          _tryValidation();
                          try{
                            final newUser = await _authentication.signInWithEmailAndPassword(
                                email: userEmail,
                                password: userPassword
                            );

                            if(newUser.user != null){
                              Navigator.push(context, MaterialPageRoute(builder: (ctx){
                                return ChatScreen();
                              }));
                              setState(() {
                                showSpinner = false;
                              });
                            }
                          }catch(e){
                            print(e);
                           ScaffoldMessenger.of(context).showSnackBar(
                               SnackBar(content:  Text("Please check your email and password"),
                                 backgroundColor: Colors.black.withOpacity(0.7),
                               )
                           );
                          }
                        }

                      },
                      child: Container(
                        decoration: BoxDecoration(
                          gradient: const LinearGradient(
                            colors: [
                              Colors.blue,
                              Colors.deepPurpleAccent,
                            ],
                            begin: Alignment.topLeft,
                            end: Alignment.bottomRight,
                          ),
                          borderRadius: BorderRadius.circular(30),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withOpacity(0.3),
                              spreadRadius: 1,
                              blurRadius: 1,
                              offset: const Offset(0,1)
                            )
                          ]
                        ),
                        child: const Icon(Icons.arrow_forward, color: Colors.white),
                      ),
                    ),
              ),
                )),
              //전송버튼
              AnimatedPositioned(
                duration: Duration(milliseconds: 500),
                curve: Curves.easeIn,
                top: isSingupScreen ? MediaQuery.of(context).size.height-190 : MediaQuery.of(context).size.height-220,
                right: 0,
                left: 0,
                child: Column(
                  children: [
                    Text("or ${isSingupScreen? "Signup" : "Singin" } with"),
                    const SizedBox(height: 5,),
                    TextButton.icon(
                        onPressed: (){},
                        style: TextButton.styleFrom(
                          primary: Colors.white,
                          minimumSize: const Size(155,40),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20)
                          ),
                          backgroundColor: Palette.googleColor
                        ), label: Text("Google"), icon: const Icon(Icons.add),
                    )]
              ))
            ],
          ),
        ),
      ),
    );
  }
}
