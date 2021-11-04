import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:form_field_validator/form_field_validator.dart';
import 'package:smh_app/Screens/MainScreen.dart';
import 'package:smh_app/Screens/Profile.dart';
import 'package:smh_app/Screens/RegisterScreen.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final formKey = GlobalKey<FormState>();
  Profile profile = Profile(email: '', password: '', password2: '');
  final Future<FirebaseApp> firebase = Firebase.initializeApp();

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: firebase,
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return Scaffold(
              appBar: AppBar(
                title: Text('Error'),
              ),
              body: Center(
                child: Text('${snapshot.error}'),
              ),
            );
          }
          if (snapshot.connectionState == ConnectionState.done) {
            return Scaffold(
                backgroundColor: Colors.white,
                body: Container(
                  child: Form(
                    key: formKey,
                    child: SingleChildScrollView(
                      child: Column(
                        children: <Widget>[
                          Container(
                            height: 400,
                            decoration: BoxDecoration(
                                image: DecorationImage(
                                    image: AssetImage(
                                        'assets/images/login/background.png'),
                                    fit: BoxFit.fill)),
                            child: Stack(
                              children: <Widget>[
                                Positioned(
                                    left: 30,
                                    width: 80,
                                    height: 200,
                                    child: Container(
                                      decoration: BoxDecoration(
                                          image: DecorationImage(
                                              image: AssetImage(
                                                  'assets/images/login/light-1.png'))),
                                    )),
                                Positioned(
                                    left: 140,
                                    width: 80,
                                    height: 150,
                                    child: Container(
                                      decoration: BoxDecoration(
                                          image: DecorationImage(
                                              image: AssetImage(
                                                  'assets/images/login/light-2.png'))),
                                    )),
                                Positioned(
                                    right: 40,
                                    top: 40,
                                    width: 80,
                                    height: 150,
                                    child: Container(
                                      decoration: BoxDecoration(
                                          image: DecorationImage(
                                              image: AssetImage(
                                                  'assets/images/login/clock.png'))),
                                    )),
                                Positioned(
                                  child: Container(
                                    margin: EdgeInsets.only(top: 50),
                                    child: Center(
                                      child: Text(
                                        "เข้าสู่ระบบ",
                                        style: TextStyle(
                                            color: Colors.white,
                                            fontSize: 40,
                                            fontWeight: FontWeight.bold,
                                            fontFamily: "Prompt"),
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.all(30),
                            child: Column(
                              children: <Widget>[
                                Container(
                                  padding: EdgeInsets.all(5),
                                  decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius: BorderRadius.circular(10),
                                      boxShadow: [
                                        BoxShadow(
                                            color: Color.fromRGBO(
                                                143, 148, 251, .3),
                                            blurRadius: 20,
                                            offset: Offset(0, 10))
                                      ]),
                                  child: Column(
                                    children: <Widget>[
                                      Container(
                                        padding: EdgeInsets.all(8),
                                        decoration: BoxDecoration(
                                            border: Border(
                                                bottom: BorderSide(
                                                    color:
                                                        Colors.grey.shade100))),
                                        child: TextFormField(
                                          validator: MultiValidator([
                                            RequiredValidator(
                                                errorText: "กรุณาป้อนอีเมล"),
                                            EmailValidator(
                                                errorText:
                                                    "คุณป้อนอีเมลไม่ถูกต้อง")
                                          ]),
                                          keyboardType:
                                              TextInputType.emailAddress,
                                          onSaved: (email) {
                                            profile.email = email!;
                                          },
                                          decoration: InputDecoration(
                                            border: InputBorder.none,
                                            hintText: "Email",
                                            hintStyle: TextStyle(
                                                color: Colors.grey[400],
                                                fontFamily: "Prompt"),
                                            errorStyle: TextStyle(
                                                color: Colors.red[400],
                                                fontSize: 13,
                                                fontFamily: "Prompt"),
                                          ),
                                        ),
                                      ),
                                      Container(
                                        padding: EdgeInsets.all(8),
                                        decoration: BoxDecoration(
                                            border: Border(
                                                bottom: BorderSide(
                                                    color:
                                                        Colors.grey.shade100))),
                                        child: TextFormField(
                                          validator: RequiredValidator(
                                              errorText: "กรุณาป้อนรหัสผ่าน"),
                                          obscureText: true,
                                          onSaved: (password) {
                                            profile.password = password!;
                                          },
                                          decoration: InputDecoration(
                                            border: InputBorder.none,
                                            hintText: "Password",
                                            hintStyle: TextStyle(
                                                color: Colors.grey[400],
                                                fontFamily: "Prompt"),
                                            errorStyle: TextStyle(
                                                color: Colors.red,
                                                fontSize: 13,
                                                fontFamily: "Prompt"),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                SizedBox(
                                  height: 30,
                                ),
                                Container(
                                  height: 50.0,
                                  margin: EdgeInsets.all(10),
                                  // ignore: deprecated_member_use
                                  child: RaisedButton(
                                    onPressed: () async {
                                      if (formKey.currentState!.validate()) {
                                        formKey.currentState!.save();
                                        try {
                                          await FirebaseAuth.instance
                                              .signInWithEmailAndPassword(
                                                  email: profile.email,
                                                  password: profile.password)
                                              .then((value) {
                                            formKey.currentState!.reset();
                                            Navigator.pushReplacement(context,
                                                MaterialPageRoute(
                                                    builder: (context) {
                                              return MainScreen();
                                            }));
                                          });
                                        } on FirebaseAuthException catch (e) {
                                          Fluttertoast.showToast(
                                              msg: '${e.message}',
                                              gravity: ToastGravity.CENTER);
                                        }
                                      }
                                    },
                                    shape: RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(80.0)),
                                    padding: EdgeInsets.all(0.0),
                                    child: Ink(
                                      decoration: BoxDecoration(
                                          gradient: LinearGradient(
                                            colors: [
                                              Colors.blue.shade50,
                                              Colors.blueAccent.shade700
                                            ],
                                            begin: Alignment.centerLeft,
                                            end: Alignment.centerRight,
                                          ),
                                          borderRadius:
                                              BorderRadius.circular(30.0)),
                                      child: Container(
                                        constraints: BoxConstraints(
                                            maxWidth: 250.0, minHeight: 50.0),
                                        alignment: Alignment.center,
                                        child: Text(
                                          "เข้าสู่ระบบ",
                                          textAlign: TextAlign.center,
                                          style: TextStyle(
                                              color: Colors.white,
                                              fontSize: 20,
                                              fontFamily: "Prompt"),
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                                TextButton(
                                  style: TextButton.styleFrom(
                                    textStyle: const TextStyle(
                                        color: Colors.blue,
                                        fontFamily: "Prompt",
                                        fontSize: 12),
                                  ),
                                  onPressed: () {},
                                  child: const Text("Forget password?"),
                                ),
                                TextButton(
                                  style: TextButton.styleFrom(
                                    textStyle: const TextStyle(
                                        color: Colors.blue,
                                        fontFamily: "Prompt",
                                        fontSize: 12),
                                  ),
                                  onPressed: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) => RegisterScreen()),
                                    );
                                  },
                                  child: const Text("Don't have an account?"),
                                ),
                              ],
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                ));
          }
          return Scaffold(
            appBar: AppBar(
              title: Text('Loading'),
            ),
            body: Center(
              child: CircularProgressIndicator(),
            ),
          );
        });
  }
}
