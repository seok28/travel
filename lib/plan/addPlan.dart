import 'package:flutter/material.dart';
import 'package:sqflite/sqlite_api.dart';

import 'todo.dart';

class AddPlanApp extends StatefulWidget {
  final Future<Database> db;

  // ignore: use_key_in_widget_constructors
  const AddPlanApp(this.db);

  @override
  State<StatefulWidget> createState() => _AddPlanApp();
}

class _AddPlanApp extends State<AddPlanApp> {
  TextEditingController? titleController;
  TextEditingController? contentController;

  @override
  void initState() {
    super.initState();
    titleController = TextEditingController();
    contentController = TextEditingController();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: const Text('계획 추가'),
      ),
      body: Center(
        child: Column(
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.all(10),
              child: TextField(
                controller: titleController,
                decoration: const InputDecoration(labelText: '제목'),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(10),
              child: TextField(
                controller: contentController,
                decoration: const InputDecoration(labelText: '할일'),
              ),
            ),
            ElevatedButton(
              onPressed: () {
                Todo todo = Todo(
                    title: titleController!.value.text,
                    content: contentController!.value.text,
                    active: 0);
                Navigator.of(context).pop(todo);
              },
              child: const Text('저장하기'),
            )
          ],
        ),
      ),
    );
  }
}
