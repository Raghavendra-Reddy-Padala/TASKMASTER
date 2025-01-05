// ignore_for_file: prefer_const_constructors

import "package:flutter/material.dart";
class Counterpage extends StatefulWidget {
  const Counterpage({super.key});

  @override
  State<Counterpage> createState() => _CounterpageState();
}

class _CounterpageState extends State<Counterpage> {
//variable
int counter=0;
//method
void incrementcounter(){
setState(() {
    counter++;
});
}

//ui
  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
        children:  [Text(
          "You pushed the button ${counter.toString()} times",
          style: TextStyle(fontSize: 20,
          fontWeight:FontWeight.bold ),
        ),

        ElevatedButton(onPressed: (){
          incrementcounter();
        }, 
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.black,
          foregroundColor: Colors.white       ),
          child: Text("Increment"),
        )
        ],
        
        ),
      ),


    );
  }
}