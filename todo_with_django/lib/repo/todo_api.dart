import 'dart:convert';

import 'package:flutter/widgets.dart';
import 'package:http/http.dart' as http;
import 'package:http/http.dart';

import 'package:todo_with_django/repo/todo_model.dart';

class TodoApi {
  String url = "http://192.168.114.171:8000/";
  List<Todo> taskList = [];
// Get todo List from django server
  Future<List<Todo>> getTodo() async {
    var resp = await http.get(Uri.parse(url));

    if (resp.statusCode == 200) {
      taskList = todoFromJson(resp.body);
      debugPrint(taskList.toString());

      return taskList;
    } else {
      throw Exception(resp.reasonPhrase! + resp.statusCode.toString());
    }
  }

  // POST a todo on server
  void postTodo(Todo todo) async {
    try {
      Response resp = await http.post(
        Uri.parse(url),
        body: jsonEncode(
          todo
        ),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
      );
      print(resp.body);

      if (resp.statusCode == 201) {
        debugPrint(resp.body);
      } else {
        throw Exception(resp.reasonPhrase! + resp.body);
      }
    } on Exception catch (e) {
      throw Exception(e);
    }
  }

  // DELETE a todo on server
  void deleteTodo(int? id) async {
    var resp = await http.delete(Uri.parse("$url$id"));
    if (resp.statusCode == 204) {
      getTodo();
      debugPrint(resp.body);
    } else {}
  }

  void taskdoneTodo(int? id) async {
    Todo todo = await getTodo()
        .then((value) => value.where((element) => element.id == id).single);
    bool? isDone = todo.isDone;
    var resp = await http.put(
      Uri.parse("$url$id"),
      body: jsonEncode(todo.copyWith(isDone: !isDone!)),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
    );
    if (resp.statusCode == 200) {
      debugPrint(resp.body);
    } else {
      debugPrint(resp.body +
          resp.reasonPhrase.toString() +
          resp.statusCode.toString());
    }
  }
}
