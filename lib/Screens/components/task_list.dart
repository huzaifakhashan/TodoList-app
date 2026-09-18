import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:to_do_list/Screens/components/task.form.dart';
import 'package:to_do_list/providers/task_providers.dart';

class TaskList extends StatelessWidget {
  const TaskList({super.key});

  @override
  Widget build(BuildContext context) {
    final provider = context.watch<TaskProviders>();
    final tasks = provider.tasks;

    if (tasks.isEmpty) {
      return const Expanded(
        child: Center(child: Text("لا توجد مهام")),
      );
    }

    return Expanded(
      child: ListView.builder(
        itemCount: tasks.length,
        itemBuilder: (context, index) {
          final task = tasks[index];
          return Dismissible(
            direction: DismissDirection.endToStart,
            onDismissed: (direction) {
              provider.removeTask(task);
              ScaffoldMessenger.of(context)
                ..hideCurrentSnackBar()
                ..showSnackBar(
                  SnackBar(
                    content: const Text("تم نقل المهمة إلى سلة المحذوفات"),
                    action: SnackBarAction(
                      label: "تراجع",
                      onPressed: () => provider.restoreTask(task),
                    ),
                  ),
                );
            },
            key: Key(task.id),
            background: Container(
              padding: const EdgeInsets.only(right: 25),
              alignment: Alignment.centerRight,
              color: Colors.red,
              child: const Icon(Icons.delete, size: 40),
            ),
            child: ListTile(
              title: Text(
                task.title,
                style: TextStyle(
                  decoration:
                      task.completed ? TextDecoration.lineThrough : null,
                ),
              ),
              subtitle:
                  task.description.isEmpty ? null : Text(task.description),
              trailing: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  IconButton(
                    icon: const Icon(Icons.edit),
                    onPressed: () => showDialog(
                      context: context,
                      builder: (_) => TaskForm(task: task),
                    ),
                  ),
                  Image(
                    image: AssetImage(
                      task.completed
                          ? "assets/icons/emoji4.webp"
                          : "assets/icons/emoji3.webp",
                    ),
                  ),
                ],
              ),
              onTap: () => provider.toggleTask(task),
            ),
          );
        },
      ),
    );
  }
}
