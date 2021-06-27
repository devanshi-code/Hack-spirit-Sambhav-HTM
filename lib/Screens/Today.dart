import 'package:flutter/material.dart';

class Today extends StatefulWidget {
 const Today({Key key}) : super(key: key);

  @override
  _TodayState createState() => _TodayState();
}

class _TodayState extends State<Today> {
  @override
  Widget build(BuildContext context) {
    return Container(
       child: Text("Today"),
    );
  }
}