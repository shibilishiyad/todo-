import 'package:hive/hive.dart';

part 'todomodel.g.dart'; 

@HiveType(typeId: 0)
class Todo {
  @HiveField(0)
  late String title;

  @HiveField(1)
  late String description;

  @HiveField(2)
  late bool completed;

  @HiveField(3)
  late DateTime createdAt;

  Todo({
    required this.completed,
    required this.createdAt,
    required this.description,
    required this.title,
  });
}
