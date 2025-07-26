import 'package:localstorage/localstorage.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:time_tracker/providers/project_task_provider.dart';
import 'package:time_tracker/views/manage_projects_view.dart';
import 'package:time_tracker/views/manage_tasks_view.dart';
import 'package:time_tracker/views/home_view.dart';
import 'package:time_tracker/views/add_time_entry_view.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await initLocalStorage();
  runApp(MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => TimeEntryProvider(localStorage),
      child: MaterialApp(
        title: 'Time Tracker',
        initialRoute: '/',
        routes: {
          '/': (context) => HomeView(),
          '/addTimeEntry': (context) => AddTimeEntryView(),
          '/manageProjects': (context) => ManageProjectsView(),
          '/manageTasks': (context) => ManageTasksView(),
        },
      ),
    );
  }
}
