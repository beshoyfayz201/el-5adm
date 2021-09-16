import 'package:flutter/material.dart';
import 'package:alkhadm/screens/homescree.dart';

void main() {
  runApp(MyApp());
}

/*getFileContent() async{
  String fileContent = await downloadFile();
  print(fileContent);
}*/

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "الخادم",
      debugShowCheckedModeBanner: false,
      theme: ThemeData(primarySwatch: Colors.deepOrange),
      home: HomeScreen(),
    );
  }
}
