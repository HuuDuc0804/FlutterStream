import 'package:flutter/material.dart';
import 'package:stream_todo/pages/cart/cart.dart';
import 'package:stream_todo/stream/cart_stream.dart';
import 'package:stream_todo/stream/todo_stream.dart';

import 'widgets/header_widget.dart';
import 'widgets/list_widget.dart';

class MyHomePage extends StatelessWidget {
  const MyHomePage({super.key});

  @override
  Widget build(BuildContext context) {
    var todoStream = TodoStream();
    var cartStream = CartStream();
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text('Todo List'),
        actions: [
          StreamBuilder(
            stream: cartStream.cartListStream,
            builder: (context, snapshot) {
              return Stack(
                children: [
                  IconButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) => MyCart(
                            data: snapshot.data ?? [],
                            cartStream: cartStream,
                          ),
                        ),
                      );
                    },
                    icon: const Icon(
                      Icons.shopping_cart,
                      size: 30,
                    ),
                  ),
                  snapshot.data != null
                      ? snapshot.data!.isNotEmpty
                          ? Positioned(
                              top: 5,
                              right: 5,
                              child: Container(
                                alignment: Alignment.center,
                                height: 20,
                                width: 20,
                                decoration: BoxDecoration(
                                  color: Colors.red,
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                child: Text(
                                  '${snapshot.data!.length}',
                                  style: const TextStyle(color: Colors.white),
                                ),
                              ),
                            )
                          : Container()
                      : Container()
                ],
              );
            },
          ),
        ],
      ),
      body: SafeArea(
        child: Container(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            children: [
              TodoHeader(
                todoStream: todoStream,
              ),
              StreamBuilder(
                stream: todoStream.todoListStream,
                builder: (context, snapshot) => Expanded(
                  child: snapshot.data != null
                      ? TodoList(
                          todoStream: todoStream,
                          cartStream: cartStream,
                          data: snapshot.data!,
                        )
                      : const Center(
                          child: Text('No data'),
                        ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
