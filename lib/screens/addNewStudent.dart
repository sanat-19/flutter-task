import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:task_1/screens/tabScreen.dart';

class AddNewStudent extends StatefulWidget {
  static const routeName = 'add-new-student/';
  @override
  _AddNewStudentState createState() => _AddNewStudentState();
}

class _AddNewStudentState extends State<AddNewStudent> {
  final dateFormat = DateFormat("EEEE, MMMM d, yyyy");
  DateTime _selectedDate;

  TextEditingController _date = TextEditingController();
  TextEditingController _nameController = TextEditingController();
  // TextEditingController _genderController = TextEditingController();

  var item = ['Male', 'Female', 'Other'];
  String dropDownValue, setDate;

  // ignore: non_constant_identifier_names
  final UID = FirebaseAuth.instance.currentUser.uid;
  User user;
  CollectionReference collectionReference =
      FirebaseFirestore.instance.collection("User");

  void _presentDatePicker() {
    showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(1900),
      lastDate: DateTime.now(),
    ).then((pickedDate) {
      if (pickedDate == null) {
        return;
      }
      setState(() {
        _selectedDate = pickedDate;
        _date.text = DateFormat.yMEd().format(_selectedDate);
      });
    });
  }

  String getText() {
    if (_selectedDate == null) {
      return 'Select date';
    } else {
      return '${_selectedDate.day}/${_selectedDate.month}/${_selectedDate.year}';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Form(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              alignment: Alignment.center,
              height: 50,
              width: MediaQuery.of(context).size.width * 1,
              padding: EdgeInsets.only(left: 10),
              child: Text(
                "Enter Student Details",
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 30,
                ),
              ),
            ),
            Container(
              padding: EdgeInsets.all(10),
              width: MediaQuery.of(context).size.width * 1,
              height: 65,
              child: TextFormField(
                controller: _nameController,
                // onSaved: (value) => _email = value,
                keyboardType: TextInputType.name,
                cursorHeight: 20,
                decoration: InputDecoration(
                  labelText: "Name",
                  border: OutlineInputBorder(),
                ),
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                  padding: EdgeInsets.all(10),
                  width: MediaQuery.of(context).size.width * 0.5,
                  height: 65,
                  child: TextFormField(
                    controller: _date,
                    onSaved: (value) {
                      setDate = value;
                    },
                    cursorHeight: 20,
                    decoration: InputDecoration(
                      // prefixText: getText(),
                      labelText: "Select DOB",
                      border: OutlineInputBorder(),
                    ),
                    onTap: _presentDatePicker,
                  ),
                ),
                Container(
                  padding: EdgeInsets.all(10),
                  width: MediaQuery.of(context).size.width * 0.5,
                  height: 65,
                  child: DropdownButtonFormField(
                    decoration: InputDecoration(
                      hintText: "Select Gender",
                    ),
                    onChanged: (String newValue) {
                      setState(() {
                        dropDownValue = newValue;
                      });
                    },
                    value: dropDownValue,
                    items: item.map((String item) {
                      return DropdownMenuItem(
                        value: item,
                        child: Text(item),
                      );
                    }).toList(),
                  ),
                ),
              ],
            ),
            Container(
              padding: EdgeInsets.only(top: 10, left: 10, right: 10),
              width: MediaQuery.of(context).size.width * 1,
              child: SizedBox(
                height: 45,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(elevation: 0),
                  onPressed: () async {
                    await collectionReference
                        .doc(UID)
                        .collection("Students")
                        .add({
                      'name': _nameController.text,
                      'dob': _date.text,
                      'gender': dropDownValue
                    }).then((value) {
                      _nameController.clear();
                      _date.clear();
                      Navigator.of(context)
                          .pushReplacementNamed(TabScreen.routeName);
                    });
                  },
                  child: Text(
                    "Create",
                    style:
                        TextStyle(fontSize: 20, fontFamily: "SF-Pro-Display"),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
