import 'dart:async';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:stream_todo/stream/event/stream_event.dart';

import '../models/todo.dart';

class TodoStream {
  final StreamController<List<Todo>> _streamController =
      StreamController<List<Todo>>.broadcast();
  final StreamController<StreamEvent> _eventStreamController =
      StreamController<StreamEvent>();

  TodoStream() {
    _eventStreamController.stream.listen((event) {
      dispatchEvent(event);
    });
  }

  Stream<List<Todo>> get todoListStream => _streamController.stream;
  Sink<StreamEvent> get event => _eventStreamController.sink;

  List<Todo> todoList = <Todo>[];

  initData() async {
    _streamController.sink.add(todoList);
  }

  _addTodo(Todo todo) async {
    todoList.add(todo);
    _streamController.sink.add(todoList);
  }

  _deleteTodo(Todo todo) {
    todoList.remove(todo);
    _streamController.sink.add(todoList);
  }


  final _randomInt = Random();
  void dispatchEvent(StreamEvent event) {
    if (event is AddTodoEvent) {
      Todo todo = Todo(
        _randomInt.nextInt(10000000),
        event.content,
      );
      _addTodo(todo);
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
