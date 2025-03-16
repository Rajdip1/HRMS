import 'package:flutter/material.dart';

class ProjectSectionScreen extends StatefulWidget {
  const ProjectSectionScreen({super.key});

  @override
  State<ProjectSectionScreen> createState() => _ProjectSectionScreenState();
}

class _ProjectSectionScreenState extends State<ProjectSectionScreen> {

  List<ProjectData> projects = [
    ProjectData(
      title: "Apart",
      client: "Kartik Mishra",
      status: "On Hold",
      priority: "Medium",
      isActive: false,
      startDate: "12 Dec 2025",
      dueDate: "12 Feb 2026",
    ),
    ProjectData(
      title: "Teaser",
      client: "Mayur Panchal",
      status: "In Progress",
      priority: "High",
      isActive: true,
      startDate: "22 Feb 2025",
      dueDate: "28 Feb 2025",
    ),
    ProjectData(
      title: "Super Model",
      client: "Apurva Devol",
      status: "In Progress",
      priority: "Low",
      isActive: true,
      startDate: "30 Jan 2025",
      dueDate: "24 April 2025",
    ),
  ];

  void addProject(ProjectData project) {
    setState(() {
      projects.add(project);
    });
  }

  void deleteProject(int index) {
    setState(() {
      projects.removeAt(index);
    });
  }

  void showAddProjectDialog() {
    String title = "", client = "", status = "", priority = "", startDate = "", dueDate = "";

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text("Add Project"),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
              decoration: InputDecoration(labelText: "Project Name"),
              onChanged: (value) => title = value,
            ),
            TextField(
              decoration: InputDecoration(labelText: "Client Name"),
              onChanged: (value) => client = value,
            ),
            TextField(
              decoration: InputDecoration(labelText: "Start Date"),
              onChanged: (value) => startDate = value,
            ),
            TextField(
              decoration: InputDecoration(labelText: "Due Date"),
              onChanged: (value) => dueDate = value,
            ),
            TextField(
              decoration: InputDecoration(labelText: "status"),
              onChanged: (value) =>status = value,
            ),
            TextField(
              decoration: InputDecoration(labelText: "priority"),
              onChanged: (value) =>priority = value,
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text("Cancel"),
          ),
          ElevatedButton(
            onPressed: () {
              if (title.isNotEmpty && client.isNotEmpty) {
                addProject(ProjectData(
                  title: title,
                  client: client,
                  status: status,
                  priority: priority,
                  isActive: true,
                  startDate: startDate,
                  dueDate: dueDate,
                ));
                Navigator.pop(context);
              }
            },
            child: Text("Add"),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Projects'),
        actions: [
          IconButton(
            icon: Icon(Icons.add),
            onPressed: showAddProjectDialog,
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            ProjectFilterSection(),
            Expanded(
              child: ListView.builder(
                itemCount: projects.length,
                itemBuilder: (context, index) {
                  return ProjectCard(
                    project: projects[index],
                    onDelete: () => deleteProject(index),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class ProjectFilterSection extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10.0),
      child: Row(
        children: [
          Expanded(
            child: DropdownButtonFormField(
              decoration: InputDecoration(
                labelText: "Search by Project",
                border: OutlineInputBorder(),
              ),
              items: [],
              onChanged: (value) {},
            ),
          ),
          SizedBox(width: 10),
          ElevatedButton(
            onPressed: () {},
            child: Text("Filter"),
          ),
        ],
      ),
    );
  }
}

class ProjectCard extends StatelessWidget {
  final ProjectData project;
  final VoidCallback onDelete;

  ProjectCard({required this.project, required this.onDelete});

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  project.title,
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                PopupMenuButton<String>(
                  onSelected: (value) {
                    if (value == "Delete") onDelete();
                  },
                  itemBuilder: (context) => [
                    PopupMenuItem(value: "Edit", child: Text("Edit")),
                    PopupMenuItem(value: "View", child: Text("View")),
                    PopupMenuItem(value: "Delete", child: Text("Delete")),
                  ],
                ),
              ],
            ),
            Text("Client: ${project.client}"),
            SizedBox(height: 5),
            Row(
              children: [
                Chip(label: Text(project.status)),
                SizedBox(width: 5),
                Chip(label: Text(project.priority)),
                SizedBox(width: 5),
                Chip(label: Text(project.isActive ? "Active" : "Inactive")),
              ],
            ),
            SizedBox(height: 5),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text("Start Date"),
                    Text(project.startDate, style: TextStyle(fontWeight: FontWeight.bold)),
                  ],
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text("Due Date"),
                    Text(project.dueDate, style: TextStyle(fontWeight: FontWeight.bold)),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class ProjectData {
  final String title, client, status, priority, startDate, dueDate;
  final bool isActive;

  ProjectData({
    required this.title,
    required this.client,
    required this.status,
    required this.priority,
    required this.isActive,
    required this.startDate,
    required this.dueDate,
  });
}
