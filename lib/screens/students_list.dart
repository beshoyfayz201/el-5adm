// @dart=2.9
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:alkhadm/customWidget/appBar.dart';
import 'package:alkhadm/customWidget/buttons.dart';
import 'package:alkhadm/customWidget/mystack.dart';
import 'package:alkhadm/screens/student_detil.dart';

import 'package:sqflite/sqflite.dart';
import 'package:alkhadm/models/student.dart';

import '../sql_helper.dart';

class StudentsList extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    
    return StudentsState();
  }
}

class StudentsState extends State<StudentsList> {
  SQL_Helper helper = new SQL_Helper();
  List<Student> studentsList;
  int count = 0;

  @override
  Widget build(BuildContext context) {
    if (studentsList == null) {
      studentsList = <Student>[];
      updateListView();
    }

    
    return Scaffold(
      
        appBar: buildAppBar("الطلاب"),
        body: MyStack(widget: getStudentsList(),),
        
        floatingActionButton: FloatingButton(clckd: () {
            navigateToStudent(Student('', 1, 1, '', "", 0), "اضافة طالب");})  
          );
  }
  ListView getStudentsList() {
    return ListView.builder(
        itemCount: count,
        itemBuilder: (BuildContext context, int position) {
          return Container(margin: EdgeInsets.only(top: 3),

            decoration: BoxDecoration(

              gradient: LinearGradient(
                colors: [Colors.amber[100],Colors.white]
              )
            ),
            child: ListTile(

              leading: CircleAvatar(
                backgroundColor: payornot(this.studentsList[position].pass),
                child: getIcon(this.studentsList[position].pass),
              ),
              title: Text(this.studentsList[position].name),
              subtitle: Text(this.studentsList[position].moneyAmount.toString() + " | " +
                  this.studentsList[position].date),
              trailing:
              Container(
                alignment: Alignment.centerRight,
                width: 160,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: <Widget>[

                    IconButton(icon: Icon(Icons.add),onPressed:(){plus(context, this.studentsList[position]);} ,),
                    Text("${this.studentsList[position].absence}"),
                    IconButton(icon: Icon(Icons.remove,),onPressed: ()
                    {minus(context, this.studentsList[position]);}),
                    SizedBox(width: 10,),
                    GestureDetector(
                      child: Icon(Icons.delete, color: Colors.red,),
                      onTap: () {
                        assuring("تنبيه","هل تريد تأكيد الالغاء ؟ ",context, this.studentsList[position]);
                      },
                    ),
                  ],
                ),
              )
              ,
              onTap: () {
                navigateToStudent(this.studentsList[position], "تعديل");
              },
            ),
          );
        });
  }


//if he pay the total cost
  Color payornot(int value) {
    switch (value) {
      case 1:
        return Colors.yellow[900];
        break;
      case 2:
        return Colors.red;
        break;
      default:
        return Colors.amber;
    }
  }

  Icon getIcon(int value) {
    switch (value) {
      case 1:
        return Icon(
          Icons.check,
          color: Colors.white,
        );
        break;
      case 2:
        return Icon(Icons.close, color: Colors.white);
        break;
      default:
        return Icon(Icons.check);
    }
  }

  plus(BuildContext context, Student student) async {
    await helper.absence(1, student);

    updateListView();
  }

  minus(BuildContext context, Student student) async {
    await helper.absence(2, student);

    updateListView();
  }

  void _showSenckBar(BuildContext context, String msg) {
    final snackBar = SnackBar(
      content: Text(msg),
    );
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }

  void updateListView() {
    final Future<Database> db = helper.initializedDatabase();
    db.then((database) {
      Future<List<Student>> students = helper.getStudentList();
      students.then((theList) {
        setState(() {
          this.studentsList = theList;
          this.count = theList.length;
        });
      });
    });
  }

  void navigateToStudent(Student student, String appTitle) async {
    bool result =
        await Navigator.push(context, MaterialPageRoute(builder: (context) {
      return StudentDetail(student, appTitle);
    }));

    if (result) {
      updateListView();
    }
  }

  void assuring(
      String title, String msg, BuildContext context, Student student) async {
    AlertDialog alertDialog = AlertDialog(
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.only(topLeft: Radius.circular(20))),
      title: Text(
        title,
        textDirection: TextDirection.ltr,
        textAlign: TextAlign.center,
        style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
      ),
      content: Text(
        msg,
        textDirection: TextDirection.ltr,
        textAlign: TextAlign.end,
        style: TextStyle(fontSize: 18),
      ),
      actions: <Widget>[
        Padding(
          padding: const EdgeInsets.only(right: 110.0),
          child: Row(
            children: <Widget>[
              TextButton(
                child: Text("الغاء"),
                onPressed: () {
                  Navigator.pop(context);
                },
              ),
              TextButton(
                child: Text("تأكيد"),
                onPressed: () {
                  _delete(context, student);
                  Navigator.of(context).pop();
                },
              ),
            ],
          ),
        )
      ],
    );
    showDialog(context: context, builder: (_) => alertDialog);
  }

  void _delete(BuildContext context, Student student) async {
    int ressult = await helper.deleteStudent(student.id);
    if (ressult != 0) {
      _showSenckBar(context, "Student has been deleted");
      updateListView();
    }
  }
}
