import 'package:clean_architectire_todo_bloc/core/error/failure.dart';
import 'package:clean_architectire_todo_bloc/features/todo/domain/entities/todo.dart';
import 'package:clean_architectire_todo_bloc/features/todo/domain/repository/todo_repository.dart';
import 'package:fpdart/fpdart.dart';

class UpdateTodo {
  final TodoRepository repository;

  UpdateTodo(this.repository);

  Future<Either<Failure,void>> call(Todo todo) async {
    return await repository.updateTodo(todo);
  }
}