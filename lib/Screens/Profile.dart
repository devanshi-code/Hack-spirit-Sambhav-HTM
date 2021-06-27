import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import "package:flutter/material.dart";
import 'package:Sambhav/Screens/Last_7_days.dart';
import 'package:Sambhav/Screens/Today.dart';
import 'package:Sambhav/helper/Constants.dart';
import 'package:Sambhav/helper/authenticate.dart';
import 'package:Sambhav/helper/helperfunction.dart';
import 'package:Sambhav/services/auth.dart';
import 'package:Sambhav/services/database.dart';
import 'package:Sambhav/views/map.dart';

class Profile extends StatefulWidget {
  Profile({Key key}) : super(key: key);

  @override
  _ProfileState createState() => _ProfileState();
}

class _ProfileState extends State<Profile> with SingleTickerProviderStateMixin {
  Databasemethods databasemethods = new Databasemethods();
  TabController _tabController;
  final FirebaseAuth _auth = FirebaseAuth.instance;
  User _user;

  @override
  void initState() {
    getuserinfo();
    getl();
    fetchUserData();
    super.initState();
    _tabController = new TabController(length: 2, vsync: this, initialIndex: 0);
  }
  showmap() {
    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => myMap(
                  name: _user.displayName,
                )));
  }

  getl() {
    databasemethods.savelocation();
  }

  Query collectionReference1;
  getuserinfo() async {
    await HelperFunction.getuserNameSharedPreference().then((value) {
      Constants.MyName = value;
      setState(() {
        collectionReference1 = getinfo();
      });
    });
  }

  AuthMethods authMethods = new AuthMethods();

  getinfo() {
    return FirebaseFirestore.instance
        .collection('ChatRomm')
        .where("users", arrayContains: Constants.MyName);
  }


  void fetchUserData() async {
    User u = await _auth.currentUser;
    setState(() {
      _user = u;
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Container(
          child: Column(
            children: [
              Container(
                margin: EdgeInsets.only(left: 10, right: 10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Icon(
                      Icons.chevron_left,
                      color: Colors.pink[500],
                    ),
                    Text(
                      "Profile",
                      style:
                          TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
                    ),
                    IconButton(
                        icon: Icon(Icons.exit_to_app,color: Colors.pink,),
                        onPressed: () {
                          authMethods.signOut();
                          Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => Authenticate()));
                        }),
                  ],
                ),
              ),
              Container(
                height: 202,
                width: MediaQuery.of(context).size.width,
                decoration: BoxDecoration(
                  color: Colors.grey[200],
                ),
                child: _user != null
                    ? Column(
                        children: [
                          Container(
                            margin: EdgeInsets.only(top: 20, left: 15),
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                ClipRRect(
                                  borderRadius: BorderRadius.circular(100),
                                  child: FadeInImage(
                                    width: 80,
                                    height: 80,
                                    image: NetworkImage("${_user.photoURL}"),
                                    placeholder: AssetImage("assets/img1.jpg"),
                                    fit: BoxFit.cover,
                                  ),
                                ),
                                Container(
                                  margin: EdgeInsets.only(left: 20),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        "${_user.displayName}",
                                        style: TextStyle(
                                            fontSize: 20,
                                            fontWeight: FontWeight.w500),
                                      ),
                                      Container(
                                          margin: EdgeInsets.only(
                                            top: 5,
                                          ),
                                          child: Row(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Icon(
                                                  Icons.phone_android_outlined),
                                              SizedBox(
                                                width: 5,
                                              ),
                                              Container(
                                                width: 200,
                                                child: Text(
                                                  "${_user.email}",
                                                  style: TextStyle(
                                                      fontSize: 16,
                                                      fontWeight:
                                                          FontWeight.w400,
                                                      color: Colors.grey[600]),
                                                ),
                                              )
                                            ],
                                          )),
                                          SizedBox(
                                            height: 10,
                                          ),
                                      Container(
                                          child: Row(
                                        children: [
                                          Icon(Icons.timeline),
                                          SizedBox(
                                            width: 5,
                                          ),
                                          Container(
                                            padding: EdgeInsets.all(6),
                                            decoration: BoxDecoration(
                                              color: Colors.pink[200],
                                              borderRadius: BorderRadius.circular(20)
                                            ),
                                            child: InkWell(
                                              child: Text(
                                                "Live status",
                                                style: TextStyle(
                                                    fontSize: 16,
                                                    fontWeight: FontWeight.w400,
                                                    color: Colors.white),
                                              ),
                                              onTap: (){
                                                showmap();
                                              },
                                            ),
                                          )
                                        ],
                                      ))
                                    ],
                                  ),
                                )
                              ],
                            ),
                          ),
                          SizedBox(
                            height: 40,
                          ),
                          Container(
                            child: TabBar(
                                indicatorColor: Colors.orange[300],
                                controller: _tabController,
                                tabs: <Widget>[
                                  new Tab(
                                    child: Text(
                                      "Today",
                                      style:
                                          TextStyle(color: Colors.pinkAccent),
                                    ),
                                  ),
                                  new Tab(
                                    child: Text(
                                      "last 7 Days",
                                      style:
                                          TextStyle(color: Colors.pinkAccent),
                                    ),
                                  )
                                ]),
                          )
                        ],
                      )
                    : (" "),
              ),
              Container(
                margin: EdgeInsets.all(15),
                height: 400,
                child: new TabBarView(
                    controller: _tabController,
                    children: <Widget>[
                      new Today(),
                      new LastWeek(),
                    ]),
              )
            ],
          ),
        ),
      ),
    );
  }
}
