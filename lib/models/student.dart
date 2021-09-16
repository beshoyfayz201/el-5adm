// @dart=2.9

import 'package:alkhadm/consts.dart';

class Student {

  int _id;
  String _name;
  int _moneyAmount ;
  int _pass;
  String _date;
  String _phoneNum;
  int _absence;

  Student(this._name, this._moneyAmount, this._pass, this._date,this._phoneNum,this._absence);

  // Student.withId(this._id, this._name, this._moneyAmount, this._pass,
  //     this._date,this._phoneNum,this._absence);

  // ignore: unnecessary_getters_setters
  String get date => _date;

  int get pass => _pass;

  // ignore: unnecessary_getters_setters
  int get moneyAmount => _moneyAmount;

  String get name => _name;

  // ignore: unnecessary_getters_setters
  set phoneNum(String value) {
    _phoneNum = value;
  }

  // ignore: unnecessary_getters_setters
  int get absence => _absence;

  // ignore: unnecessary_getters_setters
  set absence(int value) {
    _absence = value;
  }

  // ignore: unnecessary_getters_setters
  String get phoneNum => _phoneNum;

  int get id => _id;

  // ignore: unnecessary_getters_setters
  set date(String value) {
    _date = value;
  }

  set pass(int value) {
    if (value >= 1 && value <= 2) {
      _pass = value;
    }
  }

  // ignore: unnecessary_getters_setters
  set moneyAmount(int value) {
    _moneyAmount=value;
  }

  set name(String value) {
    if (value.length <= 255) {
      _name = value;
    }
  }

  Map<String, dynamic> toMap() {
    var map = Map<String, dynamic>();
    map[studentCoId] = this._id;
    map[studentCoName] = this._name;
    map[studentCoMoneyAmount] = this._moneyAmount;
    map[studentCopass] = this._pass;
    map[studentCodate] = this._date;
    map[studentCoPhone]=this._phoneNum;
    map[studentCoAbsence]=this._absence;
    return map;
  }

  Student.getMap(Map<String, dynamic> map){
    this._id = map[studentCoId] ;
    this._name = map[studentCoName];
    this._moneyAmount = map[studentCoMoneyAmount];
    this._pass = map[studentCopass];
    this._date = map[studentCodate];
    this._phoneNum=map[studentCoPhone];
    this._absence=map[studentCoAbsence];
  }
}