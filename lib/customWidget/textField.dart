import 'package:flutter/material.dart';

// ignore: must_be_immutable
class CustomTxtField extends StatelessWidget {
  TextEditingController controller;
  Function fun;
  String label;
  CustomTxtField({@required this.fun,@required this.label,@required this.controller});
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(top: 15.0, bottom: 15.0),
      child: TextField(
        controller: controller,
        keyboardType: (label!= "اسم الطالب"&& label!="تفاصيل")?TextInputType.phone:TextInputType.name,
        onChanged: (value) {
          fun(value);
        },
        decoration: InputDecoration(
            labelText:  label,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(5.0),
            )),
      ),
    );
  }
}
