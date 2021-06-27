import 'package:flutter/material.dart';

class Settings extends StatefulWidget {
  Settings({Key key}) : super(key: key);

  @override
  _SettingsState createState() => _SettingsState();
}

class _SettingsState extends State<Settings> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: SingleChildScrollView(
          child: Container(
            margin: EdgeInsets.only(top: 15),
            child: Column(
              children: [
                Container(
                  margin: EdgeInsets.only(left: 15, bottom: 15, right: 15),
                  child: Row(
                    children: [
                      Icon(Icons.arrow_back),
                      Expanded(
                          child: Center(
                              child: Text(
                        "Settings",
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.w800,
                        ),
                      ))),
                    ],
                  ),
                ),
                Divider(
                  color: Colors.black,
                ),
                Container(
                  child: Column(
                    children: [
                      Container(
                        margin: EdgeInsets.all(10),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Icon(
                              Icons.perm_device_info_outlined,
                            ),
                            Container(
                              width: 300,
                              margin: EdgeInsets.only(left: 15,),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "Permission to Access Status",
                                    style: TextStyle(
                                        fontWeight: FontWeight.w500,
                                        fontSize: 16),
                                  ),
                                  Text(
                                    "External apps or Users that can access your Status",
                                    style: TextStyle(fontSize: 16),
                                  )
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                      Divider(
                        color: Colors.black,
                      ),
                      Container(
                        margin: EdgeInsets.all(10),
                        child: Row(
                          
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Icon(
                              Icons.delete_outline,
                            ),
                            Container(
                              width: 300,
                              margin: EdgeInsets.only(left: 15,),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "Delete My Account",
                                    style: TextStyle(
                                        fontWeight: FontWeight.w500,
                                        fontSize: 16),
                                  ),
                                  Text(
                                    "You can permanently delete your account and wipe all data",
                                    style: TextStyle(fontSize: 16),
                                  )
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                      Divider(
                        color: Colors.black,
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
