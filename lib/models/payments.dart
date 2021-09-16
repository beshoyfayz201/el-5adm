// @dart=2.9
import 'package:alkhadm/consts.dart';

class Payment{
  String _name;
  int _cash;
  String _date;
  String _type;
   int _id;
  
   Payment(this._cash,this._date,this._name,this._type);
set name(String v){this._name=v;}
set type(String v){this._type=v;}
set cash(int val){this._cash=val;}
set date(String val){this._date=val;}
set id(int v){this._id=v;}
get type=>this._type;
get name=>this._name;
get cash=>this._cash;
get date=>this._date;
get id=>this._id;

Map<String,dynamic>toMap(){
   Map map=Map<String,dynamic>();
   map[paymentCoType]=this._type;
   map[paymentCoName]=this._name;
   map[paymentCoCash]=this.cash;
   map[paymentCoDate]=this._date;
   map[paymentCoId]=this._id;

   return map;
}

Payment.getMap(Map<String, dynamic> map){
  this._type=map[paymentCoType];
   this.cash=map[paymentCoCash];
   this._date =map[paymentCoDate];
   this._id=map[paymentCoId];
   this._name=map[paymentCoName];
}

}