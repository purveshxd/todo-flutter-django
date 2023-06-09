import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:todo_with_django/repo/todo_model.dart';
import 'package:todo_with_django/repo/todo_provider.dart';
import 'package:todo_with_django/widget/custom_text_field.dart';
import 'package:todo_with_django/widget/task_tile.dart';

class Homepage extends ConsumerWidget {
  const Homepage({super.key});

  @override
  Widget build(BuildContext context, ref) {
    TextEditingController titleController = TextEditingController();
    TextEditingController descController = TextEditingController();
    final taskList = ref.watch(taskListProvider);
    Future _onRefresh() async {
      return Future.delayed(const Duration(seconds: 1))
          .then((value) => ref.refresh(taskListProvider));
    }

    Future _showDialog() async => await showDialog(
          context: context,
          builder: (context) => Dialog(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const SizedBox(height: 10),
                const Text(
                  "Add Task",
                  style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
                ),
                CustomTextField(
                  controller: titleController,
                  index: 0,
                ),
                CustomTextField(
                  controller: descController,
                  index: 1,
                ),
                const SizedBox(height: 10),
                TextButton(
                  onPressed: () {
                    final body = Todo(
                      title: titleController.text,
                      desc: descController.text,
                      isDone: false,
                    );

                    ref.read(postTaskProvider.call(body));
                    Navigator.pop(context);
                    _onRefresh();
                  },
                  child: const Text("Add"),
                )
              ],
            ),
          ),
        );

    return Scaffold(
      appBar: AppBar(
        title: const Text("T O D O with django"),
        centerTitle: true,
        toolbarHeight: 60,
      ),
      body: taskList.when(
        data: (data) {
          var reversedData = data.reversed;
          return RefreshIndicator(
            onRefresh: _onRefresh,
            child: ListView.builder(
              itemCount: reversedData.length,
              itemBuilder: (context, index) {
                return TaskTile(
                  todo: reversedData.elementAt(index),
                  onChanged: (value) {
                    reversedData.elementAt(index).isDone = value;
                    ref
                        .read(checkBoxStateProvider.call(index).notifier)
                        .update((state) => value!);
                    ref
                        .read(todoApiProvider)
                        .taskdoneTodo(reversedData.elementAt(index).id);
                  },
                  value: ref.watch(checkBoxStateProvider.call(index)),
                );
              },
            ),
          );
        },
        error: (error, stackTrace) => Center(
          child: Text(error.toString()),
        ),
        loading: () => const Center(
          child: CircularProgressIndicator(),
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: _showDialog,
        label: const Row(
          children: [
            Icon(Icons.add_rounded),
            SizedBox(
              width: 5,
            ),
            Text("Add Todo"),
          ],
        ),
      ),
    );
  }
}



//  ListView.builder(
//     itemCount: taskList.value!.length,
//     physics: const BouncingScrollPhysics(),
//     itemBuilder: (context, index) {
//       return TaskTile(
//         id: taskList.value!.elementAt(index).id,
//         title: taskList.value!.elementAt(index).title,
//         desc: taskList.value!.elementAt(index).desc,
//         isDone: taskList.value!.elementAt(index).isDone,
//       );
//     },
//   ),
