// @dart=2.9
import 'package:alkhadm/consts.dart';
import 'package:alkhadm/models/payments.dart';
import 'package:sqflite/sqflite.dart';
import 'dart:async';
import 'dart:io';
import 'package:intl/intl.dart';
import 'package:path_provider/path_provider.dart';
import 'package:alkhadm/models/student.dart';

// ignore: camel_case_types
class SQL_Helper {
  static SQL_Helper dbHelper;
  static Database _database;

  SQL_Helper._createInstance();

  factory SQL_Helper() {
    if (dbHelper == null) {
      dbHelper = SQL_Helper._createInstance();
    }
    return dbHelper;
  }

  Future<Database> get database async {
    if (_database == null) {
      _database = await initializedDatabase();
    }
    return _database;
  }



  Future<Database> initializedDatabase() async {
    Directory directory = await getApplicationDocumentsDirectory();
    String path = directory.path + "students.db";

    var studentDB =
        await openDatabase(path, version: 1, onCreate: createDatabase);
    return studentDB;
  }

  void createDatabase(Database db, int version) async {
    await db.execute(
        "CREATE TABLE $studentTableName($studentCoId INTEGER PRIMARY KEY AUTOINCREMENT, $studentCoName TEXT, $studentCoMoneyAmount INTEGER," +
            " $studentCopass INTEGER, $studentCodate TEXT ,$studentCoPhone Text, $studentCoAbsence INTEGER)");
    await db.execute(
        "CREATE TABLE $paymentTbName($paymentCoId INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL, $paymentCoName TEXT,$paymentCoDate TEXT,$paymentCoCash INTEGER,$paymentCoType TEXT)");
  }

  Future<List<Map<String, dynamic>>> getallMapList(String tablename,String orderdby) async {
    Database db = await this.database;
    //var result1 =  await db.rawQuery("SELECT * FROM $tableName ORDER BY $_id ASC");
    var result = await db.query(tablename, orderBy: "$orderdby ASC");
    return result;
  }

 
  Future<int> insertItem(dynamic d,String tableName) async {
    Database db = await this.database;
    var result = await db.insert(tableName, d.toMap());
    return result;
  }

  Future<int> updateStudent(Student student) async {
    Database db = await this.database;
    var result = await db.update(studentTableName, student.toMap(),
        where: "$studentCoId = ?", whereArgs: [student.id]);
    return result;
  }

  Future<int> updatePayment(Payment p) async {
    Database db = await this.database;
    var result = await db.update(paymentTbName, p.toMap(),
        where: "$paymentCoId = ?", whereArgs: [p.id]);
    return result;
  }

  Future<int> deleteStudent(int id) async {
    var db = await this.database;
    int result = await db
        .rawDelete("DELETE FROM $studentTableName WHERE $studentCoId = $id");
    return result;
  }

  Future<int> deletePayment(int id) async {
    var db = await this.database;
    int result = await db
        .rawDelete("DELETE FROM $paymentTbName WHERE $paymentCoId = $id");
    return result;
  }

  Future<int> getStudentCount() async {
    Database db = await this.database;
    List<Map<String, dynamic>> all =
        await db.rawQuery("SELECT COUNT (*) FROM $studentTableName");
    int result = Sqflite.firstIntValue(all);
    return result;
  }

  Future<int> getPaymentCount() async {
    Database db = await this.database;
    List<Map<String, dynamic>> all =
        await db.rawQuery("SELECT COUNT (*) FROM $paymentTbName");
    int res = Sqflite.firstIntValue(all);
    return res;
  }

  Future<void> absence(int ab, Student student) async {
    (ab == 1) ? student.absence++ : student.absence--;
    student.date = DateFormat.yMMMd().format((DateTime.now()));
    Database db = await this.database;
    await db.update(studentTableName, student.toMap(),
        where: "$studentCoId = ?", whereArgs: [student.id]);
  }

  Future<List<Student>> getStudentList() async {
    var studentMapList = await getallMapList(studentTableName,studentCoId);
    int count = studentMapList.length;

    List<Student> students = <Student>[];

    for (int i = 0; i <= count - 1; i++) {
      students.add(Student.getMap(studentMapList[i]));
    }

    return students;
  }

  Future<List<Payment>> getPaymentList() async {
    var paymentlist = await getallMapList(paymentTbName,paymentCoId);
    List<Payment> p = <Payment>[];
    for (int i = 0; i < paymentlist.length; i++) {
      p.add(Payment.getMap(paymentlist[i]));
      print("${p[i].cash}\n\n${p[i].date}\n\n${p[i].id}\n\n${p[i].name}\n\n");
    }
    return p;
  }

  Future<List<int>> getTotal() async {
    List<int> res = [0, 0];

    List<Payment> p = await getPaymentList();
    List<Student> s = await getStudentList();
    for (Payment i in p) {
      res[0] = (i.type == "وارد") ? res[0] + i.cash : res[0] - i.cash;
    }

    for (Student i in s) {
      res[1] += i.moneyAmount;
    }
    return res;
  }
}
