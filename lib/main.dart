import 'dart:async';
import 'package:bot_toast/bot_toast.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:provider/provider.dart';
import 'package:Sambhav/Screens/mainScreen.dart';
import 'package:Sambhav/Sos/Screens/Contact.dart';
import 'package:Sambhav/Sos/Screens/Soshome.dart';
import 'package:Sambhav/Sos/theme.dart';
import 'package:Sambhav/helper/authenticate.dart';
import 'package:Sambhav/helper/helperfunction.dart';
import 'package:Sambhav/views/ChatSrcreen.dart';
import 'package:Sambhav/views/search.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:Sambhav/widget/colors.dart';
import 'package:Sambhav/views/firstpage.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(App());
}

class App extends StatefulWidget {
  // Create the initialization Future outside of `build`:
  @override
  _AppState createState() => _AppState();
}

class _AppState extends State<App> {
  final Future<FirebaseApp> _initialization = Firebase.initializeApp();
  DarkThemeProvider themeChangeProvider = new DarkThemeProvider();

  bool userisloggedin = false;
  @override
  void initState() {
    // TODO: implement initState

    getloginState();
    getCurrentAppTheme();
    super.initState();
  }
 void getCurrentAppTheme() async {
    themeChangeProvider.darkTheme =
    await themeChangeProvider.darkThemePreference.getTheme();
  }

  getloginState() async {
    await HelperFunction.GetuserLoggedInSharedPreference().then((value) {
      setState(() {
        {
          if (value != null) {
            userisloggedin = value;
          } else {
            userisloggedin = false;
          }
        }
      });
    });
  }


  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_)=> themeChangeProvider,
      child: Consumer<DarkThemeProvider>(
        builder: (BuildContext context, value, Widget child){
          return GetMaterialApp(
            debugShowCheckedModeBanner: false,
            theme: Styles.themeData(themeChangeProvider.darkTheme, context),
            title: 'College Companion',
            home: FutureBuilder(
      // Initialize FlutterFire:
      future: _initialization,
      builder: (context, snapshot) {
        // Check for errors
        if (snapshot.hasError) {
          print("error");
        }

        // Once complete, show your application
        if (snapshot.connectionState == ConnectionState.done) {
          return MaterialApp(
              theme: ThemeData(
                primaryColor: Color(0xfff833AB4),
                accentColor: Color(0xfff5B51D8),
              ),
              builder: BotToastInit(), //1. call BotToastInit
              navigatorObservers: [BotToastNavigatorObserver()],
              debugShowCheckedModeBanner: false,
              home: userisloggedin ? MainScreen() : Authenticate());
        }

        // Otherwise, show something whilst waiting for initialization to complete
        return Container();
      },
    ),
          initialRoute: '/',
            routes: {
              '/home': (ctx) => Soshome(),
              '/contacts': (ctx) => Contacts(),
            },
          );
        },
      )
    );
  }
}