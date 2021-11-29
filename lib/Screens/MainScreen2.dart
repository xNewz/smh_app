import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_auth/firebase_auth.dart';

class MainScreen extends StatefulWidget {
  @override
  _MainScreenState createState() => _MainScreenState();
}

DatabaseReference databaseReference = FirebaseDatabase().reference();

class _MainScreenState extends State<MainScreen> {
  bool isSwitched_1 = false;
  bool isSwitched_2 = false;
  bool isSwitched_3 = false;
  bool isSwitched_4 = false;
  bool isSwitched_5 = false;
  var cardTextStyle = TextStyle(fontFamily: "Prompt", fontSize: 16);
  final auth = FirebaseAuth.instance;
  @override
  Widget build(BuildContext context) => StreamBuilder(
        stream: databaseReference.child("LED Status").onValue,
        builder: (context, AsyncSnapshot<Event> snap) {
          if (!snap.hasData)
            return Scaffold(
                appBar: AppBar(
                  title: Text('Firebase not connected !'),
                ),
                body: Center(
                  child: CircularProgressIndicator(),
                ));
          // Check Status (Firebase) LED 1
          if (snap.data!.snapshot.value["bed_room"] == 1) {
            isSwitched_1 = true;
            print('Bed Room = $isSwitched_1');
          } else {
            isSwitched_1 = false;
            print('Bed Room = $isSwitched_1');
          }

          // Check Status (Firebase) LED 2
          if (snap.data!.snapshot.value["bathroom"] == 1) {
            isSwitched_2 = true;
            print('Bathroom = $isSwitched_2');
          } else {
            isSwitched_2 = false;
            print('Bathroom = $isSwitched_2');
          }

          // Check Status (Firebase) LED 3
          if (snap.data!.snapshot.value["kitchen"] == 1) {
            isSwitched_3 = true;
            print('Kitchen = $isSwitched_3');
          } else {
            isSwitched_3 = false;
            print('Kitchen = $isSwitched_3');
          }

          // Check Status (Firebase) LED 4
          if (snap.data!.snapshot.value["living_room"] == 1) {
            isSwitched_4 = true;
            print('Living Room = $isSwitched_4');
          } else {
            isSwitched_4 = false;
            print('Living Room = $isSwitched_4');
          }

          // Check Status (Firebase) LED 5
          if (snap.data!.snapshot.value["front_light"] == 1) {
            isSwitched_5 = true;
            print('Front Light = $isSwitched_5');
          } else {
            isSwitched_5 = false;
            print('Front Light = $isSwitched_5');
          }
          // return Text(snap.data!.snapshot.value["LED Status"].toString());
          return Scaffold(
            body: Stack(
              children: <Widget>[
                Positioned.fill(
                  child: Image(
                    image: AssetImage("assets/images/bg.jpg"),
                    fit: BoxFit.cover,
                  ),
                ),
                SafeArea(
                  child: Padding(
                    padding: EdgeInsets.all(16.0),
                    child: Column(
                      children: <Widget>[
                        Container(
                          height: 64,
                          margin: EdgeInsets.only(bottom: 20),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              CircleAvatar(
                                radius: 32,
                                backgroundImage:
                                    AssetImage('assets/images/profile.jpg'),
                              ),
                              SizedBox(
                                width: 16,
                              ),
                              Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  Text(
                                    '${auth.currentUser!.email}',
                                    style: TextStyle(
                                        fontSize: 18,
                                        fontFamily: "Prompt",
                                        color: Colors.white),
                                  ),
                                  Text(
                                    'Welcome to Smart Home Application',
                                    style: TextStyle(
                                        fontSize: 14,
                                        color: Colors.white,
                                        fontFamily: "Prompt"),
                                  )
                                ],
                              )
                            ],
                          ),
                        ),
                        // Container(
                        //   height: 30,
                        //   child: Text(
                        //     'Bed Room',
                        //     style:
                        //         TextStyle(fontSize: 14, fontFamily: "Prompt"),
                        //   ),
                        // ),
                        Container(
                          margin: EdgeInsets.only(bottom: 20),
                          height: 70,
                          width: 390,
                          decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(8),
                              boxShadow: [
                                BoxShadow(
                                    color: Colors.black54,
                                    offset: Offset(3, 5),
                                    blurRadius: 9,
                                    spreadRadius: 1)
                              ]),
                          child: ListTile(
                            leading: Image.asset('assets/images/bed.png'),
                            title: Text(
                              'หลอดไฟ',
                              style:
                                  TextStyle(fontSize: 15, fontFamily: "Prompt"),
                            ),
                            subtitle: Text('ห้องนอน',
                                style: TextStyle(
                                    fontSize: 15, fontFamily: "Prompt")),
                            trailing: Transform.scale(
                                scale: 1,
                                child: CupertinoSwitch(
                                  value: isSwitched_1,
                                  onChanged: (value) {
                                    setState(() {
                                      isSwitched_1 = value;
                                      if (isSwitched_1 == true) {
                                        databaseReference
                                            .child('LED Status')
                                            .update({
                                          'bed_room': 1,
                                        });
                                      } else {
                                        databaseReference
                                            .child('LED Status')
                                            .update({
                                          'bed_room': 0,
                                        });
                                      }
                                    });
                                  },
                                )),
                          ),
                        ),
                        Container(
                          margin: EdgeInsets.only(bottom: 20),
                          height: 70,
                          width: 390,
                          decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(8),
                              boxShadow: [
                                BoxShadow(
                                    color: Colors.black54,
                                    offset: Offset(3, 5),
                                    blurRadius: 9,
                                    spreadRadius: 1)
                              ]),
                          child: ListTile(
                            leading: Image.asset('assets/images/bath.png'),
                            title: Text(
                              'หลอดไฟ',
                              style:
                                  TextStyle(fontSize: 15, fontFamily: "Prompt"),
                            ),
                            subtitle: Text('ห้องน้ำ',
                                style: TextStyle(
                                    fontSize: 15, fontFamily: "Prompt")),
                            trailing: Transform.scale(
                                scale: 1,
                                child: CupertinoSwitch(
                                  value: isSwitched_2,
                                  onChanged: (value) {
                                    setState(() {
                                      isSwitched_2 = value;
                                      if (isSwitched_2 == true) {
                                        databaseReference
                                            .child('LED Status')
                                            .update({
                                          'bathroom': 1,
                                        });
                                      } else {
                                        databaseReference
                                            .child('LED Status')
                                            .update({
                                          'bathroom': 0,
                                        });
                                      }
                                    });
                                  },
                                )),
                          ),
                        ),
                        Container(
                          margin: EdgeInsets.only(bottom: 20),
                          height: 70,
                          width: 390,
                          decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(8),
                              boxShadow: [
                                BoxShadow(
                                    color: Colors.black54,
                                    offset: Offset(3, 5),
                                    blurRadius: 9,
                                    spreadRadius: 1)
                              ]),
                          child: ListTile(
                            leading: Image.asset('assets/images/kitchen.png'),
                            title: Text(
                              'หลอดไฟ',
                              style:
                                  TextStyle(fontSize: 15, fontFamily: "Prompt"),
                            ),
                            subtitle: Text('ห้องครัว',
                                style: TextStyle(
                                    fontSize: 15, fontFamily: "Prompt")),
                            trailing: Transform.scale(
                                scale: 1,
                                child: CupertinoSwitch(
                                  value: isSwitched_3,
                                  onChanged: (value) {
                                    setState(() {
                                      isSwitched_3 = value;
                                      if (isSwitched_3 == true) {
                                        databaseReference
                                            .child('LED Status')
                                            .update({
                                          'kitchen': 1,
                                        });
                                      } else {
                                        databaseReference
                                            .child('LED Status')
                                            .update({
                                          'kitchen': 0,
                                        });
                                      }
                                    });
                                  },
                                )),
                          ),
                        ),
                        Container(
                          margin: EdgeInsets.only(bottom: 20),
                          height: 70,
                          width: 390,
                          decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(8),
                              boxShadow: [
                                BoxShadow(
                                    color: Colors.black54,
                                    offset: Offset(3, 5),
                                    blurRadius: 9,
                                    spreadRadius: 1)
                              ]),
                          child: ListTile(
                            leading: Image.asset('assets/images/back.png'),
                            title: Text(
                              'หลอดไฟ',
                              style:
                                  TextStyle(fontSize: 15, fontFamily: "Prompt"),
                            ),
                            subtitle: Text('ห้องรับแขก',
                                style: TextStyle(
                                    fontSize: 15, fontFamily: "Prompt")),
                            trailing: Transform.scale(
                                scale: 1,
                                child: CupertinoSwitch(
                                  value: isSwitched_4,
                                  onChanged: (value) {
                                    setState(() {
                                      isSwitched_4 = value;
                                      if (isSwitched_4 == true) {
                                        databaseReference
                                            .child('LED Status')
                                            .update({
                                          'living_room': 1,
                                        });
                                      } else {
                                        databaseReference
                                            .child('LED Status')
                                            .update({
                                          'living_room': 0,
                                        });
                                      }
                                    });
                                  },
                                )),
                          ),
                        ),
                        Container(
                          margin: EdgeInsets.only(bottom: 20),
                          height: 70,
                          width: 390,
                          decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(8),
                              boxShadow: [
                                BoxShadow(
                                    color: Colors.black54,
                                    offset: Offset(3, 5),
                                    blurRadius: 9,
                                    spreadRadius: 1)
                              ]),
                          child: ListTile(
                            leading: Image.asset('assets/images/garden.png'),
                            title: Text(
                              'หลอดไฟ',
                              style:
                                  TextStyle(fontSize: 15, fontFamily: "Prompt"),
                            ),
                            subtitle: Text('หน้าบ้าน',
                                style: TextStyle(
                                    fontSize: 15, fontFamily: "Prompt")),
                            trailing: Transform.scale(
                                scale: 1,
                                child: CupertinoSwitch(
                                  value: isSwitched_5,
                                  onChanged: (value) {
                                    setState(() {
                                      isSwitched_5 = value;
                                      if (isSwitched_5 == true) {
                                        databaseReference
                                            .child('LED Status')
                                            .update({
                                          'front_light': 1,
                                        });
                                      } else {
                                        databaseReference
                                            .child('LED Status')
                                            .update({
                                          'front_light': 0,
                                        });
                                      }
                                    });
                                  },
                                )),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          );
        },
      );
}
