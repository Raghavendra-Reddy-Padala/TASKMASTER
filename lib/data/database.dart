// import "package:flutter/material.dart";
// class Tododatabase extends StatelessWidget {
//   const Tododatabase({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return const Scaffold();
//   }
// }
import 'package:hive_flutter/adapters.dart';

class Tododatabase{

List todolist=[
];
  final _mybox=Hive.box('mybox');

  void createinitialdata(){
    todolist=[
["Hit The Gym",false],
];
  }
//load data from the database
void loaddata(){
todolist=_mybox.get("TODOLIST");
}
//updaate the data base
void uodatedatabase(){
  _mybox.put("TODOLIST", todolist);

}
}