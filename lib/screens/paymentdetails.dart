// @dart=2.9
import 'package:alkhadm/consts.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:alkhadm/customWidget/buttons.dart';

import 'package:alkhadm/customWidget/textField.dart';
import 'package:alkhadm/models/payments.dart';

import '../sql_helper.dart';

// ignore: must_be_immutable
class PaymentScreenDetails extends StatefulWidget {
  String screenTitle;
  Payment payment;

  PaymentScreenDetails(this.payment, this.screenTitle);

  @override
  State<StatefulWidget> createState() {
    return PaymentScreen(this.payment, screenTitle);
  }
}

class PaymentScreen extends State<PaymentScreenDetails> {
  static var _status = ["وارد", "صادر"];
  String screenTitle;
  Payment payment;
  SQL_Helper helper = new SQL_Helper();

  PaymentScreen(this.payment, this.screenTitle);

  TextEditingController paymentName = new TextEditingController();
  TextEditingController paymentmon = new TextEditingController();

  @override
  void initState() {
    paymentName.text = payment.name;
    paymentmon.text = payment.cash.toString();

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
                      Colors.deepOrange.shade50,
                      Colors.white,
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
                          value: getPassing(payment.type),
                          onChanged: (selectedItem) {
                            setState(() {
                              payment.type = selectedItem;
                            });
                          },
                        ),
                      ),
                      CustomTxtField(
                          controller: paymentName,
                          fun: (v) {
                            payment.name = v;
                          },
                          label: "تفاصيل"),
                      CustomTxtField(
                          controller: paymentmon,
                          fun: (v) {
                            payment.cash = int.parse(v);
                          },
                          label: "المبلغ"),
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

  String getPassing(String value) {
    String pass;
    switch (value) {
      case "صادر":
        pass = _status[1];
        break;
      case "وارد":
        pass = _status[0];
        break;
    }
    return pass;
  }

  void _save() async {
    goBack();

    payment.date = DateFormat.yMMMd().format(DateTime.now());

    int result;
    if (payment.id == null) {
      result = await helper.insertItem(payment, paymentTbName);
    } else {
      result = await helper.updatePayment(payment);
    }

    if (result == 0) {
      showAlertDialog('Sorry', "transaction not saved");
    } else {
      showAlertDialog(
          'Congratulations', 'transaction has been saved successfully');
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

    if (payment.id == null) {
      showAlertDialog('Ok Delete', "No transaction was deleted");
      return;
    }

    int result = await helper.deletePayment(payment.id);
    if (result == 0) {
      showAlertDialog('Ok Delete', "No transaction was deleted");
    } else {
      showAlertDialog('Ok Delete', "transaction has been deleted");
    }
  }
}
