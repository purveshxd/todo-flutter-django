import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:todo_with_django/repo/todo_api.dart';
import 'package:todo_with_django/repo/todo_model.dart';

final todoApiProvider = Provider((ref) => TodoApi());

final taskListProvider = FutureProvider((ref) {
  return TodoApi().getTodo();
});
final deleteTaskProvider = FutureProvider.family<dynamic, int>((ref, id) {
  return ref.watch(todoApiProvider).deleteTodo(id);
});
final postTaskProvider = FutureProvider.family<dynamic, Todo>((ref, todo) {
  return ref.watch(todoApiProvider).postTodo(todo);
});
final tasktoggeleProvider = FutureProvider.family<dynamic, int>((ref, id) {
  return TodoApi().taskdoneTodo(id);
});

final checkBoxStateProvider = StateProvider.family<bool?, int?>((ref, index) {
  return ref.watch(taskListProvider).value!.elementAt(index!).isDone;
});
