import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:task_1/screens/signup.dart';
import 'package:task_1/screens/tabScreen.dart';

class Login extends StatefulWidget {
  static const routeName = 'login/';
  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  String _email, _password;
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final auth = FirebaseAuth.instance;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  login() async {
    if (_formKey.currentState.validate()) {
      _formKey.currentState.save();
      try {
        await auth.signInWithEmailAndPassword(
            email: _email, password: _password);
      } catch (e) {
        print(e);
      }
    }
  }

  checkAuthentification() async {
    auth.authStateChanges().listen((user) {
      if (user != null) {
        print(user);
        Navigator.of(context).pushReplacementNamed(TabScreen.routeName);
      }
    });
  }

  @override
  void initState() {
    super.initState();
    this.checkAuthentification();
  }

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
              "Welcome Back!",
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
            child: TextFormField(
              controller: emailController,
              onSaved: (value) => _email = value,
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
            child: TextFormField(
              controller: passwordController,
              onSaved: (value) => _password = value,
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
                  try {
                    await auth.signInWithEmailAndPassword(
                        email: emailController.text,
                        password: passwordController.text);
                    ScaffoldMessenger.of(context)
                        .showSnackBar(SnackBar(content: Text("Fetching Data")));
                    Navigator.of(context)
                        .pushReplacementNamed(TabScreen.routeName);
                  } catch (e) {
                    return ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                        content: Text("Incorrect Email Id or Password")));
                  }
                },
                child: Text(
                  "Login",
                  style: TextStyle(fontSize: 20, fontFamily: "SF-Pro-Display"),
                ),
              ),
            ),
          ),
          Container(
            child: TextButton(
              onPressed: () {
                Navigator.of(context).pushReplacementNamed(SignUp.routeName);
              },
              child: Text(
                "Not Registered yet? Register",
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
