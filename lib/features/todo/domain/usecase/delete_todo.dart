import 'package:clean_architectire_todo_bloc/core/error/failure.dart';
import 'package:clean_architectire_todo_bloc/features/todo/domain/repository/todo_repository.dart';
import 'package:fpdart/fpdart.dart';

class DeleteTodo {
  final TodoRepository repository;

  DeleteTodo(this.repository);

  Future<Either<Failure,void>> call(int index) async {
    return await repository.deleteTodo(index);
  }

}