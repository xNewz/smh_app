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
  var cardTextStyle = TextStyle(fontFamily: "Prompt", fontSize: 16);
  final auth = FirebaseAuth.instance;
  @override
  Widget build(BuildContext context) => StreamBuilder(
        stream: databaseReference.child("Bed Room").onValue,
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
          if (snap.data!.snapshot.value["LED1"] == 1) {
            isSwitched_1 = true;
            print('LED1 = $isSwitched_1');
          } else {
            isSwitched_1 = false;
            print('LED1 = $isSwitched_1');
          }

          // Check Status (Firebase) LED 2
          if (snap.data!.snapshot.value["LED2"] == 1) {
            isSwitched_2 = true;
            print('LED2 = $isSwitched_2');
          } else {
            isSwitched_2 = false;
            print('LED2 = $isSwitched_2');
          }

          // Check Status (Firebase) LED 3
          if (snap.data!.snapshot.value["LED3"] == 1) {
            isSwitched_3 = true;
            print('LED3 = $isSwitched_3');
          } else {
            isSwitched_3 = false;
            print('LED3 = $isSwitched_3');
          }

          // Check Status (Firebase) LED 4
          if (snap.data!.snapshot.value["LED4"] == 1) {
            isSwitched_4 = true;
            print('LED4 = $isSwitched_4');
          } else {
            isSwitched_4 = false;
            print('LED4 = $isSwitched_4');
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
                            leading: Image.asset('assets/images/lamp.png'),
                            title: Text(
                              'LED1',
                              style:
                                  TextStyle(fontSize: 15, fontFamily: "Prompt"),
                            ),
                            subtitle: Text('LED Bed Room'),
                            trailing: Transform.scale(
                                scale: 1,
                                child: CupertinoSwitch(
                                  value: isSwitched_1,
                                  onChanged: (value) {
                                    setState(() {
                                      isSwitched_1 = value;
                                      if (isSwitched_1 == true) {
                                        databaseReference
                                            .child('Bed Room')
                                            .update({
                                          'LED1': 1,
                                        });
                                      } else {
                                        databaseReference
                                            .child('Bed Room')
                                            .update({
                                          'LED1': 0,
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
                            leading: Image.asset('assets/images/lamp.png'),
                            title: Text(
                              'LED2',
                              style:
                                  TextStyle(fontSize: 15, fontFamily: "Prompt"),
                            ),
                            subtitle: Text('LED Bed Room'),
                            trailing: Transform.scale(
                                scale: 1,
                                child: CupertinoSwitch(
                                  value: isSwitched_2,
                                  onChanged: (value) {
                                    setState(() {
                                      isSwitched_2 = value;
                                      if (isSwitched_2 == true) {
                                        databaseReference
                                            .child('Bed Room')
                                            .update({
                                          'LED2': 1,
                                        });
                                      } else {
                                        databaseReference
                                            .child('Bed Room')
                                            .update({
                                          'LED2': 0,
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
                            leading: Image.asset('assets/images/lamp.png'),
                            title: Text(
                              'LED3',
                              style:
                                  TextStyle(fontSize: 15, fontFamily: "Prompt"),
                            ),
                            subtitle: Text('LED Bed Room'),
                            trailing: Transform.scale(
                                scale: 1,
                                child: CupertinoSwitch(
                                  value: isSwitched_3,
                                  onChanged: (value) {
                                    setState(() {
                                      isSwitched_3 = value;
                                      if (isSwitched_3 == true) {
                                        databaseReference
                                            .child('Bed Room')
                                            .update({
                                          'LED3': 1,
                                        });
                                      } else {
                                        databaseReference
                                            .child('Bed Room')
                                            .update({
                                          'LED3': 0,
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
                            leading: Image.asset('assets/images/lamp.png'),
                            title: Text(
                              'LED4',
                              style:
                                  TextStyle(fontSize: 15, fontFamily: "Prompt"),
                            ),
                            subtitle: Text('LED Bed Room'),
                            trailing: Transform.scale(
                                scale: 1,
                                child: CupertinoSwitch(
                                  value: isSwitched_4,
                                  onChanged: (value) {
                                    setState(() {
                                      isSwitched_4 = value;
                                      if (isSwitched_4 == true) {
                                        databaseReference
                                            .child('Bed Room')
                                            .update({
                                          'LED4': 1,
                                        });
                                      } else {
                                        databaseReference
                                            .child('Bed Room')
                                            .update({
                                          'LED4': 0,
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
