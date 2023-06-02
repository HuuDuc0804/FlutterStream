import '../../models/todo.dart';

abstract class StreamEvent{

}

class AddTodoEvent extends StreamEvent {
  final String content;
  AddTodoEvent(this.content);
}

class DeleteTodoEvent extends StreamEvent {
  Todo todo;
  DeleteTodoEvent(this.todo);
}

class AddCartTodoEvent extends StreamEvent {
  Todo todo;
  AddCartTodoEvent(this.todo);
}