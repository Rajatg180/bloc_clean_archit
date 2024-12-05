import 'package:clean_architectire_todo_bloc/core/error/failure.dart';
import 'package:clean_architectire_todo_bloc/features/todo/data/data_sources/todo_local_data_sources.dart';
import 'package:clean_architectire_todo_bloc/features/todo/domain/entities/todo.dart';
import 'package:clean_architectire_todo_bloc/features/todo/domain/repository/todo_repository.dart';
import 'package:fpdart/fpdart.dart';

class TodoRepositoryImpl implements TodoRepository {

  final TodoLocalDataSource localDataSource;

  TodoRepositoryImpl({required this.localDataSource});

  @override
  Future<Either<Failure, void>> saveTodo(Todo todo) async {
    try {
      print("repo impl  ${todo.title}");
      await localDataSource.saveTodo(todo);
      // print(todo);
      return  const   Right(null);
    } catch (e) {
      print("message form repo implawdawd ${e}");
      return Left(Failure("Failed to add todo"));
    }
  }

  @override
  Future<Either<Failure, void>> deleteTodo(int index) async {
    try {
      await localDataSource.deleteTodo(index);
      return const Right(null);
    } catch (e) {
      return Left(Failure("Failed to delete todo"));
    }
  }

  @override
  Future<Either<Failure, void>> updateTodo(Todo todo) async {
    try {
      await localDataSource.updateTodo(todo);
      return const Right(null);
    } catch (e) {
      return Left(Failure("Failed to update todo"));
    }
  }

  @override
  Future<Either<Failure, List<Todo>>> getTodos() async {
    try {
      final todos = await localDataSource.getTodos();
      return Right(todos);
    } catch (e) {
      return Left(Failure("Failed to fetch todos"));
    }
  }
  
}