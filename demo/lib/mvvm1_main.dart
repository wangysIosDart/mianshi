import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'mvvm1/to_do_item.dart';
import 'mvvm1/to_do_view_model.dart';

///使用 MVVM 架构将业务逻辑、界面表示和用户交互分离。
///通过这种方式，我们可以更容易地维护和扩展代码，同时保持代码整洁


///利用了数据绑定（Data Binding）技术，使得 ViewModel 可以自动通知 View 数据的变化，
///进一步减少了 View 和 Model 之间的耦合。


void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: ChangeNotifierProvider(
        create: (context) => TodoViewModel(),
        child: TodoListPage(),
      ),
    );
  }
}

class TodoListPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Todo List')),
      body: Consumer<TodoViewModel>(
        builder: (context, viewModel, child) {
          return ListView.builder(
            itemCount: viewModel.todos.length,
            itemBuilder: (context, index) {
              return TodoItemWidget(
                todo: viewModel.todos[index],
                onToggle: () {
                  viewModel.toggleTodoStatus(viewModel.todos[index]);
                },
                onDelete: () {
                  viewModel.removeTodo(viewModel.todos[index]);
                },
              );
            },
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          String? newTitle = await showDialog<String>(
            context: context,
            builder: (context) {
              return AddTodoDialog();
            },
          );
          if (newTitle != null && newTitle.isNotEmpty) {
            context.read<TodoViewModel>().addTodo(newTitle);
          }
        },
        child: Icon(Icons.add),
      ),
    );
  }
}

class TodoItemWidget extends StatelessWidget {
  final TodoItem todo;
  final VoidCallback onToggle;
  final VoidCallback onDelete;

  TodoItemWidget({required this.todo, required this.onToggle, required this.onDelete});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(todo.title),
      leading: Checkbox(
        value: todo.isDone,
        onChanged: (bool? value) {
          onToggle();
        },
      ),
      trailing: IconButton(
        icon: Icon(Icons.delete),
        onPressed: onDelete,
      ),
    );
  }
}

class AddTodoDialog extends StatelessWidget {
  final TextEditingController _controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text('Add Todo'),
      content: TextField(
        controller: _controller,
        decoration: InputDecoration(hintText: 'Todo title'),
      ),
      actions: [
        TextButton(
          child: Text('Cancel'),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
        TextButton(
          child: Text('Add'),
          onPressed: () {
            Navigator.of(context).pop(_controller.text);
          },
        ),
      ],
    );
  }
}
