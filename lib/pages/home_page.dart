import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:to_do_app/Data/database.dart';
import 'package:to_do_app/util/dialog_box.dart';
import 'package:to_do_app/util/todo_tile.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  //ref box
  final _myBox = Hive.box('myBox');
  //text controller
  final _controller = TextEditingController();

  ToDoDatabase db = ToDoDatabase();

  @override
  void initState() {
    
    // if this time ever opening this app , then create default data
    if(_myBox.get("TODOLIST") == null){
      db.createInitialData();
    }else{
      db.loadData();
    }

    super.initState();
  }

  // //list of todo task
  // List toDoList = [
  //   ["Make tutorial", false],
  //   ["Make app", false],

  // ];

 //checkbox was tapped
 void CheckBoxChanged(bool? value, int index) {
   setState(() {
     db.toDoList[index][1] = !db.toDoList[index][1];
   });
   db.updateDataBase();
 }

 // save new task

 void saveNewTask(){
  setState(() {
    db.toDoList.add([
      _controller.text,false
    ]);
    _controller.clear();
    Navigator.of(context).pop();
  });
  db.updateDataBase();
 }

 //create new task
 void createNewTask() {
  showDialog(
    context: context,
     builder: (context){
    return DialogBox(
      controller: _controller ,
      onSave: saveNewTask,
      onCancel: () => Navigator.of(context).pop(),
    );
   },
  );
  db.updateDataBase();
 }

 //delete task
 void deleteTask(int index) {
  setState(() {
    db.toDoList.removeAt(index);
  });
  db.updateDataBase();
 }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.red[100],
      appBar: AppBar(
        title: Text("ToDo App"),
        elevation: 0,
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: createNewTask,
        child: Icon(Icons.add),
      ),
      body: ListView.builder(
        itemCount: db.toDoList.length,
        itemBuilder: (context, index){
          return TodoTile(
            taskName: db.toDoList[index][0],
            isCompleted: db.toDoList[index][1],
            onChanged: (value) => CheckBoxChanged(value,index),
            deleteFunction: (context) => deleteTask(index),
            );
        },
      ),
    );
  }
}