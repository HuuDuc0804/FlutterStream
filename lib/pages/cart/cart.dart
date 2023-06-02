import 'package:flutter/material.dart';
import 'package:stream_todo/stream/cart_stream.dart';

import '../../models/todo.dart';
import '../../stream/event/stream_event.dart';

class MyCart extends StatelessWidget {
  final CartStream cartStream;
  final List<Todo> data;
  const MyCart({super.key, required this.cartStream, required this.data});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text('Cart List'),
      ),
      body: SafeArea(
        child: StreamBuilder<Object>(
          stream: cartStream.cartListStream,
          builder: (context, snapshot) {
            return ListView.builder(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              itemCount: data.length,
              itemBuilder: (context, index) {
                return Container(
                  margin: const EdgeInsets.only(top: 10, bottom: 4),
                  decoration: BoxDecoration(
                      color: Colors.grey.shade200,
                      borderRadius: BorderRadius.circular(12)),
                  child: ListTile(
                    title: Text(data[index].content,
                        style: const TextStyle(fontSize: 20)),
                    trailing: IconButton(
                      onPressed: () {
                        cartStream.event.add(
                          DeleteTodoEvent(data[index]),
                        );
                      },
                      icon: Icon(
                        Icons.delete,
                        color: Colors.red[400],
                      ),
                    ),
                  ),
                );
              },
            );
          },
        ),
      ),
    );
  }
}
