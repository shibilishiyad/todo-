import 'package:flutter/material.dart';
import 'package:todo_app/screen%20/Completed%20.dart';
import 'package:todo_app/screen%20/pending.dart';


class InitialScreen extends StatelessWidget {
  const InitialScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2, 
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.black,
          title: const Text("All Tasks",style: TextStyle(color: Colors.white),),
         bottom: const TabBar(
  indicatorColor: Color.fromARGB(255, 19, 20, 19), 
  labelColor: Colors.green,     
  unselectedLabelColor: Colors.white, 
  tabs: [
    Tab(
      child: Text(
        "Pending",
        style: TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.bold,
          letterSpacing: 1.2,
        ),
      ),
    ),
    Tab(
      child: Text(
        "Completed",
        style: TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.bold,
          letterSpacing: 1.2,
        ),
      ),
    ),
  ],
)

        ),
        body: const TabBarView(
          children: [
                  PendingTasksScreen(), 
               CompletedTasksScreen(),
      
    
          ],
        ),
      ),
    );
  }
}