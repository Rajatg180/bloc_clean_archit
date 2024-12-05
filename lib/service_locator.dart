import 'package:clean_architectire_todo_bloc/features/todo/data/data_sources/todo_local_data_sources.dart';
import 'package:clean_architectire_todo_bloc/features/todo/data/repository/todo_repository_impl.dart';
import 'package:clean_architectire_todo_bloc/features/todo/domain/repository/todo_repository.dart';
import 'package:clean_architectire_todo_bloc/features/todo/domain/usecase/delete_todo.dart';
import 'package:clean_architectire_todo_bloc/features/todo/domain/usecase/get_todos.dart';
import 'package:clean_architectire_todo_bloc/features/todo/domain/usecase/save_todos.dart';
import 'package:clean_architectire_todo_bloc/features/todo/domain/usecase/update_todo.dart';
import 'package:clean_architectire_todo_bloc/features/todo/presentation/bloc/todo_bloc.dart';
import 'package:get_it/get_it.dart';

final GetIt locator = GetIt.instance;

Future<void> setupLocator() async {
  locator.registerFactory<TodoBloc>(() => TodoBloc(
    addTodo: locator(),
    deleteTodoById: locator(),
    updateTodo: locator(),
    getAllTodo: locator(),
  ));

  locator.registerLazySingleton<SaveTodo>(() => SaveTodo(locator()));
  locator.registerLazySingleton<DeleteTodo>(() => DeleteTodo(locator()));
  locator.registerLazySingleton<UpdateTodo>(() => UpdateTodo(locator()));
  locator.registerLazySingleton<GetTodos>(() => GetTodos(locator()));

  locator.registerLazySingleton<TodoRepository>(() => TodoRepositoryImpl(localDataSource: locator()));
  locator.registerLazySingleton<TodoLocalDataSource>(() => TodoLocalDataSourceImpl());

  // final sharedPreferences = await SharedPreferences.getInstance();
  // locator.registerLazySingleton(() => sharedPreferences);

}


