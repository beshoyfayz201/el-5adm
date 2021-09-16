// @dart=2.9
import 'package:alkhadm/consts.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:alkhadm/customWidget/buttons.dart';
import 'package:alkhadm/customWidget/textField.dart';

import 'package:alkhadm/models/student.dart';

import '../sql_helper.dart';

// ignore: must_be_immutable
class StudentDetail extends StatefulWidget {
  String screenTitle;
  Student student;

  StudentDetail(this.student, this.screenTitle);

  @override
  State<StatefulWidget> createState() {
    return Students(this.student, screenTitle);
  }
}

class Students extends State<StudentDetail> {
  static var _status = ["منتظم", "منقطع"];
  String screenTitle;
  Student student;
  SQL_Helper helper = new SQL_Helper();

  Students(this.student, this.screenTitle);

  TextEditingController studentName = new TextEditingController();
  TextEditingController studentmon = new TextEditingController();
  TextEditingController studentphone = new TextEditingController();

  @override
  void initState() {
    studentName.text = student.name;
    studentphone.text = student.phoneNum;
    studentmon.text = student.moneyAmount.toString();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
        // ignore: missing_return
        onWillPop: () {
          goBack();
        },
        child: Scaffold(
            appBar: AppBar(
              title: Text(screenTitle),
              leading: IconButton(
                icon: Icon(Icons.arrow_back),
                onPressed: () {
                  goBack();
                },
              ),
            ),
            body: Stack(
              children: <Widget>[
                Container(
                  decoration: BoxDecoration(
                    gradient: LinearGradient(colors: [
                      Colors.orange[50],
                      Colors.grey[100],
                      Colors.orange[100]
                    ], begin: Alignment.topRight, end: Alignment.bottomLeft),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(top: 15.0, left: 10.0, right: 10.0),
                  child: ListView(
                    children: <Widget>[
                      ListTile(
                        title: DropdownButton(
                          items: _status.map((String dropDownItem) {
                            return DropdownMenuItem<String>(
                              value: dropDownItem,
                              child: Text(dropDownItem),
                            );
                          }).toList(),
                          value: getPassing(student.pass),
                          onChanged: (selectedItem) {
                            setState(() {
                              setPassing(selectedItem);
                            });
                          },
                        ),
                      ),
                      CustomTxtField(
                          controller: studentName,
                          fun: (v) {
                            student.name = v;
                          },
                          label: "اسم الطالب"),
                      CustomTxtField(
                          controller: studentphone,
                          fun: (v) {
                            student.phoneNum = v;
                          },
                          label: "رقم التليفون"),
                      CustomTxtField(
                        controller: studentmon,
                        fun: (v) {
                          student.moneyAmount = int.parse(v);
                        },
                        label: "المدفوع",
                      ),
                      Padding(
                        padding: EdgeInsets.only(top: 15.0, bottom: 15.0),
                        child: Row(
                          children: <Widget>[
                            Myybutton(
                              tab: () {
                                setState(() {
                                  _save();
                                });
                              },
                              label: "حفظ",
                            ),
                            Container(
                              width: 5.0,
                            ),
                            Myybutton(
                              tab: () {
                                setState(() {
                                  _delete();
                                });
                              },
                              label: "حذف",
                            )
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            )));
  }

  void goBack() {
    Navigator.pop(context, true);
  }

  void setPassing(String value) {
    switch (value) {
      case "منتظم":
        student.pass = 1;
        break;
      case "منقطع":
        student.pass = 2;
        break;
    }
  }

  String getPassing(int value) {
    String pass;
    switch (value) {
      case 1:
        pass = _status[0];
        break;
      case 2:
        pass = _status[1];
        break;
    }
    return pass;
  }

  void _save() async {
    goBack();

    student.date = DateFormat.yMMMd().format(DateTime.now());

    int result;
    if (student.id == null) {
      result = await helper.insertItem(student, studentTableName);
    } else {
      result = await helper.updateStudent(student);
    }

    if (result == 0) {
      showAlertDialog('Sorry', "Student not saved");
    } else {
      showAlertDialog('Congratulations', 'Student has been saved successfully');
    }
  }

  void showAlertDialog(String title, String msg) {
    AlertDialog alertDialog = AlertDialog(
      title: Text(title),
      content: Text(msg),
    );
    showDialog(context: context, builder: (_) => alertDialog);
  }

  void _delete() async {
    goBack();

    if (student.id == null) {
      showAlertDialog('Ok Delete', "No student was deleted");
      return;
    }

    int result = await helper.deleteStudent(student.id);
    if (result == 0) {
      showAlertDialog('Ok Delete', "No student was deleted");
    } else {
      showAlertDialog('Ok Delete', "Student has been deleted");
    }
  }
}
