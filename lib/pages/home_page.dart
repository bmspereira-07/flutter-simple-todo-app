import 'package:flutter/material.dart';
import 'package:to_do_list/models/task.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  var tasks = <Task>[
    Task(text: 'Buy groceries', isCompleted: false),
    Task(text: 'Walk the dog', isCompleted: true),
    Task(text: 'Read a book', isCompleted: false),
  ];

  final newTaskController = TextEditingController();

  void _checkAllTasksCompleted() {
    final allCompleted = tasks.every((task) => task.isCompleted);
    if (allCompleted) {
      tasks.clear();
      debugPrint('All tasks are completed!');

      final snackBar = SnackBar(
        showCloseIcon: true,
        content: Center(
          child: Text(
            'Yay! All tasks completed!',
            style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
          ),
        ),
        backgroundColor: Theme.of(context).colorScheme.primary,
        behavior: SnackBarBehavior.floating,
        padding: EdgeInsets.symmetric(
          horizontal: 15.0,
          vertical: 10.0, // Inner padding for SnackBar content.
        ),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(8.0)),
        ),
      );
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
    } else {
      debugPrint('There are still incomplete tasks.');
    }
  }

  void _addTask(String taskText) {
    setState(() {
      tasks.add(Task(text: taskText, isCompleted: false));
    });
    newTaskController.clear();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Todo-it',
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
        backgroundColor: Theme.of(context).colorScheme.primaryContainer,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20.0),
        child: SafeArea(
          child: Column(
            children: [
              tasks.isEmpty
                  ? Flexible(
                      child: Center(
                        child: Text(
                          'No tasks added yet!',
                          style: TextStyle(
                            fontSize: 18,
                            color: Theme.of(
                              context,
                            ).colorScheme.primaryContainer,
                          ),
                        ),
                      ),
                    )
                  : Flexible(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(vertical: 15.0),
                        child: ListView.builder(
                          itemCount: tasks.length,
                          itemBuilder: (context, index) {
                            final task = tasks[index];
                            return Padding(
                              padding: const EdgeInsets.only(bottom: 10.0),
                              child: ListTile(
                                style: ListTileStyle.list,
                                tileColor: Colors.white24,
                                shape: RoundedRectangleBorder(
                                  side: BorderSide(
                                    color: Theme.of(
                                      context,
                                    ).colorScheme.primary,
                                    width: 2,
                                  ),
                                  borderRadius: BorderRadius.circular(8.0),
                                ),
                                title: Text(
                                  task.text,
                                  style: TextStyle(
                                    decoration: task.isCompleted
                                        ? TextDecoration.lineThrough
                                        : TextDecoration.none,
                                  ),
                                ),
                                trailing: Checkbox(
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(4.0),
                                  ),
                                  value: task.isCompleted,
                                  onChanged: (value) {
                                    setState(() {
                                      tasks[index] = Task(
                                        text: task.text,
                                        isCompleted: value!,
                                      );
                                      _checkAllTasksCompleted();
                                    });
                                  },
                                ),
                              ),
                            );
                          },
                        ),
                      ),
                    ),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Container(
                    padding: const EdgeInsets.all(15.0),
                    child: FloatingActionButton(
                      onPressed: () {
                        _showNewtaskDialog();
                        debugPrint('Add Task button pressed');
                      },
                      child: Icon(Icons.add),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> _showNewtaskDialog() {
    return showDialog<void>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: Colors.white,
          title: const Text('Add a new task'),
          content: TextField(
            controller: newTaskController,
            decoration: InputDecoration(
              hintText: 'Enter task here',
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8.0),
              ),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8.0),
              ),
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: const Text('Cancel'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            ElevatedButton(
              style: TextButton.styleFrom(
                backgroundColor: Theme.of(context).colorScheme.primary,
              ),
              child: const Text('Add', style: TextStyle(color: Colors.white)),
              onPressed: () {
                if (newTaskController.text.isNotEmpty) {
                  _addTask(newTaskController.text);
                  Navigator.of(context).pop();
                }
              },
            ),
          ],
        );
      },
    );
  }
}
