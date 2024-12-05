// import 'package:clean_architectire_todo_bloc/features/todo/domain/entities/todo.dart';
// import 'package:clean_architectire_todo_bloc/features/todo/presentation/bloc/todo_bloc.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';

// class TodoFormPage extends StatelessWidget {
//   final Todo? todo; // Existing todo to edit, or null for adding a new todo.
//   final index;

//   TodoFormPage({this.todo,this.index});

//   @override
//   Widget build(BuildContext context) {
//     final titleController = TextEditingController(text: todo?.title ?? '');
//     final descriptionController = TextEditingController(text: todo?.description ?? '');

//     return Scaffold(
//       appBar: AppBar(
//         title: Text(todo == null ? 'Add Todo' : 'Edit Todo'),
//       ),
//       body: Padding(
//         padding: const EdgeInsets.all(16.0),
//         child: Column(
//           children: [
//             TextField(
//               controller: titleController,
//               decoration: const InputDecoration(labelText: 'Title'),
//             ),
//             TextField(
//               controller: descriptionController,
//               decoration: const InputDecoration(labelText: 'Description'),
//             ),
//             const SizedBox(height: 20),
//             ElevatedButton(
//               onPressed: () {
//                 final newTodo = Todo(
//                   id: todo?.id ?? DateTime.now().millisecondsSinceEpoch, // Use existing ID or generate a new one
//                   title: titleController.text,
//                   description: descriptionController.text,
//                 );

//                 if (todo == null) {
//                   // Adding a new Todo
//                   context.read<TodoBloc>().add(TodoAdd(todo: newTodo));
//                 } else {
//                   // Updating an existing Todo
//                   context.read<TodoBloc>().add(UpdateTodoById(index: index,newTitle: titleController.text,newDescription: descriptionController.text));
//                 }

//                 Navigator.pop(context); // Go back to the previous screen
//               },
//               child: Text(todo == null ? 'Add Todo' : 'Update Todo'),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }


import 'package:clean_architectire_todo_bloc/features/todo/domain/entities/todo.dart';
import 'package:clean_architectire_todo_bloc/features/todo/presentation/bloc/todo_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class TodoEditPage extends StatefulWidget {
  final Todo todo;

  const TodoEditPage({Key? key, required this.todo}) : super(key: key);

  @override
  _TodoEditPageState createState() => _TodoEditPageState();
}

class _TodoEditPageState extends State<TodoEditPage> {
  late TextEditingController _titleController;
  late TextEditingController _descriptionController;

  @override
  void initState() {
    super.initState();
    _titleController = TextEditingController(text: widget.todo.title);
    _descriptionController = TextEditingController(text: widget.todo.description);
  }

  @override
  void dispose() {
    _titleController.dispose();
    _descriptionController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Edit Todo')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: _titleController,
              decoration: const InputDecoration(labelText: 'Title'),
            ),
            TextField(
              controller: _descriptionController,
              decoration: const InputDecoration(labelText: 'Description'),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                final updatedTodo = Todo(
                  id: widget.todo.id,
                  title: _titleController.text,
                  description: _descriptionController.text,
                );
                context.read<TodoBloc>().add(UpdateTodoById(todo: updatedTodo));
                Navigator.pop(context);
              },
              child: const Text('Save'),
            ),
          ],
        ),
      ),
    );
  }
}
