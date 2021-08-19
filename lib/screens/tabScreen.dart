import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:task_1/screens/addNewStudent.dart';
import 'package:task_1/screens/homePage.dart';
import 'package:task_1/widgets/drawer.dart';

class TabScreen extends StatefulWidget {
  static const routeName = 'tab-screen/';
  @override
  _TabScreenState createState() => _TabScreenState();
}

class _TabScreenState extends State<TabScreen> {
  final auth = FirebaseAuth.instance;

  int _selectpageIndex = 0;

  void _selectPage(int index) {
    setState(() {
      _selectpageIndex = index;
    });
  }

  final List<Map> _page = [
    {
      'page': HomePage(),
      'title': "Home Page",
    },
    {
      'page': AddNewStudent(),
      'title': "Add New Student",
    }
  ];

  final List<Widget> _pages = [
    HomePage(),
    AddNewStudent(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: Container(
        width: MediaQuery.of(context).size.width * 0.7,
        child: MainDrawer(),
      ),
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        iconTheme: IconThemeData(color: Colors.black),
        title: Text(
          _page[_selectpageIndex]['title'],
          style: TextStyle(color: Colors.black),
        ),
      ),
      // drawer: MainDrawer(),
      body: _pages[_selectpageIndex],
      bottomNavigationBar: BottomNavigationBar(
        onTap: _selectPage,
        selectedItemColor: Colors.blue,
        unselectedItemColor: Colors.grey,
        currentIndex: _selectpageIndex,
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'HomePage',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.add),
            label: 'Add New Student',
          )
        ],
      ),
    );
  }
}
