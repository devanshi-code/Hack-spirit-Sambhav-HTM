import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:getwidget/getwidget.dart';
import 'package:Sambhav/Screens/Last_7_days.dart';
import 'package:Sambhav/Screens/Profile.dart';
import 'package:marquee/marquee.dart';
import 'package:Sambhav/Screens/Today.dart';
import 'package:Sambhav/views/ChatSrcreen.dart';

class Home extends StatefulWidget {
  Home({Key key}) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> with SingleTickerProviderStateMixin {
  TabController _controller;
  final FirebaseAuth _auth = FirebaseAuth.instance;
  User _user;
  TextEditingController AadharNumber = new TextEditingController();

  @override
  void initState() {
    fetchUserData();
    super.initState();
    _controller = new TabController(length: 5, vsync: this, initialIndex: 2);
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
        body: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              Stack(
                children: <Widget>[
                  Container(
                      height: 300,
                      width: MediaQuery.of(context).size.width,
                      decoration: BoxDecoration(
                        color: Colors.white,
                      )),
                  Positioned(
                      bottom: 210,
                      top: -70,
                      child: Container(
                          width: MediaQuery.of(context).size.width,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(100),
                            color: Colors.pink[100],
                          ))),
                  Container(
                    margin: EdgeInsets.only(top: 10),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Padding(
                            padding: EdgeInsets.only(left: 15.0),
                            child: InkWell(
                              onTap: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => Profile()));
                              },
                              child: Container(
                                alignment: Alignment.topLeft,
                                height: 50.0,
                                width: 50.0,
                                decoration: BoxDecoration(
                                    image: DecorationImage(
                                      image: NetworkImage("${_user.photoURL}"),
                                    ),
                                    borderRadius: BorderRadius.circular(25.0),
                                    border: Border.all(
                                      style: BorderStyle.solid,
                                      color: Colors.white,
                                      width: 2.0,
                                    )),
                              ),
                            )),
                        Container(
                          margin: EdgeInsets.only(right: 8),
                          alignment: Alignment.bottomCenter,
                          height: 50.0,
                          width: 200.0,
                          child: Text(
                            "Women Safety",
                            style: TextStyle(
                              fontSize: 25.0,
                              fontWeight: FontWeight.w600,
                              color: Colors.white,
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(right: 8.0),
                          child: Container(
                              height: 50.0,
                              width: 50.0,
                              child: IconButton(
                                icon: Icon(
                                  Icons.chat_sharp,
                                ),
                                onPressed: () {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) => ChatScreen()));
                                },
                                color: Colors.white,
                                iconSize: 30.0,
                              )),
                        )
                      ],
                    ),
                  ),
                  Positioned(
                    top: 100,
                    child: Container(
                      height: 200,
                      width: MediaQuery.of(context).size.width,
                      decoration: BoxDecoration(color: Colors.green[400]),
                      child: Column(
                        children: [
                          Container(
                            height: 70,
                            width: MediaQuery.of(context).size.width,
                            margin: EdgeInsets.all(15),
                            decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(25)),
                                child: Container(
                                  margin: EdgeInsets.only(top:5,left: 15,right: 15),
                                  padding: EdgeInsets.all(6),
                                  child: TextFormField(
                                    keyboardType: TextInputType.number,
                                    validator: (val) {
                                            if (!val.isEmpty) {
                                              if (val.length < 16) {
                                                return "Invalid Adhar Number";
                                              }
                                            } else if (val.isEmpty) {
                                              return "Invalid Aadhar Number";
                                            }
                                          },
                                          controller: AadharNumber,
                                          maxLength: 16,
                                          decoration: InputDecoration(
                                              enabledBorder: UnderlineInputBorder(
                                                  borderSide: BorderSide(
                                                      color: Colors.white)),
                                              focusedBorder: UnderlineInputBorder(
                                                  borderSide: BorderSide(
                                                      color: Colors.white)),
                                              hintText: "Aadhar Number"),
                                  ),
                                ),

                                
                          ),
                          
                          Container(
                            margin: EdgeInsets.only(top: 25, left: 20),
                            child: Row(
                              children: [
                                ClipRRect(
                                  borderRadius: BorderRadius.circular(100),
                                  child: FadeInImage(
                                    width: 60,
                                    height: 60,
                                    image: NetworkImage(
                                        "https://cdn.vox-cdn.com/thumbor/pOMbzDvdEWS8NIeUuhxp23wi_cU=/1400x1400/filters:format(png)/cdn.vox-cdn.com/uploads/chorus_asset/file/19700731/googlemaps.png"),
                                    placeholder: AssetImage("assets/img1.jpg"),
                                    fit: BoxFit.cover,
                                  ),
                                ),
                                SizedBox(
                                  width: 20,
                                ),
                                Container(
                                  child: Column(
                                    children: [
                                      Text(
                                        "Visited Places",
                                        style: TextStyle(
                                          fontSize: 26,
                                          fontWeight: FontWeight.bold,
                                          color: Colors.white,
                                        ),
                                      ),
                                      SizedBox(
                                        height: 5,
                                      ),
                                      Text(
                                        "SEE RECENT LOCATION",
                                        style: TextStyle(
                                          fontSize: 13,
                                          fontWeight: FontWeight.bold,
                                          color: Colors.white,
                                        ),
                                      ),
                                    ],
                                  ),
                                )
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
              Container(
                margin: EdgeInsets.only(top: 10),
                child: Column(
                  children: [
                    Container(
                      margin: EdgeInsets.only(left: 20, right: 20),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Container(
                              child: Row(
                            children: [
                              Icon(Icons.location_on),
                              Text("In your Range,within radius of",
                                  style: TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.w600)),
                            ],
                          )),
                          Icon(
                            Icons.help,
                            color: Colors.grey,
                          ),
                        ],
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.only(left: 20, right: 20),
                      child: TabBar(
                        controller: _controller,
                        labelPadding: EdgeInsets.all(0),
                        tabs: <Widget>[
                          Chip(label: Text("100 m")),
                          Chip(label: Text("500 m")),
                          Chip(label: Text("1 km")),
                          Chip(label: Text("2 km")),
                          Chip(label: Text("3 km")),
                        ],
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.all(15),
                      height: 70,
                      child: new TabBarView(controller: _controller, children: <
                          Widget>[
                        Container(
                          margin: EdgeInsets.only(left: 20, right: 20),
                          height: 70,
                          width: MediaQuery.of(context).size.width,
                          decoration: BoxDecoration(
                            color: Colors.grey[300],
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Container(
                            margin: EdgeInsets.all(8),
                            child: Marquee(
                              text: "Persons in Range 100 m ",
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 16,
                                  color: Colors.lightBlue[800]),
                              scrollAxis: Axis.vertical,
                              blankSpace: 20.0,
                              velocity: 30.0,
                              startPadding: 10.0,
                              accelerationDuration: Duration(seconds: 1),
                              accelerationCurve: Curves.linear,
                              decelerationDuration: Duration(milliseconds: 100),
                              decelerationCurve: Curves.easeOut,
                            ),
                          ),
                        ),
                        Container(
                          margin: EdgeInsets.only(left: 20, right: 20),
                          height: 70,
                          width: MediaQuery.of(context).size.width,
                          decoration: BoxDecoration(
                            color: Colors.grey[300],
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Container(
                            margin: EdgeInsets.all(8),
                            child: Marquee(
                              text: "Persons in Range 500 m",
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 16,
                                  color: Colors.lightBlue[800]),
                              scrollAxis: Axis.vertical,
                              blankSpace: 20.0,
                              velocity: 30.0,
                              startPadding: 10.0,
                              accelerationDuration: Duration(seconds: 1),
                              accelerationCurve: Curves.linear,
                              decelerationDuration: Duration(milliseconds: 100),
                              decelerationCurve: Curves.easeOut,
                            ),
                          ),
                        ),
                        Container(
                          margin: EdgeInsets.only(left: 20, right: 20),
                          height: 70,
                          width: MediaQuery.of(context).size.width,
                          decoration: BoxDecoration(
                            color: Colors.grey[300],
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Container(
                            margin: EdgeInsets.all(8),
                            child: Marquee(
                              text: "Persons in Range 1 km",
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 16,
                                  color: Colors.lightBlue[800]),
                              scrollAxis: Axis.vertical,
                              blankSpace: 20.0,
                              velocity: 40.0,
                              startPadding: 10.0,
                              accelerationDuration: Duration(seconds: 1),
                              accelerationCurve: Curves.linear,
                              decelerationDuration: Duration(milliseconds: 100),
                              decelerationCurve: Curves.easeOut,
                            ),
                          ),
                        ),
                        Container(
                          margin: EdgeInsets.only(left: 20, right: 20),
                          height: 70,
                          width: MediaQuery.of(context).size.width,
                          decoration: BoxDecoration(
                            color: Colors.grey[300],
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Container(
                            margin: EdgeInsets.all(8),
                            child: Marquee(
                              text: "Persons in Range 2 km",
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 16,
                                  color: Colors.lightBlue[800]),
                              scrollAxis: Axis.vertical,
                              blankSpace: 20.0,
                              velocity: 40.0,
                              startPadding: 10.0,
                              accelerationDuration: Duration(seconds: 1),
                              accelerationCurve: Curves.linear,
                              decelerationDuration: Duration(milliseconds: 100),
                              decelerationCurve: Curves.easeOut,
                            ),
                          ),
                        ),
                        Container(
                          margin: EdgeInsets.only(left: 20, right: 20),
                          height: 70,
                          width: MediaQuery.of(context).size.width,
                          decoration: BoxDecoration(
                            color: Colors.grey[300],
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Container(
                            margin: EdgeInsets.all(8),
                            child: Marquee(
                              text: "Persons in Range 3 km",
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 16,
                                  color: Colors.lightBlue[800]),
                              scrollAxis: Axis.vertical,
                              blankSpace: 20.0,
                              velocity: 40.0,
                              startPadding: 10.0,
                              accelerationDuration: Duration(seconds: 1),
                              accelerationCurve: Curves.linear,
                              decelerationDuration: Duration(milliseconds: 100),
                              decelerationCurve: Curves.easeOut,
                            ),
                          ),
                        ),
                      ]),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 20,
              ),
              Container(
                margin: EdgeInsets.only(left: 20, right: 20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      height: 100,
                      width: MediaQuery.of(context).size.width,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(15),
                          color: Colors.red.shade900),
                          child: Container(
                            margin:EdgeInsets.only(top:22,left:12,right:12),
                            child: Text("A women is a country's fate, do not put her life at stake.",style: TextStyle(color:Colors.white,fontSize:20,fontWeight:FontWeight.w500),)),
                    )
                  ],
                ),
              ),
              SizedBox(
                height: 30,
              ),
              Container(
                margin: EdgeInsets.only(left: 20, right: 20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Helpline Numbers",
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Container(
                      height: 80,
                      width: MediaQuery.of(context).size.width,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(15),
                          color: Colors.blue[50]),
                          child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Container(
                                margin: EdgeInsets.all(12),
                                child: Text("All over India",style: TextStyle(fontSize: 16,fontWeight: FontWeight.w500),)),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Container(
                                    
                                      child: Icon(Icons.phone_in_talk,color: Colors.blue,)),
                                    Container(
                                    margin: EdgeInsets.only(left:12),
                                    child: Text("1091/ 100/ 102 ",style: TextStyle(fontSize: 20,fontWeight: FontWeight.w500),)),
                                  ],
                                )
                            ],
                          ),
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    Container(
                      height: 80,
                      width: MediaQuery.of(context).size.width,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(15),
                          color: Colors.blue[50]),
                          child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Container(
                                margin: EdgeInsets.all(12),
                                child: Text("Delhi women Protection cell",style: TextStyle(fontSize: 16,fontWeight: FontWeight.w500),)),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Container(
                                    
                                      child: Icon(Icons.phone_in_talk,color: Colors.blue,)),
                                    Container(
                                    margin: EdgeInsets.only(left:12),
                                    child: Text("011-24673366/ 4156/ 7699",style: TextStyle(fontSize: 20,fontWeight: FontWeight.w500),)),
                                  ],
                                )
                            ],
                          ),
                    )
                  ],
                ),
              ),
              SizedBox(
                height: 30,
              ),
              Container(
                margin: EdgeInsets.only(left: 20, right: 20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Media",
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Container(
                      height: 150,
                      width: MediaQuery.of(context).size.width,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(15),
                          color: Colors.white),
                      child: Container(
                        margin: EdgeInsets.all(8),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Safety procedure",
                              style: TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                            Container(
                              width: 350,
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: [
                                  Container(
                                    margin:
                                        EdgeInsets.only(top: 10, bottom: 10),
                                    height: 100,
                                    width: 60,
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(10),
                                        border:
                                            Border.all(color: Colors.black),
                                            image:DecorationImage(
                                              image:NetworkImage("https://thumbs.gfycat.com/NegativePlaintiveCatfish-max-1mb.gif"),
                                              fit:BoxFit.cover
                                            )),
                                  ),
                                  Container(
                                    margin:
                                        EdgeInsets.only(top: 10, bottom: 10),
                                    height: 100,
                                    width: 60,
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(10),
                                        border:
                                            Border.all(color: Colors.black),
                                            image:DecorationImage(
                                              image:NetworkImage("https://thumbs.gfycat.com/DecimalWeightyGrayreefshark-size_restricted.gif"),
                                              fit:BoxFit.cover
                                            )
                                            ),
                                  ),
                                  Container(
                                    margin:
                                        EdgeInsets.only(top: 10, bottom: 10),
                                    height: 100,
                                    width: 60,
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(10),
                                        border:
                                            Border.all(color: Colors.black),
                                            image:DecorationImage(
                                              image:NetworkImage("https://thumbs.gfycat.com/FrenchFatGalapagosmockingbird-size_restricted.gif"),
                                              fit:BoxFit.cover
                                            )),
                                  ),
                                  Container(
                                    margin:
                                        EdgeInsets.only(top: 10, bottom: 10),
                                    height: 100,
                                    width: 60,
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(10),
                                        border:
                                            Border.all(color: Colors.black),
                                            image:DecorationImage(
                                              image:NetworkImage("https://thumbs.gfycat.com/SarcasticSilverDouglasfirbarkbeetle-size_restricted.gif"),
                                              fit:BoxFit.cover
                                            )),
                                  ),
                                  Container(
                                    margin:
                                        EdgeInsets.only(top: 10, bottom: 10),
                                    height: 100,
                                    width: 60,
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(10),
                                        border:
                                            Border.all(color: Colors.black),
                                            image:DecorationImage(
                                              image:NetworkImage("https://thumbs.gfycat.com/NegativePlaintiveCatfish-size_restricted.gif"),
                                              fit:BoxFit.cover
                                            )),
                                  )
                                ],
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
