import 'package:hive_flutter/hive_flutter.dart';

class ToDoDatabase {
 List toDoList = [];
  //ref  box
  final _myBox = Hive.box('myBox');


//run this method if the 1st time ever opening this app
  void createInitialData(){
  toDoList = [
     ["Make tutorial", false],
     ["Make app", false],
    ];
  }

  //load the data from database
  void loadData(){
    toDoList = _myBox.get("TODOLIST");
  }

  //update the database

  void updateDataBase()
  {
    _myBox.put("TODOLIST", toDoList);
  }
}