import 'dart:convert';

List<Todo> todoFromJson(String str) =>
    List<Todo>.from(json.decode(str).map((x) => Todo.fromJson(x)));

String todoToJson(List<Todo> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Todo {
  final int? id;
  final String? title;
  final String? desc;
  bool? isDone;

  Todo({
    this.id,
    this.title,
    this.desc,
    this.isDone,
  });

  Todo copyWith({
    int? id,
    String? title,
    String? desc,
    bool? isDone,
  }) =>
      Todo(
        id: id ?? this.id,
        title: title ?? this.title,
        desc: desc ?? this.desc,
        isDone: isDone ?? this.isDone,
      );

  factory Todo.fromJson(Map<String, dynamic> json) => Todo(
      id: json["id"],
      title: json["title"],
      desc: json["desc"],
      isDone: json["isDone"]);

  Map<String, dynamic> toJson() =>
      {"id": id, "title": title, "desc": desc, "isDone": isDone};
}
