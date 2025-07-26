import 'dart:convert';
import 'package:localstorage/localstorage.dart';
import 'package:time_tracker/models/time_entry_model.dart';
import 'package:flutter/material.dart';
import 'package:time_tracker/models/project_model.dart';
import 'package:time_tracker/models/task_model.dart';

class TimeEntryProvider with ChangeNotifier {
  final LocalStorage storage;
  final List<TimeEntry> _entries = [];
  final List<Project> _projects = [];
  final List<Task> _tasks = [];
  TimeEntryProvider(this.storage) {
    _loadData();
  }

  Future<void> _loadData() async {
    final projectJson = storage.getItem('projects');
    final taskJson = storage.getItem('tasks');
    final entryJson = storage.getItem('timeEntries');

    print('[localStorage] Loading data from local storage');
    print('[localStorage] Projects: $projectJson');
    print('[localStorage] Tasks: $taskJson');
    print('[localStorage] Time Entries: $entryJson');
    _projects.clear();
    if (projectJson != null) {
      final projectList = List<Map<String, dynamic>>.from(
        jsonDecode(projectJson),
      );
      _projects.addAll(projectList.map((e) => Project.fromJson(e)));
    }
    _tasks.clear();
    if (taskJson != null) {
      final taskList = List<Map<String, dynamic>>.from(jsonDecode(taskJson));
      _tasks.addAll(taskList.map((e) => Task.fromJson(e)));
    }
    _entries.clear();
    if (entryJson != null) {
      final entryList = List<Map<String, dynamic>>.from(jsonDecode(entryJson));
      _entries.addAll(entryList.map((e) => TimeEntry.fromJson(e)));
    }
    notifyListeners();
  }

  List<TimeEntry> get entries => _entries;
  List<Project> get projects => _projects;
  List<Task> get tasks => _tasks;

  void addTimeEntry(TimeEntry entry) {
    _entries.add(entry);
    print(
      '[localStorage] Added timeEntry: id=${entry.id}, projectId=${entry.projectId}, taskId=${entry.taskId}, totalTime=${entry.totalTime}, date=${entry.date}, notes=${entry.notes}',
    );
    storage.setItem(
      'timeEntries',
      jsonEncode(_entries.map((e) => e.toJson()).toList()),
    );
    notifyListeners();
  }

  void deleteTimeEntry(String id) {
    _entries.removeWhere((entry) => entry.id == id);
    print('[localStorage] Deleted timeEntry: \\${id}');
    storage.setItem(
      'timeEntries',
      jsonEncode(_entries.map((e) => e.toJson()).toList()),
    );
    notifyListeners();
  }

  void addProject(Project project) {
    _projects.add(project);
    print(
      '[localStorage] Added project: id=${project.id}, name=${project.name}',
    );
    storage.setItem(
      'projects',
      jsonEncode(_projects.map((e) => e.toJson()).toList()),
    );
    notifyListeners();
  }

  void deleteProject(String id) {
    _projects.removeWhere((project) => project.id == id);
    print('[localStorage] Deleted project: \\${id}');
    storage.setItem(
      'projects',
      jsonEncode(_projects.map((e) => e.toJson()).toList()),
    );
    notifyListeners();
  }

  void addTask(Task task) {
    _tasks.add(task);
    print('[localStorage] Added task: id=${task.id}, name=${task.name}');
    storage.setItem(
      'tasks',
      jsonEncode(_tasks.map((e) => e.toJson()).toList()),
    );
    notifyListeners();
  }

  void deleteTask(String id) {
    _tasks.removeWhere((task) => task.id == id);
    print('[localStorage] Deleted task: \\${id}');
    storage.setItem(
      'tasks',
      jsonEncode(_tasks.map((e) => e.toJson()).toList()),
    );
    notifyListeners();
  }
}
