import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:alkhadm/models/tarnimfiles.dart';

class Tranim extends StatefulWidget {
  @override
  _TranimState createState() => _TranimState();
}

class _TranimState extends State<Tranim> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "ترانيم",
          style: TextStyle(fontFamily: "ol", fontSize: 30),
        ),
        centerTitle: true,
      ),
      body: ListView.builder(
          itemCount: Tranimtexts.titles.length,
          itemBuilder: (BuildContext context, int index) {
            return GestureDetector(
              onTap: () {
                Navigator.of(context).push(new MaterialPageRoute(
                    builder: (BuildContext context) => Tarnema(index)));
              },
              child: Card(
                shape: RoundedRectangleBorder(
                    borderRadius:
                        BorderRadius.only(bottomLeft: Radius.circular(15)),
                    side: BorderSide(color: Colors.grey[400])),
                color: Colors.grey[800],
                child: ListTile(
                  trailing: CircleAvatar(
                      radius: 25,
                      child: Text(Tranimtexts.titles[index].substring(0, 1))),
                  title: Text(
                    Tranimtexts.titles[index],
                    textDirection: TextDirection.rtl,
                    textAlign: TextAlign.center,
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              ),
            );
          }),
    );
  }
}

class Tarnema extends StatelessWidget {
  final int i;
  Tarnema(this.i);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          Tranimtexts.titles[i].toString(),
          style: TextStyle(fontSize: 30, fontFamily: "ol"),
        ),
        centerTitle: true,
      ),
      body: Container(
          padding: EdgeInsets.all(15),
          child: Text(
            Tranimtexts.subject[i],
            textDirection: TextDirection.rtl,
            style: TextStyle(fontSize: 20),
          )),
    );
  }
}
