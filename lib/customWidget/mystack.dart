import 'package:flutter/material.dart';

// ignore: must_be_immutable
class MyStack extends StatelessWidget {
  Widget widget;
  MyStack({ this.widget});
  @override
  Widget build(BuildContext context) {
    return Stack(
      fit: StackFit.expand,
      children: <Widget>[
        Container(
          color: Color.fromRGBO(253, 253, 254, 1),
        ),
        Column(
          children: <Widget>[
            Expanded(child: widget),
          ],
        )
      ],
    );
  }
}
