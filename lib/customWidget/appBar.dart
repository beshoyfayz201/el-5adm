import 'package:flutter/material.dart';

AppBar buildAppBar(String tit) {
  return AppBar(
    title: Text(
      tit,
      style: TextStyle(color: Colors.amber[50], fontSize: 25),
      textDirection: TextDirection.ltr,
    ),
    centerTitle: true,
  );
}

Widget buildCard(String tx, IconData iconData) {
  return Container(
      margin: EdgeInsets.all(20),
      decoration: BoxDecoration(
          color: Colors.grey.shade200.withOpacity(0.9),
          borderRadius: BorderRadius.circular(20)),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            iconData,
            size: 60,
            color: Colors.deepOrangeAccent.shade400,
          ),
          Text(
            tx,
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600),
          )
        ],
      ));
}
