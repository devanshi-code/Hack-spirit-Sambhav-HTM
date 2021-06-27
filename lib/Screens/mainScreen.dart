
import 'package:flutter/material.dart';
import 'package:Sambhav/Screens/Home.dart';
import 'package:Sambhav/Screens/Profile.dart';
import 'package:Sambhav/Screens/Settings.dart';
import 'package:Sambhav/Screens/Sos.dart';
import 'package:Sambhav/views/ChatSrcreen.dart';



class MainScreen extends StatefulWidget {
  MainScreen({Key key}) : super(key: key);

  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> with TickerProviderStateMixin {
  AnimationController _controller;
  TabController _tabController;
  static const List<IconData> icons = [
    Icons.call,
    Icons.videocam,
  ];

  @override
  void initState() {
    _controller = new AnimationController(vsync: this, duration: const Duration(milliseconds: 500));
    super.initState();
    _tabController = new TabController(length: 5, vsync: this);
  }

  @override
  void Dispose() {
    super.dispose();
    _tabController.dispose();
  }

  

  @override
  Widget build(BuildContext context) {
    Color backgroundColor = Theme.of(context).cardColor;
    Color foregroundColor = Theme.of(context).accentColor;
    return Scaffold(
      body:TabBarView(controller: _tabController, children: <Widget>[
       new Home(),
        new Profile(),
        new Sos(),
        new ChatScreen(),
        new Settings(),
      ]),
      
      bottomNavigationBar: Material(
        color: Colors.white,
        child: TabBar(
            controller: _tabController,
            indicatorColor: Colors.pinkAccent,
            tabs: <Widget>[
              Tab(
                icon: Icon(
                  Icons.home,
                  color: Colors.grey,
                ),
              ),
              Tab(icon: Icon(Icons.person_outlined, color: Colors.grey)),
              Tab(
                  child: CircleAvatar(
                child: Text("SOS"),
                backgroundColor: Colors.pink,
              )),
              Tab(icon: Icon(Icons.chat_bubble_outline, color: Colors.grey)),
              Tab(icon: Icon(Icons.settings, color: Colors.grey)),
            ]),
     ) );
  }
}
