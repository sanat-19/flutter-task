import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:task_1/screens/login.dart';
import 'package:task_1/screens/verify.dart';

class SignUp extends StatefulWidget {
  static const routeName = 'signup/';

  @override
  _SignUpState createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  String _email, _password;
  final auth = FirebaseAuth.instance;
  final _confirmpasswordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            alignment: Alignment.center,
            height: 50,
            width: MediaQuery.of(context).size.width * 1,
            padding: EdgeInsets.only(left: 10),
            child: Text(
              "Welcome to my App!",
              textAlign: TextAlign.center,
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 35,
              ),
            ),
          ),
          Container(
            padding: EdgeInsets.all(10),
            width: MediaQuery.of(context).size.width * 1,
            height: 65,
            child: TextField(
              onChanged: (value) {
                setState(() {
                  _email = value.trim();
                });
              },
              keyboardType: TextInputType.emailAddress,
              cursorHeight: 20,
              decoration: InputDecoration(
                labelText: "Please enter valid Email Id",
                border: OutlineInputBorder(),
              ),
            ),
          ),
          Container(
            padding: EdgeInsets.all(10),
            width: MediaQuery.of(context).size.width * 1,
            height: 65,
            child: TextField(
              controller: _confirmpasswordController,
              onChanged: (value) {
                setState(() {
                  _password = value.trim();
                });
              },
              obscureText: true,
              cursorHeight: 20,
              decoration: InputDecoration(
                labelText: "Password",
                border: OutlineInputBorder(),
              ),
            ),
          ),
          Container(
            padding: EdgeInsets.only(top: 10, left: 10, right: 10),
            width: MediaQuery.of(context).size.width * 1,
            child: SizedBox(
              height: 45,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(elevation: 0),
                onPressed: () async {
                  // ignore: unrelated_type_equality_checks
                  try {
                    auth
                        .createUserWithEmailAndPassword(
                            email: _email,
                            password: _confirmpasswordController.text)
                        .then((_) {
                      Navigator.of(context)
                          .pushReplacementNamed(Verify.routeName);
                    });
                  } catch (e) {
                    return ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                        content: Text(
                            "There is some problem in the app. Please try again later!")));
                  }
                },
                child: Text(
                  "Register",
                  style: TextStyle(fontSize: 20),
                ),
              ),
            ),
          ),
          Container(
            // padding: EdgeInsets.only(top: 10),
            child: TextButton(
              onPressed: () {
                Navigator.of(context).pushReplacementNamed(Login.routeName);
              },
              child: Text(
                "Already Registered? Login",
                style: TextStyle(
                  color: Colors.blue,
                  fontSize: 14,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
