// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:todo_app/model/todomodel.dart';
import 'package:todo_app/service/todo_service.dart';

class PendingTasksScreen extends StatefulWidget {
  const PendingTasksScreen({super.key});

  @override
  State<PendingTasksScreen> createState() => _PendingTasksScreenState();
}

class _PendingTasksScreenState extends State<PendingTasksScreen> {
  final TodoService _todoService = TodoService(); // Singleton instance
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();
  List<Todo> _pendingTodos = [];

  Future<void> _loadPendingTasks() async {
    final todos = await _todoService.getaTodos();
    setState(() {
      _pendingTodos = todos.where((todo) => !todo.completed).toList();
    });
  }

  @override
  void initState() {
    _loadPendingTasks();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.white,
        onPressed: _showAddTaskDialog,
        child: const Icon(Icons.add, color: Colors.black),
      ),
      backgroundColor: Colors.black,
      body: Column(
        children: [
          const SizedBox(height: 30),
          Expanded(
            child: _pendingTodos.isEmpty
                ? const Center(
                    child: Text(
                      "Pending tasks are empty!",
                      style: TextStyle(
                        color: Colors.white70,
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  )
                : ListView.builder(
                    itemCount: _pendingTodos.length,
                    itemBuilder: (context, index) {
                      final todo = _pendingTodos[index];
                      return Column(
                        children: [
                          ListTile(
                            title: Text(
                              todo.title,
                              style: const TextStyle(color: Colors.white),
                            ),
                            subtitle: Text(
                              todo.description,
                              style: const TextStyle(color: Colors.white70),
                            ),
                            trailing: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Checkbox(
                                  checkColor: Colors.white,
                                  activeColor: Colors.green,
                                  value: todo.completed,
                                  onChanged: (value) async {
                                    todo.completed = value!;
                                    final allTodos = await _todoService.getaTodos();
                                    final hiveIndex = allTodos.indexOf(todo);
                                    await _todoService.update(hiveIndex, todo);
                                    _loadPendingTasks();
                                  },
                                ),
                                IconButton(
                                  icon: const Icon(Icons.edit, color: Colors.white),
                                  onPressed: () => _showEditTaskDialog(todo, index),
                                ),
                                IconButton(
                                  icon: const Icon(Icons.delete, color: Colors.red),
                                  onPressed: () async {
                                    final confirm = await showDialog<bool>(
                                      context: context,
                                      builder: (context) => AlertDialog(
                                        title: const Text("Delete Task"),
                                        content: const Text(
                                          "Are you sure you want to delete this task?",
                                        ),
                                        actions: [
                                          TextButton(
                                            onPressed: () => Navigator.pop(context, false),
                                            child: const Text("Cancel"),
                                          ),
                                          TextButton(
                                            onPressed: () => Navigator.pop(context, true),
                                            child: const Text("Delete"),
                                          ),
                                        ],
                                      ),
                                    );
                                    if (confirm == true) {
                                      final allTodos = await _todoService.getaTodos();
                                      final hiveIndex = allTodos.indexOf(todo);
                                      await _todoService.deleteTodo(hiveIndex);
                                      _loadPendingTasks();
                                    }
                                  },
                                ),
                              ],
                            ),
                            tileColor: Colors.white12,
                          ),
                          const SizedBox(height: 10),
                        ],
                      );
                    },
                  ),
          ),
        ],
      ),
    );
  }

  Future<void> _showAddTaskDialog() async {
    _titleController.clear();
    _descriptionController.clear();
    await showDialog(
      context: context,
      builder: (context) {
        bool isTitleEmpty = _titleController.text.isEmpty; // Initial check
        return StatefulBuilder(
          builder: (context, setDialogState) {
            return AlertDialog(
              title: const Text("Add New Task"),
              content: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  TextField(
                    controller: _titleController,
                    decoration: InputDecoration(
                      hintText: "Title",
                      errorText: isTitleEmpty ? "Title is required" : null,
                    ),
                    onChanged: (value) {
                      setDialogState(() {
                        isTitleEmpty = value.isEmpty;
                      });
                    },
                  ),
                  TextField(
                    controller: _descriptionController,
                    decoration: const InputDecoration(hintText: "Description"),
                  ),
                ],
              ),
              actions: [
                ElevatedButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.black,
                    foregroundColor: Colors.white,
                  ),
                  child: const Text("Cancel"),
                ),
                ElevatedButton(
                  onPressed: isTitleEmpty
                      ? null
                      : () async {
                          final newTodo = Todo(
                            title: _titleController.text,
                            description: _descriptionController.text,
                            completed: false,
                            createdAt: DateTime.now(),
                          );
                          await _todoService.addTodo(newTodo);
                          Navigator.pop(context);
                          _loadPendingTasks();
                        },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.black,
                    foregroundColor: Colors.white,
                    disabledBackgroundColor: Colors.grey,
                  ),
                  child: const Text("Add"),
                ),
              ],
            );
          },
        );
      },
    );
  }

  Future<void> _showEditTaskDialog(Todo todo, int index) async {
    _titleController.text = todo.title;
    _descriptionController.text = todo.description;
    await showDialog(
      context: context,
      builder: (context) {
        bool isTitleEmpty = _titleController.text.isEmpty; // Initial check
        return StatefulBuilder(
          builder: (context, setDialogState) {
            return AlertDialog(
              title: const Text("Edit Task"),
              content: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  TextField(
                    controller: _titleController,
                    decoration: InputDecoration(
                      hintText: "Title",
                      errorText: isTitleEmpty ? "Title is required" : null,
                    ),
                    onChanged: (value) {
                      setDialogState(() {
                        isTitleEmpty = value.isEmpty;
                      });
                    },
                  ),
                  TextField(
                    controller: _descriptionController,
                    decoration: const InputDecoration(hintText: "Description"),
                  ),
                ],
              ),
              actions: [
                ElevatedButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.black,
                    foregroundColor: Colors.white,
                  ),
                  child: const Text("Cancel"),
                ),
                ElevatedButton(
                  onPressed: isTitleEmpty
                      ? null
                      : () async {
                          todo.title = _titleController.text;
                          todo.description = _descriptionController.text;
                          final allTodos = await _todoService.getaTodos();
                          final hiveIndex = allTodos.indexOf(todo);
                          await _todoService.update(hiveIndex, todo);
                          Navigator.pop(context);
                          _loadPendingTasks();
                        },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.black,
                    foregroundColor: Colors.white,
                    disabledBackgroundColor: Colors.grey,
                  ),
                  child: const Text("Update"),
                ),
              ],
            );
          },
        );
      },
    );
  }
}