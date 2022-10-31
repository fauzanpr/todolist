import 'package:flutter/material.dart';
import 'package:flutter_application_1/page/addtask.dart';
import 'package:flutter_application_1/page/editTask.dart';
import 'package:provider/provider.dart';

import '../models/task.dart';
import '../service/tasklist.dart';

class MyListPage extends StatefulWidget {
  const MyListPage({super.key});

  @override
  State<MyListPage> createState() => _MyListPageState();
}

class _MyListPageState extends State<MyListPage> {
  @override
  void initState() {
    super.initState();
    context.read<Tasklist>().fetchTaskList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Dynamic Listview dengan provider"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            Expanded(
              child: ListView.builder(
                itemCount: context.watch<Tasklist>().taskList.length,
                itemBuilder: (context, index) {
                  var task = context.watch<Tasklist>().taskList[index];
                  return Dismissible(
                    key: UniqueKey(),
                    onDismissed: (direction) async {
                      if (direction == DismissDirection.startToEnd) {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => EditTaskPage(model: task),
                          ),
                        ).then((value) {
                          context.read<Tasklist>().fetchTaskList();
                        });
                      } else {
                        context.read<Tasklist>().deleteTask(task).then((value) {
                          context.read<Tasklist>().fetchTaskList();
                        });
                      }
                    },
                    background: Container(color: Colors.red),
                    child: ListTile(
                      title: Text(task.name),
                    ),
                  );
                },
              ),
            ),
            Row(
              children: [
                Expanded(
                  child: ElevatedButton(
                    onPressed: () {
                      Navigator.pushNamed(context, "/addTask").then((value) {
                        context.read<Tasklist>().fetchTaskList();
                      });
                    },
                    child: const Text("Halaman Tambah"),
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
