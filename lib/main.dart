import 'package:flutter/material.dart';
import 'package:task_1/screens/addNewStudent.dart';
import 'package:task_1/screens/homePage.dart';
import 'package:task_1/screens/login.dart';
import 'package:task_1/screens/signup.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:task_1/screens/tabScreen.dart';
import 'package:task_1/screens/verify.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
          primarySwatch: Colors.blue,
          textTheme: ThemeData.light().textTheme.copyWith(
              bodyText1:
                  TextStyle(color: Colors.black, fontFamily: "SF-Pro-Display"),
              headline1: TextStyle(
                fontSize: 20,
                fontFamily: 'SF-Pro-Display',
              ))),
      initialRoute: 'login/',
      routes: {
        SignUp.routeName: (ctx) => SignUp(),
        Login.routeName: (ctx) => Login(),
        HomePage.routeName: (ctx) => HomePage(),
        Verify.routeName: (ctx) => Verify(),
        AddNewStudent.routeName: (ctx) => AddNewStudent(),
        TabScreen.routeName: (ctx) => TabScreen(),
      },
    );
  }
}
