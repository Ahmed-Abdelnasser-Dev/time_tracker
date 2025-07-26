import 'package:time_tracker/models/time_entry_model.dart';
import 'package:flutter/material.dart';

class TimeEntryProvider with ChangeNotifier {
  List<TimeEntry> _entries = [];
  List<TimeEntry> get entries => _entries;
  void addTimeEntry(TimeEntry entry) {
    _entries.add(entry);
    notifyListeners();
  }

  void deleteTimeEntry(String id) {
    _entries.removeWhere((entry) => entry.id == id);
    notifyListeners();
  }
}
