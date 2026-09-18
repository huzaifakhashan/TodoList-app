import 'package:flutter/material.dart';
import 'package:to_do_list/Screens/components/add_task_button.dart';
import 'package:to_do_list/Screens/components/task_list.dart';
import 'package:to_do_list/Screens/components/welcome.dart';

class Body extends StatelessWidget {
  const Body({super.key});

  @override
  Widget build(BuildContext context) {
    return const Column(
      children: [
        Welcome(name: "ياصاحب"),
        AddTaskButton(),
        TaskList(),
      ],
    );
  }
}
