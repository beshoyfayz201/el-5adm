// @dart=2.9
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:alkhadm/customWidget/appBar.dart';
import 'package:alkhadm/customWidget/buttons.dart';
import 'package:alkhadm/customWidget/custombottombar.dart';
import 'package:alkhadm/customWidget/mystack.dart';
import 'package:alkhadm/models/payments.dart';
import 'package:alkhadm/screens/paymentdetails.dart';
import 'package:sqflite/sqflite.dart';
import '../sql_helper.dart';

class PaymentScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return StudentsState();
  }
}

class StudentsState extends State<PaymentScreen> {
  SQL_Helper helper = new SQL_Helper();
  List<Payment> mypayments;
  int count = 0;
  

  @override
  Widget build(BuildContext context) {
    if (mypayments == null) {
      mypayments = <Payment>[];
      updateListView();
    }

    return Scaffold(
      bottomNavigationBar: CustomButtonNBar(),
        appBar: buildAppBar("الحسابات"),
        body:MyStack(widget: MyStack(widget: getPaymentScreen(),),) ,
        floatingActionButton: FloatingButton(clckd:  () {
            navigateToStudent(Payment(0, "", "", ""), "اضافة عملية");},)
            );
  }

  ListView getPaymentScreen() {
    return ListView.builder(
        itemCount: count,
        itemBuilder: (BuildContext context, int position) {
         
          return Container(
            margin: EdgeInsets.only(top: 3),
            decoration: BoxDecoration(
                gradient:
                    LinearGradient(colors: [Colors.amber[100], Colors.white])),
            child: ListTile(
              leading: CircleAvatar(
                backgroundColor: payornot(this.mypayments[position].type),
                child: getIcon(this.mypayments[position].type),
              ),
              title: Text(this.mypayments[position].name),
              subtitle: Text(this.mypayments[position].cash.toString() +
                  " | " +
                  this.mypayments[position].date),
              trailing: Container(
                alignment: Alignment.centerRight,
                width: 160,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: <Widget>[
                    SizedBox(
                      width: 10,
                    ),
                    GestureDetector(
                      child: Icon(
                        Icons.delete,
                        color: Colors.red,
                      ),
                      onTap: () {
                        assuring("تنبيه", "هل تريد تأكيد الالغاء ؟ ", context,
                            this.mypayments[position]);
                      },
                    ),
                  ],
                ),
              ),
              onTap: () {
                navigateToStudent(mypayments[position], "تعديل");
              },
            ),
          );
        });
  }

//define type of payment
  Color payornot(String value) {
    switch (value) {
      case "وارد":
        return Colors.lightGreen;
        break;
      default:
        return Colors.red;
    }
  }

  Icon getIcon(String value) {
    switch (value) {
    
        
      case "وارد":
        return Icon(Icons.add, color: Colors.white);
        break;
      default:
        return Icon(Icons.remove);
    }
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
      Future<List<Payment>> payments = helper.getPaymentList();
      payments.then((theList) {
        setState(() {
          this.mypayments = theList;
          this.count = theList.length;
        });
      });
    });
  }

  void navigateToStudent(Payment payment, String appTitle) async {
    bool result =
        await Navigator.push(context, MaterialPageRoute(builder: (context) {
      return PaymentScreenDetails(payment, appTitle);
    }));

    if (result) {
      updateListView();
    }
  }

  void assuring(
      String title, String msg, BuildContext context, Payment p) async {
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
                  _delete(context, p);
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

  void _delete(BuildContext context, Payment p) async {
    int ressult = await helper.deletePayment(p.id);
    if (ressult != 0) {
      _showSenckBar(context, "تم حذف العملية");
      updateListView();
    }
  }
}
