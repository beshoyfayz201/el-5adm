// @dart=2.9
import 'package:flutter/material.dart';

// ignore: must_be_immutable
class Myybutton extends StatelessWidget {
  Function tab;
  String label;
  Myybutton({this.tab, this.label});
  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          primary: Colors.red[500],
          elevation: 6,
          textStyle: TextStyle(
            color: Colors.white,
          ),
        ),
        child: Text(
          label,
          textScaleFactor: 1.5,
        ),
        onPressed: () {
          tab();
        },
      ),
    );
  }
}

// ignore: must_be_immutable
class FloatingButton extends StatelessWidget {
  Function clckd;

  FloatingButton({this.clckd});
  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
        backgroundColor: Colors.orangeAccent.shade700,
        onPressed: () {
          clckd();
        },
        tooltip: 'اضافة طالب',
        child: Icon(Icons.add));
  }
}
