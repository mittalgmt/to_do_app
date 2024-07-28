import 'package:flutter/material.dart';

class ToDoPage extends StatefulWidget {
  const ToDoPage({super.key});

  @override
  State<ToDoPage> createState() => _ToDoPageState();
}

class _ToDoPageState extends State<ToDoPage>{

  //TEXT EDITING CONTROLLER

  TextEditingController textcontroller = TextEditingController();
 
 // greeting message variable
   String greetingmessage = "";

  //greet user method
  void greetUser() {
    String userName = textcontroller.text;
    setState(() {
      greetingmessage = "Hello, ${userName}";
    });
  }

  @override
  Widget build(BuildContext context){
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(25.0),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              //greet user message
              Text(greetingmessage),

              TextField(
                controller: textcontroller,
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  hintText: "Type Text...",
                ),
              ),
              //button
              ElevatedButton(onPressed: greetUser,
               child: Text("Tap"),
               ),
        
              
            ],
          ),
        ),
      ),
    );
  }
  
  }
