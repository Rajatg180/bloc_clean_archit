import 'package:clean_architectire_todo_bloc/features/todo/presentation/bloc/todo_bloc.dart';
import 'package:clean_architectire_todo_bloc/features/todo/presentation/pages/home_page.dart';
import 'package:clean_architectire_todo_bloc/service_locator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await setupLocator();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Todo App',
      home: BlocProvider<TodoBloc>(
        create: (_) => TodoBloc(
          addTodo: locator(),
          getAllTodo: locator(),
          deleteTodoById: locator(),
          updateTodo: locator(),
        ),
        child: HomePage(),
      ),
    );
  }
}

