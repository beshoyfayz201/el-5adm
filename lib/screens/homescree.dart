// @dart=2.9
import 'package:alkhadm/customWidget/custombottombar.dart';
import 'package:alkhadm/customWidget/mainbackgroud.dart';
import 'package:alkhadm/screens/alagbya.dart';
import 'package:flutter/material.dart';
import 'package:alkhadm/customWidget/appBar.dart';
import 'package:alkhadm/screens/paymentscreen.dart';
import 'package:alkhadm/screens/students_list.dart';

import 'tranim.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.grey.shade800,
        bottomNavigationBar: BottomAppBar(
            child: Row(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                SizedBox(
                  height: 50,
                  child: Padding(
                    padding: const EdgeInsets.only(left: 8.0),
                    child: Column(
                      children: [
                        TextButton.icon(
                          label: Text("Login"),
                          onPressed: () {},
                          icon: Icon(
                            Icons.login,
                            size: 30,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(
                  height: 50,
                  child: Column(
                    children: [
                      TextButton.icon(
                        label: Text("Settings      "),
                        onPressed: () {},
                        icon: Icon(
                          Icons.settings,
                          size: 30,
                        ),
                      ),
                    ],
                  ),
                )
              ],
            ),
            notchMargin: 15.0,
            shape: MyShape(),
            color: Colors.white),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
        floatingActionButton: Container(
          padding: EdgeInsets.all(20),
          child: Icon(
            Icons.home,
            size: 30,
            color: Colors.white,
          ),
          decoration: BoxDecoration(
              shape: BoxShape.circle,
              gradient: LinearGradient(colors: [
                Colors.deepOrangeAccent.shade700,
                Colors.orangeAccent
              ])),
        ),
        body: Stack(
          children: <Widget>[
            //custom draws back ground
            MainBackGround(),
            Padding(
              padding: EdgeInsets.only(top: 80.0),
              child: GridView.count(
                crossAxisCount: 2,
                children: <Widget>[
                  GestureDetector(
                    onTap: () {
                      Navigator.of(context).push(new MaterialPageRoute(
                          builder: (context) => StudentsList()));
                    },
                    child:
                        buildCard("سجل الطلاب", Icons.assignment_ind_outlined),
                  ),
                  GestureDetector(
                    onTap: () {
                      Navigator.of(context).push(new MaterialPageRoute(
                          builder: (context) => Alagbya()));
                    },
                    child: buildCard("ألاجبية", Icons.book_outlined),
                  ),
                  GestureDetector(
                    onTap: () {
                      Navigator.of(context).push(new MaterialPageRoute(
                          builder: (context) => Tranim()));
                    },
                    child: buildCard("الترانيم", Icons.music_note_outlined),
                  ),
                  GestureDetector(
                    onTap: () {
                      Navigator.of(context).push(new MaterialPageRoute(
                          builder: (context) => PaymentScreen()));
                    },
                    child: buildCard("الحسابات", Icons.shopping_bag_outlined),
                  ),
                  GestureDetector(
                    onTap: () {
                      Navigator.of(context).push(new MaterialPageRoute(
                          builder: (context) => StudentsList()));
                    },
                    child: buildCard("عن التطبيق", Icons.android_outlined),
                  ),
                ],
              ),
            ),
            Container(
              padding: EdgeInsets.only(top: 30),
              height: 100,
              child: Center(
                child: Text(
                  "خدمة شباب ثانوي   ",
                  style: TextStyle(
                      fontSize: 42, color: Colors.white, fontFamily: "kof"),
                ),
              ),
            )
          ],
        ));
  }
}
