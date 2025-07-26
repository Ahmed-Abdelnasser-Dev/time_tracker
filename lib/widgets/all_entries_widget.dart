import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:time_tracker/providers/project_task_provider.dart';

class AllEntriesWidget extends StatelessWidget {
  const AllEntriesWidget({super.key});

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
    return ListView.builder(
      itemCount: entries.length,
      itemBuilder: (context, index) {
        final entry = entries[index];
        return Card(
          elevation: 3,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          margin: EdgeInsets.symmetric(horizontal: 16, vertical: 10),
          color: Colors.deepPurple.shade50,
          child: Padding(
            padding: const EdgeInsets.all(12.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Icon(Icons.folder, color: Colors.deepPurple, size: 28),
                    SizedBox(width: 10),
                    Expanded(
                      child: Text(
                        'Project: ${entry.projectId}',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 18,
                        ),
                      ),
                    ),
                    IconButton(
                      icon: Icon(Icons.delete, color: Colors.red),
                      tooltip: 'Delete Entry',
                      onPressed: () async {
                        final confirmed = await showDialog<bool>(
                          context: context,
                          builder:
                              (context) => AlertDialog(
                                title: Text('Delete Entry'),
                                content: Text(
                                  'Are you sure you want to delete this entry? This action cannot be undone.',
                                ),
                                actions: [
                                  TextButton(
                                    onPressed:
                                        () => Navigator.of(context).pop(false),
                                    child: Text('Cancel'),
                                  ),
                                  ElevatedButton(
                                    onPressed:
                                        () => Navigator.of(context).pop(true),
                                    child: Text('Delete'),
                                  ),
                                ],
                              ),
                        );
                        if (confirmed == true) {
                          Provider.of<TimeEntryProvider>(
                            context,
                            listen: false,
                          ).deleteTimeEntry(entry.id);
                        }
                      },
                    ),
                  ],
                ),
                SizedBox(height: 8),
                Row(
                  children: [
                    Icon(
                      Icons.task,
                      color: Colors.deepPurple.shade200,
                      size: 22,
                    ),
                    SizedBox(width: 8),
                    Text(
                      'Task: ${entry.taskId}',
                      style: TextStyle(fontSize: 16),
                    ),
                  ],
                ),
                SizedBox(height: 8),
                Row(
                  children: [
                    Icon(
                      Icons.timer,
                      color: Colors.deepPurple.shade200,
                      size: 22,
                    ),
                    SizedBox(width: 8),
                    Text(
                      'Time: ${entry.totalTime} hrs',
                      style: TextStyle(fontSize: 16),
                    ),
                    SizedBox(width: 24),
                    Icon(
                      Icons.calendar_today,
                      color: Colors.deepPurple.shade200,
                      size: 22,
                    ),
                    SizedBox(width: 8),
                    Text(
                      'Date: ${entry.date.toLocal().toString().split(' ')[0]}',
                      style: TextStyle(fontSize: 16),
                    ),
                  ],
                ),
                if (entry.notes.isNotEmpty) ...[
                  SizedBox(height: 10),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Icon(
                        Icons.note,
                        color: Colors.deepPurple.shade200,
                        size: 22,
                      ),
                      SizedBox(width: 8),
                      Expanded(
                        child: Text(
                          entry.notes,
                          style: TextStyle(
                            fontSize: 15,
                            fontStyle: FontStyle.italic,
                            color: Colors.deepPurple,
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ],
            ),
          ),
        );
      },
    );
  }
}
