import 'package:flutter/material.dart';

void main (){
  runApp(FlutterApp());
}
class FlutterApp extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: " FlutterApp ",
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.green
      ),
      home: DashBoardScreen(),
    );
  }
}
class DashBoardScreen extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
   return Scaffold(
     appBar: AppBar(
       title: Text(" DashBoardScreen"),
     ),
     body: Container(
       width: double.infinity,
       height: double.infinity,
       color: Colors.blue.shade50,
       child: Center(
         child: Container(
           width: 100,
           height: 100,
           color: Colors.grey,
         ),
       ),
     ),
   );
  }
  
}