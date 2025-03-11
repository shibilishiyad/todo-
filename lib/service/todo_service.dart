import 'package:hive/hive.dart';
import 'package:todo_app/model/todomodel.dart';

class TodoService {
  static final TodoService _instance = TodoService._internal();
  Box<Todo>? _todoBox;

  factory TodoService() {
    return _instance;
  }

  TodoService._internal();

  Future<void> openBox() async {
    if (_todoBox == null || !_todoBox!.isOpen) {
      _todoBox = await Hive.openBox<Todo>("todoos");
    }
  }

  Future<void> closeBox() async {
    if (_todoBox != null && _todoBox!.isOpen) {
      await _todoBox!.close();
    }
  }

  Future<void> addTodo(Todo todo) async {
    await openBox();
    await _todoBox!.add(todo);
  }

  Future<List<Todo>> getaTodos() async {
    await openBox();
    return _todoBox!.values.toList();
  }

  Future<void> update(int index, Todo todo) async {
    await openBox();
    await _todoBox!.putAt(index, todo);
  }

  Future<void> deleteTodo(int index) async {
    await openBox();
    await _todoBox!.deleteAt(index);
  }
}