import 'dart:async';

import 'package:avatar_glow/avatar_glow.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:geocoder/geocoder.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:hardware_buttons/hardware_buttons.dart';
import 'package:provider/provider.dart';
import 'package:rflutter_alert/rflutter_alert.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sms_maintained/sms.dart';

import '../signin.dart';
import '../theme.dart';

class Soshome extends StatefulWidget {
  @override
  _SoshomeState createState() => _SoshomeState();
}

class _SoshomeState extends State<Soshome> {
  double wd, ht;
  SharedPreferences prefs;
  bool loc = true, hardware = false;
  int down = 0, up = 0;
  StreamSubscription _volumeButtonSubscription;

  void _enterNumber() {
    final _key = GlobalKey<FormState>();
    String number;
    Alert(
      context: context,
      style: AlertStyle(
        isCloseButton: false,
        isOverlayTapDismiss: false,
      ),
      title: "Contact number",
      desc: "Enter your mobile number to continue.",
      content: StatefulBuilder(
        builder: (BuildContext context, StateSetter setState) {
          return Form(
            key: _key,
            child: Column(
              children: [
                TextFormField(
                  maxLines: 1,
                  keyboardType: TextInputType.phone,
                  validator: (value) =>
                      value.isEmpty ? 'Contact Number can\'t be empty' : null,
                  onSaved: (value) => number = value,
                  decoration: InputDecoration(
                    hintText: 'Enter contact number...',
                  ),
                  style: TextStyle(
                    fontSize: 15,
                  ),
                ),
              ],
            ),
          );
        },
      ),
      buttons: [
        DialogButton(
          color: Colors.green,
          child: Text(
            "SAVE",
            style: TextStyle(color: Colors.white, fontSize: 20),
          ),
          onPressed: () {
            if (_key.currentState.validate()) {
              _key.currentState.save();
              FirebaseFirestore.instance.collection('users').doc(uid).update(
                  {'phone': number}).then((value) => print("User Updated"));
              print('username : ' + userName);
              print('email : ' + userEmail);
              print('phone : ' + phone);
              Get.back();
            }
          },
          width: 120,
        )
      ],
    ).show();
  }

  void _sendSMS() async {
    List<String> recipients = prefs.getStringList('nums') ?? [];

    Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high);
    String latlng =
        position.latitude.toString() + ',' + position.longitude.toString();
    final coordinates = new Coordinates(position.latitude, position.longitude);
    var addresses =
        await Geocoder.local.findAddressesFromCoordinates(coordinates);
    var first = addresses.first.addressLine;
    print('Local Address: $first');

