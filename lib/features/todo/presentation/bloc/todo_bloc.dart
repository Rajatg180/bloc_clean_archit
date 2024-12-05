import 'package:clean_architectire_todo_bloc/features/todo/domain/entities/todo.dart';
import 'package:clean_architectire_todo_bloc/features/todo/domain/usecase/delete_todo.dart';
import 'package:clean_architectire_todo_bloc/features/todo/domain/usecase/get_todos.dart';
import 'package:clean_architectire_todo_bloc/features/todo/domain/usecase/save_todos.dart';
import 'package:clean_architectire_todo_bloc/features/todo/domain/usecase/update_todo.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'todo_event.dart';
part 'todo_state.dart';

class TodoBloc extends Bloc<TodoEvent, TodoState> {
  final SaveTodo _addTodo;
  final GetTodos _getAllTodo;
  final DeleteTodo _deleteTodoById;
  final UpdateTodo _updateTodo;

  TodoBloc({
    required SaveTodo addTodo,
    required GetTodos getAllTodo,
    required DeleteTodo deleteTodoById,
    required UpdateTodo updateTodo,
  })  : _addTodo = addTodo,
        _getAllTodo = getAllTodo,
        _deleteTodoById = deleteTodoById,
        _updateTodo = updateTodo,
        super(TodoInitial()) {
    on<TodoAdd>(_onTodoAdd);
    on<FetchAllTodos>(_onFetchAllTodos);
    on<DeleteTodoById>(_onDeleteTodo);
    on<UpdateTodoById>(_onUpdateTodoById);
  }

  void addScreen(Todo todo) {
    add(TodoAdd(todo: todo));
  }

  void _onTodoAdd(TodoAdd event, Emitter<TodoState> emit) async {
    emit(TodoLoading());

    print("call in addtodo");

    final res = await _addTodo.call(event.todo);

    res.fold(
      (l) {
        print("failure in add todo : ${l}");
        emit(TodoFailure(l.message));
      },
      (r) {
        // After adding a todo, fetch all todos
        print("success in add todo }");
        add(FetchAllTodos());
      },
    );
  }

  void _onFetchAllTodos(FetchAllTodos event, Emitter<TodoState> emit) async {

    print("featching doto....");
    emit(TodoLoading());

    final res = await _getAllTodo.call();

    res.fold(
      (l){ 
        print("failure in fetching todo");
        emit(TodoFailure(l.message));
      },
      (r) { 
        print("success in fetching todo ${r}");
        emit(TodoFetchSuccess(r));
      },
    );
  }

//   void _onDeleteTodo(DeleteTodoById event, Emitter<TodoState> emit) async {
//     emit(TodoLoading());

//     final res = await _deleteTodoById.call(event.id);

//     res.fold(
//       (l) => emit(TodoFailure(l.message)),
//       (r) => emit(TodoDeleteSuccess()),
//     );
//   }

//   void _onUpdateTodoById(UpdateTodoById event, Emitter<TodoState> emit) async {
//   emit(TodoLoading());

//   final updatedTodo = Todo(
//     id: event.index,
//     title: event.newTitle,
//     description: event.newDescription,
//   );

//   final res = await _updateTodo.call(updatedTodo);

//   res.fold(
//     (l) => emit(TodoFailure(l.message)),
//     (r) => add(FetchAllTodos()), // Refresh todos after update
//   );
// }

void _onDeleteTodo(DeleteTodoById event, Emitter<TodoState> emit) async {
  emit(TodoLoading());

  final res = await _deleteTodoById.call(event.id);

  res.fold(
    (l) => emit(TodoFailure(l.message)),
    (r) => add(FetchAllTodos()), // Refresh todos after delete
  );
}

void _onUpdateTodoById(UpdateTodoById event, Emitter<TodoState> emit) async {
  emit(TodoLoading());

  final updatedTodo = event.todo;

  final res = await _updateTodo.call(updatedTodo);

  res.fold(
    (l) => emit(TodoFailure(l.message)),
    (r) => add(FetchAllTodos()), // Refresh todos after update
  );
}

}