import 'dart:async';
import 'package:flutter/material.dart';
import 'package:stream_todo/stream/event/stream_event.dart';

import '../models/todo.dart';

class CartStream {
  final StreamController<List<Todo>> _streamController =
      StreamController<List<Todo>>.broadcast();
  final StreamController<StreamEvent> _eventStreamController =
      StreamController<StreamEvent>();

  CartStream() {
    _eventStreamController.stream.listen((event) {
      dispatchEvent(event);
    });
  }

  Stream<List<Todo>> get cartListStream => _streamController.stream;
  Sink<StreamEvent> get event => _eventStreamController.sink;

  List<Todo> cartList = <Todo>[];

  initData() async {
    _streamController.sink.add(cartList);
  }

  _addCartTodo(Todo todo) {
    cartList.add(todo);
    _streamController.sink.add(cartList);
  }

  _deleteTodo(Todo todo) {
    cartList.remove(todo);
    _streamController.sink.add(cartList);
  }

  void dispatchEvent(StreamEvent event) {
    if (event is AddCartTodoEvent) {
      _addCartTodo(event.todo);
    } else if (event is DeleteTodoEvent) {
      _deleteTodo(event.todo);
    }
  }

  @mustCallSuper
  void dispose() {
    _eventStreamController.close();
    _streamController.close();
  }
}
