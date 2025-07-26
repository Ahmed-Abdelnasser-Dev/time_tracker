import 'package:flutter/material.dart';
import 'package:time_tracker/widgets/all_entries_widget.dart';
import 'package:time_tracker/widgets/grouped_entrires_widget.dart';

class HomeView extends StatelessWidget {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      initialIndex: 0,
      length: 2,
      child: Scaffold(
        //* AppBar with title and TabBar
        appBar: AppBar(
          title: Text('Time Tracker'),
          centerTitle: true,
          backgroundColor: Colors.deepPurple,
          foregroundColor: Colors.white,
          bottom: TabBar(
            indicatorColor: Colors.white,
            labelColor: Colors.white,
            unselectedLabelColor: Colors.white70,
            tabs: <Widget>[
              Tab(text: 'All Entries'),
              Tab(text: 'Grouped Entries'),
            ],
          ),
        ),

        //* Drawer for navigation
        drawer: Drawer(
          child: ListView(
            children: [
              DrawerHeader(
                decoration: BoxDecoration(color: Colors.deepPurple),
                child: Center(
                  child: Text(
                    'Menu',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
              ListTile(
                title: Text(
                  'Manage Projects',
                  style: TextStyle(fontWeight: FontWeight.w600, fontSize: 18),
                ),
                leading: Icon(Icons.folder, color: Colors.deepPurple),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                tileColor: Colors.deepPurple.shade50,
                onTap: () {
                  Navigator.pop(context);
                  Navigator.pushNamed(context, '/manageProjects');
                },
              ),
              Divider(),
              ListTile(
                title: Text(
                  'Manage Tasks',
                  style: TextStyle(fontWeight: FontWeight.w600, fontSize: 18),
                ),
                leading: Icon(Icons.task, color: Colors.deepPurple),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                tileColor: Colors.deepPurple.shade50,
                onTap: () {
                  Navigator.pop(context);
                  Navigator.pushNamed(context, '/manageTasks');
                },
              ),
            ],
          ),
        ),
        //* TabBarView to switch between Projects and Tasks
        body: TabBarView(
          children: <Widget>[AllEntriesWidget(), GroupedEntriresWidget()],
        ),

        //* Button to add time entry
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            Navigator.pushNamed(context, '/addTimeEntry');
          },
          tooltip: 'Add Time Entry',
          child: Icon(Icons.add),
        ),
      ),
    );
  }
}
