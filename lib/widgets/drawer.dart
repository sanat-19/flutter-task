import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:task_1/screens/login.dart';

class MainDrawer extends StatelessWidget {
  final auth = FirebaseAuth.instance;
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(
        children: [
          Container(
            width: double.infinity,
            height: 100,
            padding: EdgeInsets.all(20),
            margin: EdgeInsets.only(
              top: 20,
            ),
            alignment: Alignment.centerLeft,
            child: Text(
              'My App',
              style: TextStyle(
                color: Colors.blue,
                fontSize: 25,
                fontWeight: FontWeight.w900,
              ),
            ),
          ),
          Divider(),
          ListTile(
            leading: Icon(Icons.logout),
            title: Text(
              'LogOut',
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
              ),
            ),
            onTap: () {
              auth.signOut();
              Navigator.of(context).pushReplacementNamed(Login.routeName);
            },
          ),
        ],
      ),
    );
  }
}
