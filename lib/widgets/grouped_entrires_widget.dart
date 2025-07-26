import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:time_tracker/providers/project_task_provider.dart';

class GroupedEntriresWidget extends StatelessWidget {
  const GroupedEntriresWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final entries = Provider.of<TimeEntryProvider>(context).entries;
    if (entries.isEmpty) {
      return Center(
        child: Text(
          'No entries found',
          style: TextStyle(fontSize: 18, color: Colors.grey),
        ),
      );
    }

    // Group by projectId, then by taskId
    final Map<String, Map<String, List>> grouped = {};
    for (var entry in entries) {
      grouped.putIfAbsent(entry.projectId, () => {});
      grouped[entry.projectId]!.putIfAbsent(entry.taskId, () => []);
      grouped[entry.projectId]![entry.taskId]!.add(entry);
    }

    return ListView(
      padding: EdgeInsets.symmetric(vertical: 12, horizontal: 8),
      children:
          grouped.entries.map((projectGroup) {
            final projectId = projectGroup.key;
            final tasks = projectGroup.value;
            return Card(
              elevation: 2,
              margin: EdgeInsets.symmetric(vertical: 8, horizontal: 8),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(14),
              ),
              child: Padding(
                padding: const EdgeInsets.all(12.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Project: $projectId',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 18,
                        color: Colors.deepPurple,
                      ),
                    ),
                    ...tasks.entries.map((taskGroup) {
                      final taskId = taskGroup.key;
                      final taskEntries = taskGroup.value;
                      return Padding(
                        padding: const EdgeInsets.only(left: 12.0, top: 8.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Task: $taskId',
                              style: TextStyle(
                                fontWeight: FontWeight.w600,
                                fontSize: 16,
                                color: Colors.deepPurple.shade300,
                              ),
                            ),
                            ...taskEntries.map<Widget>(
                              (entry) => Padding(
                                padding: const EdgeInsets.only(
                                  left: 12.0,
                                  top: 6.0,
                                  bottom: 6.0,
                                ),
                                child: Container(
                                  decoration: BoxDecoration(
                                    color: Colors.deepPurple.shade50,
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  child: ListTile(
                                    title: Text('Time: ${entry.totalTime} hrs'),
                                    subtitle: Text(
                                      'Date: ${entry.date.toLocal().toString().split(' ')[0]}',
                                    ),
                                    trailing:
                                        entry.notes.isNotEmpty
                                            ? Icon(
                                              Icons.note,
                                              color: Colors.deepPurple,
                                            )
                                            : null,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      );
                    }).toList(),
                  ],
                ),
              ),
            );
          }).toList(),
    );
  }
}
