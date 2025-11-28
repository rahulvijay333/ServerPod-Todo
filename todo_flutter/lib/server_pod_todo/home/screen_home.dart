import 'package:flutter/material.dart';
import 'package:todo_client/todo_client.dart';
import 'package:todo_flutter/server_pod_todo/add/screen_add_note.dart';
import 'package:todo_flutter/main.dart';
import 'package:todo_flutter/src/session_manager.dart';

class ScreenHome extends StatefulWidget {
  const ScreenHome({super.key});

  @override
  State<ScreenHome> createState() => _ScreenHomeState();
}

class _ScreenHomeState extends State<ScreenHome> {
  List<Todo>? alltodos;

  void loadAllTodos() async {
    alltodos = await client!.todo.getAllTodo();
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
          style: TextStyle(
              color: Colors.white, fontSize: 16, fontWeight: FontWeight.bold),
        ),
        actions: [
          TextButton(
              onPressed: () {
                sessionManager!.signOutDevice();
              },
              child: Text(
                'LogOut',
                style: TextStyle(color: Colors.white),
              ))
        ],
      ),
      body: alltodos == null
          ? Center(child: CircularProgressIndicator())
          : alltodos!.isEmpty
              ? Column(
                  children: [
                    SizedBox(
                      height: 10,
                    ),
                    Row(
                      spacing: 15,
                      children: [
                        SizedBox(
                          width: 5,
                        ),
                        CircleAvatar(
                          onBackgroundImageError: (exception, stackTrace) =>
                              Icon(Icons.person),
                          backgroundImage: NetworkImage(
                              sessionManager!.signedInUser?.imageUrl ?? ''),
                        ),
                        Text(
                          'Welcome ${sessionManager!.signedInUser?.userName?.toUpperCase() ?? ''}',
                          style: TextStyle(
                            fontSize: 14,
                          ),
                        ),
                      ],
                    ),
                    Divider(),
                    SizedBox(
                      height: 500,
                      child: Center(
                        child: Text('No Todos'),
                      ),
                    ),
                  ],
                )
              : RefreshIndicator(
                  onRefresh: () async {
                    loadAllTodos();
                  },
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        SizedBox(
                          height: 10,
                        ),
                        Row(
                          spacing: 15,
                          children: [
                            SizedBox(
                              width: 5,
                            ),
                            CircleAvatar(
                              onBackgroundImageError: (exception, stackTrace) =>
                                  Icon(Icons.person),
                              backgroundImage: NetworkImage(
                                  sessionManager!.signedInUser?.imageUrl ?? ''),
                            ),
                            Text(
                              'Welcome ${sessionManager!.signedInUser?.userName?.toUpperCase() ?? ''}',
                              style: TextStyle(
                                fontSize: 14,
                              ),
                            ),
                          ],
                        ),
                        Divider(),
                        Column(
                          children: alltodos!
                              .map(
                                (todo) => ListTile(
                                  onTap: () {
                                    Navigator.of(context)
                                        .push(MaterialPageRoute(
                                      builder: (context) {
                                        return ScreenAddNote(
                                          todo: todo,
                                        );
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
                                      await client!.todo.deleteTodo(todo).then(
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
                      ],
                    ),
                  ),
                ),
    );
  }
}
