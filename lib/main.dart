import 'package:flutter/material.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:todolistapp/homepage.dart';

void main() async{
  //init the hive
  await Hive.initFlutter();

  //open a box
  var box = await Hive.openBox("mybox");
  runApp(const MyApp());
}
class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return  MaterialApp(
      debugShowCheckedModeBanner: false,
      home: const Todoapp(),
      theme: ThemeData(primaryColor: Colors.black),
    );
  }
}