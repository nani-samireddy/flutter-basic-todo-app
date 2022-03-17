import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:todo_app/Models/task_model.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int todoCount = 0;
  List<TaskModel> tasks = [];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("My Todo App"),
      ),
      body: tasks.isNotEmpty
          ? ListView.separated(
              itemBuilder: (context, index) {
                return ListTile(
                  title: Text(tasks[index].title),
                  trailing: IconButton(
                    icon: const Icon(Icons.done),
                    onPressed: () {
                      setState(() {
                        tasks.remove(tasks[index]);
                        todoCount--;
                      });
                    },
                  ),
                );
              },
              separatorBuilder: (context, index) {
                return const Divider();
              },
              itemCount: todoCount)
          : const Center(
              child: Text("Hello world"),
            ),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.add),
        onPressed: () {
          showAddTask();
        },
      ),
    );
  }

  void addTask(String name) {
    setState(() {
      todoCount++;
      tasks.add(TaskModel(title: name));
      log("Added");
    });
  }

  Future<void> showAddTask() {
    return showDialog(
        context: context,
        builder: (context) {
          final TextEditingController textEditingController =
              TextEditingController();
          return StatefulBuilder(builder: (context, setState) {
            return AlertDialog(
              content: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Text("Add Task"),
                  TextField(
                    controller: textEditingController,
                  ),
                  TextButton(
                      onPressed: () {
                        addTask(textEditingController.text);
                        Navigator.pop(context);
                      },
                      child: const Text("ADD"))
                ],
              ),
            );
          });
        });
  }
}
