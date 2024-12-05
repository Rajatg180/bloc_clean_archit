import 'package:clean_architectire_todo_bloc/core/error/failure.dart';
import 'package:clean_architectire_todo_bloc/features/todo/domain/entities/todo.dart';
import 'package:clean_architectire_todo_bloc/features/todo/domain/repository/todo_repository.dart';
import 'package:fpdart/fpdart.dart';

class SaveTodo {
  final TodoRepository repository;

  SaveTodo(this.repository);

  Future<Either<Failure,void>> call(Todo todo) async {
    return await repository.saveTodo(todo);
  }
}