import 'package:flutter/foundation.dart';

import 'dart:collection';

import './task.dart';

class TaskData extends ChangeNotifier {
  List<Task> _tasks = [];
  TaskData(){
    for(int i=0 ;i<20; i++)
    _tasks.add(
  Task(name: 'mohammad Faisal mohammad Alodat',referNumber: '123456789'
  ,status: 'open',question: 'what is your name',requestDate: '20-01-2021')
    );
  }



  UnmodifiableListView<Task> get tasks {
    return UnmodifiableListView(_tasks);
  }

  int get taskCount {
    return _tasks.length;
  }

  void addTask(String newTaskTitle) {
    final task = Task(name: newTaskTitle);
    _tasks.add(task);
    notifyListeners();
  }

  void updateTask(Task task) {
    task.toggleDone();
    notifyListeners();
  }

  void deleteTask(Task task) {
    _tasks.remove(task);
    notifyListeners();
  }
}
