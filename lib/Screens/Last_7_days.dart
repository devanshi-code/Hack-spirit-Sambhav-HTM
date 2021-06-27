import 'package:flutter/material.dart';

class LastWeek extends StatefulWidget {
  LastWeek({Key key}) : super(key: key);

  @override
  _LastWeekState createState() => _LastWeekState();
}

class _LastWeekState extends State<LastWeek> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child:Text("Last 7 Days")
    );
  }
}