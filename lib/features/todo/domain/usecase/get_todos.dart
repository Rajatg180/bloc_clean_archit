import 'package:clean_architectire_todo_bloc/core/error/failure.dart';
import 'package:clean_architectire_todo_bloc/features/todo/domain/entities/todo.dart';
import 'package:clean_architectire_todo_bloc/features/todo/domain/repository/todo_repository.dart';
import 'package:fpdart/fpdart.dart';

class GetTodos {
  final TodoRepository repository;

  GetTodos(this.repository);

  Future<Either<Failure, List<Todo>>> call() async {
    return await repository.getTodos();
  }
}