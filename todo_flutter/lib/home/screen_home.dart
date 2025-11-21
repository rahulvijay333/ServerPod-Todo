import 'package:flutter/material.dart';
import 'package:todo_client/todo_client.dart';
import 'package:todo_flutter/add/screen_add_note.dart';
import 'package:todo_flutter/main.dart';

class ScreenHome extends StatefulWidget {
  const ScreenHome({super.key});

  @override
  State<ScreenHome> createState() => _ScreenHomeState();
}

class _ScreenHomeState extends State<ScreenHome> {
  List<Todo>? alltodos;

  void loadAllTodos() async {
    alltodos = await client.todo.getAllTodo();
    setState(() {});
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    loadAllTodos();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.of(context).push(MaterialPageRoute(
            builder: (context) {
              return ScreenAddNote();
            },
          )).then(
            (value) {
              loadAllTodos();
            },
          );
        },
        child: Icon(Icons.add),
      ),
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Colors.blueGrey,
        title: Text(
          'Todo ServerPod App',
          style: TextStyle(color: Colors.white, fontSize: 16),
        ),
      ),
      body: alltodos == null
          ? Center(child: CircularProgressIndicator())
          : alltodos!.isEmpty
              ? Center(
                  child: Text('Todo Empty'),
                )
              : RefreshIndicator(
                  onRefresh: () async {
                    loadAllTodos();
                  },
                  child: SingleChildScrollView(
                    child: Column(
                      children: alltodos!
                          .map(
                            (todo) => ListTile(
                              onTap: () {
                                Navigator.of(context).push(MaterialPageRoute(
                                  builder: (context) {
                                    return ScreenAddNote(todo: todo,);
                                  },
                                )).then(
                                  (value) {
                                    loadAllTodos();
                                  },
                                );
                              },
                              title: Text(todo.title),
                              subtitle: Text(todo.description),
                              trailing: GestureDetector(
                                onTap: () async {
                                  await client.todo.deleteTodo(todo).then(
                                    (value) {
                                      loadAllTodos();
                                    },
                                  );
                                },
                                child: Icon(Icons.delete),
                              ),
                            ),
                          )
                          .toList(),
                    ),
                  ),
                ),
    );
  }
}
