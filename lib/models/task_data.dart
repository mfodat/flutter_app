import 'package:flutter/foundation.dart';

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



}
