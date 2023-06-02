import 'package:flutter/material.dart';
import 'package:stream_todo/stream/todo_stream.dart';

import '../../../stream/event/stream_event.dart';

class TodoHeader extends StatelessWidget {
  final TodoStream todoStream;
  const TodoHeader({super.key, required this.todoStream});

  @override
  Widget build(BuildContext context) {
    final txtTodoController = TextEditingController();
    return Row(
      children: [
        Expanded(
          child: TextFormField(
            controller: txtTodoController,
            decoration: const InputDecoration(
              labelText: 'Add todo',
              hintText: 'Add todo',
            ),
          ),
        ),
        const SizedBox(width: 20),
        ElevatedButton.icon(
          onPressed: () {
            todoStream.event.add(
              AddTodoEvent(txtTodoController.text),
            );
          },
          label: const Text('Add'),
          icon: const Icon(Icons.add),
        )
      ],
    );
  }
}
