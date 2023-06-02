import 'package:flutter/material.dart';
import 'package:stream_todo/stream/cart_stream.dart';
import 'package:stream_todo/stream/todo_stream.dart';

import '../../../models/todo.dart';
import '../../../stream/event/stream_event.dart';

class TodoList extends StatelessWidget {
  final TodoStream todoStream;
  final CartStream cartStream;
  final List<Todo> data;
  const TodoList(
      {super.key,
      required this.todoStream,
      required this.data,
      required this.cartStream});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: data.length,
      itemBuilder: (context, index) {
        return Container(
          margin: const EdgeInsets.all(4),
          decoration: BoxDecoration(
              color: Colors.grey.shade200,
              borderRadius: BorderRadius.circular(12)),
          child: ListTile(
            title:
                Text(data[index].content, style: const TextStyle(fontSize: 20)),
            trailing: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                IconButton(
                  onPressed: () {
                    cartStream.event.add(AddCartTodoEvent(data[index]));
                  },
                  icon: const Icon(
                    Icons.shopping_cart_checkout,
                    color: Colors.green,
                  ),
                ),
                IconButton(
                  onPressed: () {
                    todoStream.event.add(
                      DeleteTodoEvent(data[index]),
                    );
                  },
                  icon: Icon(
                    Icons.delete,
                    color: Colors.red[400],
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
