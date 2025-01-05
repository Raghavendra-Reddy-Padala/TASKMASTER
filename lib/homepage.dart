import 'package:flutter/material.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:todolistapp/data/database.dart';
import 'package:todolistapp/util/dialogbox.dart';
import 'package:todolistapp/util/to_dotile.dart';

class Todoapp extends StatefulWidget {
  const Todoapp({super.key});

  @override
  State<Todoapp> createState() => _TodoappState();
}

class _TodoappState extends State<Todoapp> with SingleTickerProviderStateMixin {
  // Animation controller for floating action button
  late AnimationController _animationController;
  final _mybox = Hive.box('mybox');
  final _controller = TextEditingController();
  Tododatabase db = Tododatabase();

  // Theme colors
  final Color primaryColor = const Color(0xFF6200EE);
  final Color secondaryColor = const Color(0xFF03DAC6);
  final Color backgroundColor = const Color(0xFFF5F5F5);
  final Color cardColor = Colors.white;

  @override
  void initState() {
    if (_mybox.get("TODOLIST") == null) {
      db.createinitialdata();
    } else {
      db.loaddata();
    }
    
    _animationController = AnimationController(
      duration: const Duration(milliseconds: 300),
      vsync: this,
    );
    
    super.initState();
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  void checkBoxChanged(bool? value, int index) {
    setState(() {
      db.todolist[index][1] = !db.todolist[index][1];
    });
    db.uodatedatabase();
  }

  void deletetask(int index) {
    setState(() {
      db.todolist.removeAt(index);
    });
    db.uodatedatabase();
  }

  void savenewtask() {
    if (_controller.text.trim().isNotEmpty) {
      setState(() {
        db.todolist.add([_controller.text, false]);
        _controller.clear();
      });
      Navigator.of(context).pop();
      db.uodatedatabase();
    }
  }

  void edittask(int index) {
    _controller.text = db.todolist[index][0];
    showDialog(
      context: context,
      builder: (context) {
        return Dialogbox(
          controller: _controller,
          onsave: () {
            setState(() {
              db.todolist[index][0] = _controller.text;
              _controller.clear();
            });
            Navigator.of(context).pop();
            db.uodatedatabase();
          },
          oncancel: () => Navigator.of(context).pop(),
          isEditing: true,
        );
      },
    );
  }

  void createnewtask() {
    _controller.clear();
    showDialog(
      context: context,
      builder: (context) {
        return Dialogbox(
          controller: _controller,
          onsave: savenewtask,
          oncancel: () => Navigator.of(context).pop(),
          isEditing: false,
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundColor,
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          _animationController.forward(from: 0.0);
          createnewtask();
        },
        label: const Text('Add Task'),
        icon: const Icon(Icons.add),
        backgroundColor: primaryColor,
        elevation: 4,
      ),
      appBar: AppBar(
        title: const Text(
          "Tasks",
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        elevation: 0,
        centerTitle: true,
        backgroundColor: primaryColor,
      ),
      body: Column(
        children: [
          Expanded(
            child: db.todolist.isEmpty
                ? Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.task_alt,
                          size: 64,
                          color: Colors.grey[400],
                        ),
                        const SizedBox(height: 16),
                        Text(
                          'No tasks yet',
                          style: TextStyle(
                            fontSize: 18,
                            color: Colors.grey[600],
                          ),
                        ),
                      ],
                    ),
                  )
                : ListView.builder(
                    itemCount: db.todolist.length,
                    itemBuilder: (context, index) {
                      return ToDoTile(
                        taskname: db.todolist[index][0],
                        taskcomplted: db.todolist[index][1],
                        onChanged: (value) => checkBoxChanged(value, index),
                        deletefunc: (context) => deletetask(index),
                        editfunc: () => edittask(index),
                        cardColor: cardColor,
                        primaryColor: primaryColor,
                      );
                    },
                  ),
          ),
        ],
      ),
    );
  }
}