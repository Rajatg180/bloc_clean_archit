// import 'package:clean_architectire_todo_bloc/features/todo/domain/entities/todo.dart';
// import 'package:clean_architectire_todo_bloc/features/todo/presentation/bloc/todo_bloc.dart';

// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';

// class HomePage extends StatefulWidget {
//   @override
//   State<HomePage> createState() => _HomePageState();
// }

// class _HomePageState extends State<HomePage> {
//   @override
//   void initState() {
//     super.initState();
//     // Fetch all todos when the HomePage is loaded
//     context.read<TodoBloc>().add(FetchAllTodos());
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(title: const Text('Todo List')),
//       body: BlocBuilder<TodoBloc, TodoState>(
//         builder: (context, state) {
//           if (state is TodoLoading) {
//             return const Center(child: CircularProgressIndicator());
//           } else if (state is TodoFetchSuccess) {
//             return ListView.builder(
//               itemCount: state.todos.length,
//               itemBuilder: (context, index) {
//                 final todo = state.todos[index];
//                 return ListTile(
//                   trailing: Text(todo.id.toString()),
//                   title: Text(todo.title),
//                   subtitle: Text(todo.description),
//                 );
//               },
//             );
//           } else if (state is TodoFailure) {
//             return Center(child: Text("Error: ${state.message}"));
//           }
//           return const Center(child: Text("No Todos Available"));
//         },
//       ),
//       floatingActionButton: FloatingActionButton(
//       onPressed: () {
//         final todo = Todo(
//           id: DateTime.now().millisecondsSinceEpoch, // dynamically generate an ID
//           title: 'New Todo',
//           description: 'This is a new Todo description',
//         );
//         context.read<TodoBloc>().add(TodoAdd(todo: todo));
//       },
//       child: const Icon(Icons.add),
//     ),
//     );
//   }
// }


import 'package:clean_architectire_todo_bloc/features/todo/domain/entities/todo.dart';
import 'package:clean_architectire_todo_bloc/features/todo/presentation/bloc/todo_bloc.dart';
import 'package:clean_architectire_todo_bloc/features/todo/presentation/pages/todo_form_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomePage extends StatefulWidget {
  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  void initState() {
    super.initState();
    // Fetch all todos when the HomePage is loaded
    context.read<TodoBloc>().add(FetchAllTodos());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Todo List')),
      body: BlocBuilder<TodoBloc, TodoState>(
        builder: (context, state) {
          if (state is TodoLoading) {
            return const Center(child: CircularProgressIndicator());
          } else if (state is TodoFetchSuccess) {
            return ListView.builder(
              itemCount: state.todos.length,
              itemBuilder: (context, index) {
                final todo = state.todos[index];
                return ListTile(
                  trailing: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      IconButton(
                        icon: const Icon(Icons.edit),
                        onPressed: () {
                          // Navigate to the edit screen
                          _navigateToEditPage(todo);
                        },
                      ),
                      IconButton(
                        icon: const Icon(Icons.delete),
                        onPressed: () {
                          // Dispatch delete action
                          context.read<TodoBloc>().add(DeleteTodoById(id: todo.id));
                        },
                      ),
                    ],
                  ),
                  title: Text(todo.title),
                  subtitle: Text(todo.description),
                );
              },
            );
          } else if (state is TodoFailure) {
            return Center(child: Text("Error: ${state.message}"));
          }
          return const Center(child: Text("No Todos Available"));
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          final todo = Todo(
            id: DateTime.now().millisecondsSinceEpoch, // dynamically generate an ID
            title: 'New Todo',
            description: 'This is a new Todo description',
          );
          context.read<TodoBloc>().add(TodoAdd(todo: todo));
        },
        child: const Icon(Icons.add),
      ),
    );
  }

  void _navigateToEditPage(Todo todo) {
    // You can create an edit page that passes the current todo
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => TodoEditPage(todo: todo),
      ),
    );
  }
}
