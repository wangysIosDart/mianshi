import 'package:demo/mvvm1/to_do_item.dart';
import 'package:demo/mvvm1/to_do_service.dart';
import 'package:flutter/foundation.dart';

class TodoViewModel extends ChangeNotifier {
  final TodoService _todoService = TodoService();

  List<TodoItem> get todos => _todoService.todos;

  void addTodo(String title) {
    _todoService.addTodo(TodoItem(title: title));
    notifyListeners();
  }

  void removeTodo(TodoItem todo) {
    _todoService.removeTodo(todo);
    notifyListeners();
  }

  void toggleTodoStatus(TodoItem todo) {
    _todoService.toggleTodoStatus(todo);
    notifyListeners();
  }
}
