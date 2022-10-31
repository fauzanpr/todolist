import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../models/task.dart';
import '../service/tasklist.dart';

class AddTaskPage extends StatelessWidget {
  const AddTaskPage({super.key, this.model});

  final Task? model;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Tambah Task Baru"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            TextFormField(
              initialValue: model?.name,
              decoration: const InputDecoration(
                hintText: "Masukkan Task Baru",
              ),
              onChanged: (value) {
                context.read<Tasklist>().changeTaskName(value);
              },
              validator: (value) {
                if (value!.isEmpty) {
                  return "Please add some text";
                }
                return null;
              },
            ),
            const SizedBox(
              height: 50,
            ),
            Row(
              children: [
                Expanded(
                  child: ElevatedButton(
                    onPressed: () {
                      context.read<Tasklist>().addTask().then((value) {
                        Navigator.pop(context, true);
                      });
                    },
                    child: Text(
                        model == null ? "Tambah Task Baru" : "Simpan Task"),
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
