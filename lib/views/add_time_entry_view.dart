import 'package:flutter/material.dart';
import 'package:time_tracker/models/time_entry_model.dart';
import 'package:provider/provider.dart';
import 'package:time_tracker/providers/project_task_provider.dart';

class AddTimeEntryView extends StatelessWidget {
  const AddTimeEntryView({super.key});

  @override
  Widget build(BuildContext context) {
    final TextEditingController projectController = TextEditingController();
    final TextEditingController taskController = TextEditingController();
    final TextEditingController notesController = TextEditingController();
    final TextEditingController timeController = TextEditingController();
    DateTime? selectedDate;

    return Scaffold(
      appBar: AppBar(
        title: Text('Add Time Entry'),
        centerTitle: true,
        backgroundColor: Colors.deepPurple,
        foregroundColor: Colors.white,
        elevation: 0,
      ),
      body: StatefulBuilder(
        builder: (context, setState) {
          return Card(
            elevation: 0,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 24),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  TextField(
                    controller: projectController,
                    decoration: InputDecoration(
                      labelText: 'Project',
                      border: OutlineInputBorder(),
                    ),
                  ),
                  SizedBox(height: 12),
                  TextField(
                    controller: taskController,
                    decoration: InputDecoration(
                      labelText: 'Task',
                      border: OutlineInputBorder(),
                    ),
                  ),
                  SizedBox(height: 12),
                  TextField(
                    controller: timeController,
                    decoration: InputDecoration(
                      labelText: 'Total Time (hours)',
                      border: OutlineInputBorder(),
                    ),
                    keyboardType: TextInputType.number,
                  ),
                  SizedBox(height: 12),
                  TextField(
                    decoration: InputDecoration(
                      labelText: 'Date',
                      border: OutlineInputBorder(),
                      suffixIcon: Icon(Icons.calendar_today, size: 20),
                    ),
                    readOnly: true,
                    controller: TextEditingController(
                      text:
                          selectedDate == null
                              ? ''
                              : "${selectedDate!.year}-${selectedDate!.month.toString().padLeft(2, '0')}-${selectedDate!.day.toString().padLeft(2, '0')}",
                    ),
                    onTap: () async {
                      DateTime? pickedDate = await showDatePicker(
                        context: context,
                        initialDate: DateTime.now(),
                        firstDate: DateTime(2000),
                        lastDate: DateTime(2100),
                      );
                      if (pickedDate != null) {
                        setState(() {
                          selectedDate = pickedDate;
                        });
                      }
                    },
                  ),
                  SizedBox(height: 12),
                  TextField(
                    controller: notesController,
                    decoration: InputDecoration(
                      labelText: 'Notes',
                      maintainHintHeight: true,
                      border: OutlineInputBorder(),
                    ),
                    maxLines: 6,
                  ),
                  SizedBox(height: 20),
                  ElevatedButton(
                    onPressed: () {
                      if (projectController.text.isEmpty ||
                          taskController.text.isEmpty ||
                          timeController.text.isEmpty ||
                          selectedDate == null) {
                        return;
                      }
                      final entry = TimeEntry(
                        id: DateTime.now().millisecondsSinceEpoch.toString(),
                        projectId: projectController.text,
                        taskId: taskController.text,
                        totalTime: double.tryParse(timeController.text) ?? 0.0,
                        date: selectedDate!,
                        notes: notesController.text,
                      );
                      Provider.of<TimeEntryProvider>(
                        context,
                        listen: false,
                      ).addTimeEntry(entry);
                      Navigator.pop(context, entry);
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.deepPurple,
                      foregroundColor: Colors.white,
                      padding: EdgeInsets.symmetric(vertical: 14),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                      elevation: 0,
                    ),
                    child: Text(
                      'Save',
                      style: TextStyle(fontWeight: FontWeight.w600),
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
