import 'package:bot_toast/bot_toast.dart';
import 'package:Sambhav/helper/helperfunction.dart';
import 'package:Sambhav/services/auth.dart';
import 'package:Sambhav/services/database.dart';
import 'package:Sambhav/services/database.dart';
import 'package:Sambhav/Screens/MainScreen.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter/material.dart';
import 'package:Sambhav/widget/colors.dart';
import 'package:Sambhav/widget/fadeanimation.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'loginpage.dart';

class SignUp extends StatefulWidget {
  final Function toggle;
  SignUp(this.toggle);
  @override
  _SignUpState createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  final formkey = GlobalKey<FormState>();
  bool isLoading = false;

  AuthMethods authMethods = new AuthMethods();

  Databasemethods databasemethod = new Databasemethods();
  TextEditingController emailController = new TextEditingController();
  TextEditingController passwController = new TextEditingController();
  TextEditingController usernameController = new TextEditingController();

  signMeUp() {
    if (formkey.currentState.validate()) {
      setState(() {
        isLoading = true;
      });

      authMethods
          .signUpWithEmailAndPassword(
              emailController.text, passwController.text)
          .then((value) {
        if (value == 0) {
          setState(() {
            isLoading = false;
            BotToast.showText(text: "The password provided is too weak.");
          });
        } else if (value == 1) {
          setState(() {
            isLoading = false;
            BotToast.showText(
                text: "The account already exists for that email.");
            passwController.text = null;
          });
        } else if (value != null) {
          Map<String, String> userInfoMap = {
            "name": usernameController.text,
            "email": emailController.text
          };
          databasemethod.uploaduserInfo(userInfoMap);
          HelperFunction.saveuserLoggedInSharedPreference(true);
          HelperFunction.saveuserEmailSharedPreference(emailController.text);
          HelperFunction.saveuserNameSharedPreference(usernameController.text);

          Navigator.pushReplacement(
              context, MaterialPageRoute(builder: (context) => MainScreen()));
        }
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: isLoading
            ? Center(child: CircularProgressIndicator())
            : SingleChildScrollView(
                child: Container(
                  height: MediaQuery.of(context).size.height,
                  decoration: BoxDecoration(
                   image: DecorationImage(image: AssetImage("assets/loginbackground.jpeg"),
                   fit: BoxFit.cover)
                  ),
                  child: Column(
                    children: [
                      SizedBox(
                        height: 50,
                      ),
                      FadeAnimation(
                        1.5,
                        Text("Sambhav",style:TextStyle(fontSize: 37,fontWeight: FontWeight.w500,fontFamily: 'Lobster',) ),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      FadeAnimation(
                        1.5,
                        Text("Create new account",
                            style: GoogleFonts.nunito(
                                textStyle: TextStyle(
                                    color: Colors.black,
                                    fontSize: 17,
                                    fontWeight: FontWeight.w600))),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      FadeAnimation(
                        1.5,
                        Image.asset(
                          'assets/logo.png',
                          width: 150,
                          height: 150,
                        ),
                      ),
                      FadeAnimation(
                        1.5,
                        Container(
                          width: double.infinity,
                          child: Form(
                            key: formkey,
                            child: Column(
                              children: [
                                FadeAnimation(
                                  1.5,
                                  Container(
                                    margin: EdgeInsets.only(top: 15,right: 15,left: 15),
                                    padding: EdgeInsets.all(6),
                                    decoration: BoxDecoration(
                                      color: Colors.white,
                                    borderRadius: BorderRadius.circular(20)
                                    ),
                                    child: TextFormField(
                                      validator: (val) {
                                        if (!val.isEmpty) {
                                          if (val.length < 4) {
                                            return "Username Too short";
                                          }
                                        } else if (val.isEmpty) {
                                          return "Enter Username";
                                        }
                                      },
                                      controller: usernameController,
                                      decoration: InputDecoration(
                                        suffixIcon: Container(
                                          margin: EdgeInsets.only(
                                                  right: 6,
                                                  top: 6,
                                                  bottom: 6),
                                          decoration: BoxDecoration(
                                            color: Colors.blue,
                                            borderRadius: BorderRadius.circular(20)
                                          ),
                                          child: Icon(Icons.person,color: Colors.white,)),
                                          enabledBorder:
                                              UnderlineInputBorder(
                                                  borderSide: BorderSide(
                                                      color: Colors.white)),
                                          focusedBorder:
                                              UnderlineInputBorder(
                                                  borderSide: BorderSide(
                                                      color: Colors.white)),
                                          hintText: "Enter Username"),
                                    ),
                                  ),
                                ),
                                FadeAnimation(
                                  1.5,
                                  Container(
                                    margin: EdgeInsets.only(top: 15,right: 15,left: 15),
                                    padding: EdgeInsets.all(6),
                                    decoration: BoxDecoration(
                                      color: Colors.white,
                                    borderRadius: BorderRadius.circular(20)
                                    ),
                                    child: TextFormField(
                                      validator: (val) {
                                        if (!val.isEmpty) {
                                          if (RegExp(
                                                  r"^[a-zA-Z0-9+_.-]+@[a-zA-Z0-9.-]+$")
                                              .hasMatch(val)) {
                                            return null;
                                          } else {
                                            return "Enter Email correctly";
                                          }
                                        } else
                                          return "Enter Email";
                                      },
                                      controller: emailController,
                                      decoration: InputDecoration(
                                        suffixIcon: Container(
                                          margin: EdgeInsets.only(
                                                  right: 6,
                                                  top: 6,
                                                  bottom: 6),
                                          decoration: BoxDecoration(
                                            color: Colors.orange,
                                            borderRadius: BorderRadius.circular(20)
                                          ),
                                          child: Icon(Icons.email_rounded,color: Colors.white,)),
                                          enabledBorder:
                                              UnderlineInputBorder(
                                                  borderSide: BorderSide(
                                                      color: Colors.white)),
                                          focusedBorder:
                                              UnderlineInputBorder(
                                                  borderSide: BorderSide(
                                                      color: Colors.white)),
                                          hintText: "Email Address"),
                                    ),
                                  ),
                                ),
                                FadeAnimation(
                                  1.5,
                                  Container(
                                    margin: EdgeInsets.only(top: 15,right: 15,left: 15),
                                    padding: EdgeInsets.all(6),
                                    decoration: BoxDecoration(
                                      color: Colors.white,
                                    borderRadius: BorderRadius.circular(20)
                                    ),
                                    child: TextFormField(
                                      obscureText: true,
                                      validator: (val) {
                                        if (!val.isEmpty) {
                                          if (val.length < 4) {
                                            return "Password Too short";
                                          }
                                        } else if (val.isEmpty) {
                                          return "Enter Password";
                                        }
                                      },
                                      controller: passwController,
                                      decoration: InputDecoration(
                                        suffixIcon: Container(
                                          margin: EdgeInsets.only(
                                                  right: 6,
                                                  top: 6,
                                                  bottom: 6),
                                          decoration: BoxDecoration(
                                            color: Colors.grey,
                                            borderRadius: BorderRadius.circular(20)
                                          ),
                                          child: Icon(Icons.security,color: Colors.white,)),
                                          enabledBorder:
                                              UnderlineInputBorder(
                                                  borderSide: BorderSide(
                                                      color: Colors.white)),
                                          focusedBorder:
                                              UnderlineInputBorder(
                                                  borderSide: BorderSide(
                                                      color: Colors.white)),
                                          hintText: "Password",
                                          ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      FadeAnimation(
                          1.5,
                          Text(
                            "Forgot Password?",
                            style: GoogleFonts.nunito(
                                textStyle: TextStyle(
                                    color: Colors.black,
                                    fontSize: 15,
                                    fontWeight: FontWeight.w500)),
                          )),
                      SizedBox(
                        height: 5,
                      ),
                      FadeAnimation(
                          1.5,
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                "Already have an account?",
                                style: GoogleFonts.nunito(
                                    textStyle: TextStyle(
                                        color: Colors.black,
                                        fontSize: 15,
                                        fontWeight: FontWeight.w500)),
                              ),
                              GestureDetector(
                                onTap: () {
                                  widget.toggle();
                                },
                                child: Text(
                                  "Login",
                                  style: GoogleFonts.nunito(
                                      textStyle: TextStyle(
                                          color: themecolor,
                                          fontSize: 17,
                                          fontWeight: FontWeight.w800)),
                                ),
                              ),
                            ],
                          )),
                      SizedBox(
                        height: 10,
                      ),
                      FadeAnimation(
                        1.6,
                        Padding(
                          padding: const EdgeInsets.only(left: 40.0, right: 40),
                          child: MaterialButton(
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(25)),
                            elevation: 0.8,
                            height: 50,
                            onPressed: () {
                              signMeUp();
                            },
                            color: themecolor,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: <Widget>[
                                Text('Sign up',
                                    style: TextStyle(
                                        color: Colors.white, fontSize: 20)),
                              ],
                            ),
                            textColor: Colors.white,
                          ),
                        ),
                      ),
                     
                    ],
                  ),
                ),
              ));
  }
}
