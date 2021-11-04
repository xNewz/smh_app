import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({Key? key}) : super(key: key);

  @override
  _MainScreenState createState() => _MainScreenState();
}

DatabaseReference databaseReference = FirebaseDatabase().reference();

class _MainScreenState extends State<MainScreen> {
  bool value = true;

  @override
  Widget build(BuildContext context) => StreamBuilder(
        stream: databaseReference.child("Room").onValue,
        builder: (context, AsyncSnapshot<Event> snap) {
          if (!snap.hasData)
            return Scaffold(
                appBar: AppBar(
                  title: Text('Test Firebase'),
                ),
                body: Center(
                  child: CircularProgressIndicator(),
                ));
          // Check Status (Firebase)
          if (snap.data!.snapshot.value["LED Status"] == 1) {
            value = true;
            print('value = $value');
          } else {
            value = false;
            print('value = $value');
          }
          // return Text(snap.data!.snapshot.value["LED Status"].toString());
          return Scaffold(
            appBar: AppBar(
              title: Text('Test Firebase'),
            ),
            body: Center(
              child: Column(
                children: [
                  Spacer(),
                  Image.asset(
                    value ? 'assets/on.png' : 'assets/off.png',
                    height: 300,
                  ),
                  Spacer(),
                  Expanded(
                    child: buildHeader(
                      text: value ? 'ON' : 'OFF',
                      child: CupertinoSwitch(
                        value: value,
                        onChanged: (value) {
                          setState(() {
                            this.value = value;
                            if (this.value == true) {
                              databaseReference.child('Room').set({
                                'LED Status': 1,
                              });
                            } else {
                              databaseReference.child('Room').set({
                                'LED Status': 0,
                              });
                            }
                          });
                        },
                      ),
                    ),
                  ),
                  Spacer(),
                  const SizedBox(height: 12),
                ],
              ),
            ),
          );
        },
      );
}

Widget buildHeader({
  required Widget child,
  required String text,
}) =>
    Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Text(
          text,
          style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 8),
        child,
      ],
    );
