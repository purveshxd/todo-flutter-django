// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

import '../repo/todo_model.dart';

// i must_be_immutable
class TaskTile extends StatelessWidget {
  final Todo todo;
  final bool? value;
  final void Function(bool?)? onChanged;
  const TaskTile({
    super.key,
    required this.todo,
    this.onChanged,
    this.value,
  });

  @override
  Widget build(BuildContext context) {
    final textStyle = TextStyle(
      decoration: value! ? TextDecoration.lineThrough : TextDecoration.none,
    );
    return ListTile(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(13),
      ),
      tileColor:
          value! ? Colors.grey.shade300 : Colors.primaries.first.shade100,
      title: Text(
        todo.title.toString(),
        style: textStyle.copyWith(fontWeight: FontWeight.bold, fontSize: 18),
      ),
      subtitle: Container(
        margin: const EdgeInsets.symmetric(vertical: 10),
        padding: const EdgeInsets.all(8),
        decoration: BoxDecoration(
          color: value! ? Colors.grey.shade50 : Colors.red.shade50,
          borderRadius: BorderRadius.circular(10),
        ),
        child: Text(
          todo.desc.toString(),
          style: textStyle,
        ),
      ),
      trailing: Checkbox(value: value, onChanged: onChanged),
    );
  }
}
