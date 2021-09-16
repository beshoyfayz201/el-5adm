import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:alkhadm/models/agpyafiles.dart';

class Alagbya extends StatefulWidget {
  @override
  _AlagbyaState createState() => _AlagbyaState() ;
}

class _AlagbyaState extends State<Alagbya> with SingleTickerProviderStateMixin {
  Baker baker=new Baker();
  Intro _intro=new Intro();
  End end=new End();
  Elgroub elgroub=new Elgroub();
  // ignore: deprecated_member_use
  List aga=new List();
  PageController  controller;
  //TabController tabBarController=new TabController(length: 2, vsync: );
  @override
  void initState() {
    controller=PageController();
    aga.add(_intro);
    aga.add(baker);
    aga.add(elgroub);
    aga.add(end);
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 5,
      child: Scaffold(
        appBar: AppBar(
          title: Text("صلوات الاجبية",style: TextStyle(
            fontSize: 25,
            fontWeight: FontWeight.bold
          ),),
          centerTitle: true,
          bottom: TabBar(
            isScrollable: true,


            tabs: <Widget>[
              Tab(child:Text( "مقدمة الصلاة"),),
              Tab(child:Text( "صلاة باكر"),),
              Tab(child:Text( "صلاة الغروب"),),
              Tab(child:Text( "صلاة النوم"),),
              Tab(child:Text( "ختام الساعة"),)
            ],
          ),
        ),
        body: TabBarView(
            children:[
              buildBageagb(aga[0]),
              buildBageagb(aga[1]),
              buildBageagb(aga[2]),
              buildBageagb(aga[1]),
              buildBageagb(aga[3]),

            ])
      ),
    );
  }

 Widget buildBageagb(var a){
    return PageView.builder(
      scrollDirection: Axis.horizontal,
      controller: controller,

      itemBuilder: (BuildContext context,index){
        return Stack(

          fit: StackFit.expand,
          children: <Widget>[


            Container(

              width: MediaQuery.of(context).size.width,
              padding: EdgeInsets.only(top: 10,right: 0,left: 0),
              decoration: BoxDecoration(
                image: DecorationImage(
                  colorFilter: ColorFilter.mode(Colors.white12, BlendMode.hardLight),

                  image: ExactAssetImage("assets/images/ma.png",
                  )
                )
              ),
              child: Container(
                padding: EdgeInsets.only(right: 15),
                color: Colors.white.withOpacity(0.85),
                child: ListView(
                  children: <Widget>[
                    Center(
                      child: Text(a.titles[index],style: TextStyle(
                          fontFamily: "ol",
                          fontSize: 27
                      ),),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Text(
                        a.subject[index],
                        textDirection: TextDirection.rtl,
                        style: TextStyle(fontSize: 20,
                        fontWeight: FontWeight.bold),

                      ),
                    )
                  ],
                ),
              ),

            ),

          ],
        );
      },
      itemCount: a.titles.length,
    );
  }


}
