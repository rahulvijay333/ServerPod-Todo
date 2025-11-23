import 'package:serverpod/serverpod.dart';
import 'package:todo_server/src/generated/protocol.dart';

class TodoEndpoint extends Endpoint {
  Future<Todo> createTodo(Session session, Todo todo) async {
    final newTodo = await Todo.db.insertRow(session, todo);
    return newTodo;
  }

  Future<List<Todo>> getAllTodo(Session session) async {
    final authInfo = await session.authenticated;
    final userId = authInfo?.userId;

    if (userId == null) {
      throw Exception(
          'User not authenticated');
    }
    final allTodos = await Todo.db.find(
      session,
      where: (todo) => todo.userId.equals(userId),
    );
    return allTodos;
  }

  Future<Todo> updateTodo(Session session, Todo todo) async {
    if (todo.id == null) {
      throw Exception('No id found');
    }
    final updatedTodo = await Todo.db.updateRow(session, todo);

    return updatedTodo;
  }

  Future<void> deleteTodo(Session session, Todo todo) async {
    if (todo.id == null) {
      throw Exception('No id found');
    }
    await Todo.db.deleteRow(session, todo);
  }
}