    FirebaseFirestore.instance
        .collection('sos')
        .doc('$uid ${DateTime.now().toString()}')
        .set({
      'username': userName,
      'photoUrl': userImageUrl,
      'id': uid,
      'email': userEmail,
      'phone': phone,
      'address': first,
      'latitude': position.latitude.toString(),
      'longitude': position.longitude.toString(),
      'time': DateTime.now(),
      'emergencyContacts': recipients
    });
    if (recipients.length == 0) {
      Get.snackbar('No phone numbers found! Only police will be notified.',
          'Please check Emergency contacts list.');
    } else {
      String messageBody = 'Help me! I am in trouble.';
      if (loc) {
        messageBody +=
            '\n\nMy current location is:\nhttps://www.google.com/maps/search/?api=1&query=$latlng';
      }

      SmsSender sender = new SmsSender();
      for (int i = 0; i < recipients.length; i++) {
        SmsMessage message = new SmsMessage(recipients[i], messageBody);
        message.onStateChanged.listen((state) {
          if (state == SmsMessageState.Sent) {
            print("SMS $i is sent!");
          } else if (state == SmsMessageState.Delivered) {
            print("SMS $i is delivered!");
            print(messageBody);
          }
        });
        sender.sendSms(message);
      }
      Get.snackbar(
          'SOS sent!', 'All emergency contacts & police have been notified.');
    }
  }

  void locationServices() async {
    await Geolocator.checkPermission().then((permission) async {
      if (permission != LocationPermission.always &&
          permission != LocationPermission.whileInUse) {
        await Geolocator.requestPermission();
      }
    });
    await Geolocator.isLocationServiceEnabled().then((locationStatus) async {
      if (!locationStatus) {
        await Geolocator.openAppSettings();
        await Geolocator.openLocationSettings();
      }
    });
    prefs = await SharedPreferences.getInstance();
    setState(() {
      loc = prefs.getBool('loc') ?? true;
      hardware = prefs.getBool('hardware') ?? false;
    });
  }

  @override
  void initState() {
    _volumeButtonSubscription =
        volumeButtonEvents.listen((VolumeButtonEvent event) {
     
    });

    RawKeyboard.instance.addListener((RawKeyEvent event) {
     
      if (hardware) {
        if (event.runtimeType == RawKeyDownEvent &&
            event.physicalKey.debugName == 'Audio Volume Down') {
          down++;
        }
        if (event.runtimeType == RawKeyDownEvent &&
            event.physicalKey.debugName == 'Audio Volume Up') {
          up++;
        }
        if (event.runtimeType == RawKeyDownEvent && down == 3 && up == 0) {
          _sendSMS();
        }
      }
      if (event.runtimeType == RawKeyDownEvent &&
          event.physicalKey.debugName == 'Audio Volume Down' &&
          down == 1) {
        Timer(Duration(seconds: 2), () async {
          down = 0;
          up = 0;
        });
      }
    });

    locationServices();

    Timer(Duration(seconds: 2), () async {
      if (phone == '') {
        _enterNumber();
      } else {
        print('username : ' + userName);
        print('email : ' + userEmail);
        print('phone : ' + phone);
      }
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    wd = MediaQuery.of(context).size.width;
    ht = MediaQuery.of(context).size.height;

    final themeChange = Provider.of<DarkThemeProvider>(context);
    return Scaffold(
      appBar: AppBar(
       leading: IconButton(icon: Icon(Icons.arrow_back), onPressed: (){
         
       }),
        backgroundColor: Theme.of(context).primaryColor,
        title: Text(
          '${userName.substring(0, userName.indexOf(' '))}',
          style: TextStyle(
            fontFamily: 'Lobster',
            fontSize: 25,
          ),
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 25),
            child: GestureDetector(
              onTap: () => Get.toNamed('/contacts'),
              child: Icon(
                Icons.contacts,
                size: 30,
              ),
            ),
          ),
        ],
      ),
      body: Column(
      
        children: [
          SizedBox(height: 18,),
           SizedBox(
            
            width: wd * 0.8,
            child: Table(
              defaultVerticalAlignment: TableCellVerticalAlignment.middle,
              columnWidths: {0: FractionColumnWidth(0.7)},
              children: [
                TableRow(children: [
                  Text('Location Coordinates:',style: TextStyle(fontSize: 18,fontWeight: FontWeight.w500),),
                  CupertinoSwitch(
                    activeColor: Theme.of(context).canvasColor,
                    value: loc,
                    onChanged: (val) async {
                      setState(() {
                        loc = val;
                      });
                      await prefs.setBool('loc', loc);
                    },
                  ),
                ]),
                
                TableRow(children: [
                  Text(
                      'Hardware Shortcut\nPress VOLUME DOWN twice & VOLUME UP once',style: TextStyle(fontSize: 18,fontWeight: FontWeight.w500),),
                  CupertinoSwitch(
                    activeColor: Theme.of(context).canvasColor,
                    value: hardware,
                    onChanged: (val) async {
                      setState(() {
                        hardware = val;
                      });
                      await prefs.setBool('hardware', hardware);
                    },
                  ),
                ]),
              ],
            ),
          ),
          SizedBox(height: 80,),
          AvatarGlow(
            glowColor: Colors.pink,
            endRadius: wd * 0.5,
            duration: Duration(milliseconds: 1700),
            repeat: true,
            showTwoGlows: true,
            repeatPauseDuration: Duration(milliseconds: 100),
            child: MaterialButton(
              elevation: 3,
              onPressed: () => _sendSMS(),
              color:Colors.pink,
              textColor: Colors.white,
              child: Text(
                'SOS',
                style: TextStyle(fontSize: wd * 0.2),
              ),
              padding: EdgeInsets.all(wd * 0.2),
              shape: CircleBorder(),
            ),
          ),
         
        ],
      ),
    );
  }

  @override
  void dispose() {
    super.dispose();
    // be sure to cancel on dispose
    _volumeButtonSubscription?.cancel();
  }
}