import 'package:flutter/material.dart';
// import 'package:firebase_database/firebase_database.dart'; // 파이어베이스
import 'todo.dart'; // 계획 db
import 'ClearList.dart'; // 계획 삭제
import 'addPlan.dart'; // 계획 추가
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';


class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Future<Database> database = initDatabase();

    return MaterialApp(
      title: '계획 생성 페이지',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      initialRoute: '/',
      routes: {
        '/': (context) => DatabaseApp(database),
        '/add': (context) => AddPlanApp(database),
        '/clear': (context) => ClearListApp(database)
      },
    );
  }

  Future<Database> initDatabase() async {
    return openDatabase(
      join(await getDatabasesPath(), 'todo_database.db'),
      onCreate: (db, version) {
        return db.execute(
          "CREATE TABLE todos(id INTEGER PRIMARY KEY AUTOINCREMENT, "
          "title TEXT, content TEXT, active INTEGER)",
        );
      },
      version: 1,
    );
  }
}

class DatabaseApp extends StatefulWidget {
  final Future<Database> db;

  // ignore: use_key_in_widget_constructors
  const DatabaseApp(this.db);

  @override
  State<StatefulWidget> createState() => _DatabaseApp();
}

class _DatabaseApp extends State<DatabaseApp> {
  Future<List<Todo>>? todoList;

  @override
  void initState() {
    super.initState();
    todoList = getTodos();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: const Text('계획 생성 페이지'), actions: <Widget>[
          ElevatedButton(
              onPressed: () async {
                await Navigator.of(context).pushNamed('/clear');
                setState(() {
                  todoList = getTodos();
                });
              },
              child: const Text(
                '상세 페이지',
                style: TextStyle(color: Colors.white),
              ))
        ]),
        body: Center(
          child: FutureBuilder(
            builder: (context, snapshot) {
              switch (snapshot.connectionState) {
                case ConnectionState.none:
                  return const CircularProgressIndicator();
                case ConnectionState.waiting:
                  return const CircularProgressIndicator();
                case ConnectionState.active:
                  return const CircularProgressIndicator();
                case ConnectionState.done:
                  if (snapshot.hasData) {
                    return ListView.builder(
                      itemBuilder: (context, index) {
                        Todo todo = (snapshot.data as List<Todo>)[index];
                        return ListTile(
                          title: Text(
                            todo.title!,
                            style: const TextStyle(fontSize: 20),
                          ),
                          subtitle: Column(
                            children: <Widget>[
                              Text(todo.content!),
                              Text(
                                  '체크 : ${todo.active == 1 ? 'true' : 'false'}'),
                              Container(
                                height: 1,
                                color: Colors.blue,
                              )
                            ],
                          ),
                          onTap: () async {
                            Todo result = await showDialog(
                                context: context,
                                builder: (BuildContext context) {
                                  return AlertDialog(
                                    title: Text('${todo.id} : ${todo.title}'),
                                    content: const Text('계획을 체크하시겠습니까?'),
                                    actions: <Widget>[
                                      TextButton(
                                          onPressed: () {
                                            setState(() {
                                              todo.active == 1
                                                  ? todo.active = 0
                                                  : todo.active = 1;
                                            });
                                            Navigator.of(context).pop(todo);
                                          },
                                          child: const Text('예')),
                                      TextButton(
                                          onPressed: () {
                                            Navigator.of(context).pop(todo);
                                          },
                                          child: const Text('아니요')),
                                    ],
                                  );
                                });
                            _updateTodo(result);
                          },
                          onLongPress: () async {
                            Todo result = await showDialog(
                                context: context,
                                builder: (BuildContext context) {
                                  return AlertDialog(
                                    title: Text('${todo.id} : ${todo.title}'),
                                    content: Text('${todo.content}를 삭제하시겠습니까?'),
                                    actions: <Widget>[
                                      TextButton(
                                          onPressed: () {
                                            Navigator.of(context).pop(todo);
                                          },
                                          child: const Text('예')),
                                      TextButton(
                                          onPressed: () {
                                            Navigator.of(context).pop();
                                          },
                                          child: const Text('아니요')),
                                    ],
                                  );
                                });
                            _deleteTodo(result);
                          },
                        );
                      },
                      itemCount: (snapshot.data as List<Todo>).length,
                    );
                  } else {
                    return const Text('No data');
                  }
              }
            },
            future: todoList,
          ),
        ),
        floatingActionButton: Column(
          children: <Widget>[
            FloatingActionButton(
              onPressed: () async {
                final todo = await Navigator.of(context).pushNamed('/add');
                if (todo != null) {
                  _insertTodo(todo as Todo);
                }
              },
              heroTag: null,
              child: const Icon(Icons.add),
            ),
            const SizedBox(
              height: 10,
            ),
            FloatingActionButton(
              onPressed: () async {
                _allUpdate();
              },
              heroTag: null,
              child: const Icon(Icons.update),
            ),
          ],
          mainAxisAlignment: MainAxisAlignment.end,
        ));
  }

  void _allUpdate() async {
    final Database database = await widget.db;
    await database.rawUpdate('update todos set active = 1 where active = 0');
    setState(() {
      todoList = getTodos();
    });
  }

  void _deleteTodo(Todo todo) async {
    final Database database = await widget.db;
    await database.delete('todos', where: 'id=?', whereArgs: [todo.id]);
    setState(() {
      todoList = getTodos();
    });
  }

  void _updateTodo(Todo todo) async {
    final Database database = await widget.db;
    await database.update(
      'todos',
      todo.toMap(),
      where: 'id = ? ',
      whereArgs: [todo.id],
    );
    setState(() {
      todoList = getTodos();
    });
  }

  void _insertTodo(Todo todo) async {
    final Database database = await widget.db;
    await database.insert('todos', todo.toMap(),
        conflictAlgorithm: ConflictAlgorithm.replace);
    setState(() {
      todoList = getTodos();
    });
  }

  Future<List<Todo>> getTodos() async {
    final Database database = await widget.db;
    final List<Map<String, dynamic>> maps = await database.query('todos');

    return List.generate(maps.length, (i) {
      int active = maps[i]['active'] == 1 ? 1 : 0;
      return Todo(
          title: maps[i]['title'].toString(),
          content: maps[i]['content'].toString(),
          active: active,
          id: maps[i]['id']);
    });
  }
}
