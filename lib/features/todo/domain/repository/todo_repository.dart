import 'package:clean_architectire_todo_bloc/core/error/failure.dart';
import 'package:clean_architectire_todo_bloc/features/todo/domain/entities/todo.dart';
import 'package:fpdart/fpdart.dart';

abstract class TodoRepository {
  Future<Either<Failure, List<Todo>>> getTodos();
  Future<Either<Failure, void>> saveTodo(Todo todo);
  Future<Either<Failure, void>> deleteTodo(int index);
  Future<Either<Failure, void>> updateTodo(Todo todo);
}