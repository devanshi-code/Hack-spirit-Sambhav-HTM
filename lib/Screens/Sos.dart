import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:Sambhav/Sos/signin.dart';


class Sos extends StatefulWidget {
  @override
  _SosState createState() => _SosState();
}

class _SosState extends State<Sos> {
  double wd, ht;

  void signIn() async {
    try {
      final result = await InternetAddress.lookup('google.com');
      if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
        try {
          signInWithGoogle(context).then((val) {
            if (val == "Signed In") {
              Get.back();
              Get.offNamed('/home');
            } else {
              Get.back();
            }
          });
        } catch (e) {
          Get.back();
        }
      }
    } on SocketException catch (_) {
    }
  }

  void alreadySignedIn() async {
    if (await googleSignIn.isSignedIn()) {
      signIn();
    }
  }

  @override
  void initState() {
    alreadySignedIn();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    wd = MediaQuery.of(context).size.width;
    ht = MediaQuery.of(context).size.height;
    return Scaffold(
      
      body: Stack(
        children: [
          Container(
            height: ht,
            width: wd,
          
          ),
          Positioned(
            top: ht * 0.1,
            child: Container(
              height: ht * 0.9,
              width: wd,
            
            ),
          ),
          Positioned(
            top: ht * 0.1,
            child: Container(color: Colors.white,)
          ),
          Positioned(
            bottom: ht * 0.12,
            child: Container(
              width: wd,
              height: ht * 0.27,
              padding: EdgeInsets.fromLTRB(10, 0, 10, 20),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                  
                ],
              ),],
            ),
            ),
                
          )
        ],
      ),
    );
  }
}