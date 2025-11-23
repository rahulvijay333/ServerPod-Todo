import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:todo_client/todo_client.dart';
import 'package:todo_flutter/main.dart';
import 'package:todo_flutter/src/session_manager.dart';

class ScreenAddNote extends StatefulWidget {
  const ScreenAddNote({super.key, this.todo});

  final Todo? todo;

  @override
  State<ScreenAddNote> createState() => _ScreenAddNoteState();
}

class _ScreenAddNoteState extends State<ScreenAddNote> {
  final TextEditingController titleController = TextEditingController();

  final TextEditingController descriptionController = TextEditingController();

  @override
  void dispose() {
    titleController.dispose();
    descriptionController.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();

    if (widget.todo != null) {
      titleController.text = widget.todo!.title;
      descriptionController.text = widget.todo!.description;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Colors.blueGrey,
        title: Text(
          'Add Note',
          style: TextStyle(color: Colors.white, fontSize: 16),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            spacing: 15,
            children: [
              TextFormField(
                controller: titleController,
                onTapOutside: (event) {
                  FocusScope.of(context).unfocus();
                },
                decoration: InputDecoration(
                    border: OutlineInputBorder(), hint: Text('Title')),
              ),
              TextFormField(
                maxLines: null,
                controller: descriptionController,
                onTapOutside: (event) {
                  FocusScope.of(context).unfocus();
                },
                decoration: InputDecoration(
                    border: OutlineInputBorder(), hint: Text('Description')),
              ),
              GestureDetector(
                onTap: () async {
                  try {
                    final todo = Todo(userId: sessionManager.signedInUser!.id!,
                        id: widget.todo?.id,
                        title: titleController.text.trim(),
                        description: descriptionController.text.trim(),
                        isCompleted: false);

                    if (widget.todo != null) {
                      await client.todo.updateTodo(todo);
                    } else {
                      await client.todo.createTodo(todo);
                    }
                    context.mounted ? Navigator.of(context).pop() : null;
                  } catch (e) {
                    log(e.toString());
                  }
                },
                child: Container(
                  height: 45,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12),
                    color: Colors.green,
                  ),
                  child: Center(
                      child: Text(
                    'Save',
                    style: TextStyle(fontSize: 14, color: Colors.white),
                  )),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
