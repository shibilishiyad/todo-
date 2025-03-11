// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'package:todo_app/model/todomodel.dart';
import 'package:todo_app/service/todo_service.dart';

class CompletedTasksScreen extends StatefulWidget {
  const CompletedTasksScreen({super.key});

  @override
  State<CompletedTasksScreen> createState() => _CompletedTasksScreenState();
}

class _CompletedTasksScreenState extends State<CompletedTasksScreen> {
  final TodoService _todoService = TodoService(); 
  List<Todo> _completedTodos = [];

  Future<void> _loadCompletedTasks() async {
    final todos = await _todoService.getaTodos();
    setState(() {
      _completedTodos = todos.where((todo) => todo.completed).toList();
    });
  }

  @override
  void initState() {
    _loadCompletedTasks();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Column(
        children: [
          const SizedBox(height: 20),
          Expanded(
            child:
                _completedTodos.isEmpty
                    ? const Center(
                      child: Text(
                        "No completed tasks yet!",
                        style: TextStyle(
                          color: Colors.white70,
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    )
                    : ListView.builder(
                      itemCount: _completedTodos.length,
                      itemBuilder: (context, index) {
                        final todo = _completedTodos[index];
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
                                  const Icon(
                                    Icons.check_circle,
                                    color: Colors.green,
                                  ),
                                  IconButton(
                                    icon: const Icon(
                                      Icons.delete,
                                      color: Colors.red,
                                    ),
                                    onPressed: () async {
                                      final confirm = await showDialog<bool>(
                                        context: context,
                                        builder:
                                            (context) => AlertDialog(
                                              title: const Text("Delete Task"),
                                              content: const Text(
                                                "Are you sure you want to delete this completed task?",
                                              ),
                                              actions: [
                                                TextButton(
                                                  onPressed:
                                                      () => Navigator.pop(
                                                        context,
                                                        false,
                                                      ),
                                                  child: const Text("Cancel"),
                                                ),
                                                TextButton(
                                                  onPressed:
                                                      () => Navigator.pop(
                                                        context,
                                                        true,
                                                      ),
                                                  child: const Text("Delete"),
                                                ),
                                              ],
                                            ),
                                      );
                                      if (confirm == true) {
                                        final allTodos =
                                            await _todoService.getaTodos();
                                        final hiveIndex = allTodos.indexOf(
                                          todo,
                                        );
                                        await _todoService.deleteTodo(
                                          hiveIndex,
                                        );
                                        _loadCompletedTasks();
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
}
