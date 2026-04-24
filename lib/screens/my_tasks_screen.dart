import 'package:cooptalite/screens/models/task_model.dart';
import 'package:cooptalite/screens/widgets/add_task_dialog.dart';
import 'package:cooptalite/screens/widgets/task_list_area.dart';
import 'package:cooptalite/screens/widgets/tasks_filter_panel.dart';
import 'package:flutter/material.dart';

class MyTasksScreen extends StatefulWidget {
  const MyTasksScreen({super.key});

  @override
  State<MyTasksScreen> createState() => _MyTasksScreenState();
}

class _MyTasksScreenState extends State<MyTasksScreen> {
  TaskFilter _selectedFilter = TaskFilter.myTasks;
  TaskTag?   _selectedTag;
  final List<Task> _allTasks = [];

  List<Task> get _filteredTasks {
    List<Task> tasks;
    switch (_selectedFilter) {
      case TaskFilter.myTasks:
        tasks = _allTasks.where((t) => !t.isDeleted && !t.isCompleted).toList();
        break;
      case TaskFilter.important:
        tasks = _allTasks.where((t) => !t.isDeleted && t.isImportant).toList();
        break;
      case TaskFilter.completed:
        tasks = _allTasks.where((t) => t.isCompleted).toList();
        break;
      case TaskFilter.deleted:
        tasks = _allTasks.where((t) => t.isDeleted).toList();
        break;
    }
    if (_selectedTag != null) {
      tasks = tasks.where((t) => t.tag == _selectedTag).toList();
    }
    return tasks;
  }

  void _addTask(Task task)         => setState(() => _allTasks.add(task));
  void _toggleComplete(Task task)  => setState(() => task.isCompleted = !task.isCompleted);
  void _toggleImportant(Task task) => setState(() => task.isImportant = !task.isImportant);
  void _deleteTask(Task task)      => setState(() {
    task.isDeleted   = true;
    task.isCompleted = false;
  });

  void _openAddTaskDialog() {
    showDialog(
      context: context,
      builder: (_) => AddTaskDialog(onTaskAdded: _addTask),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF4F5F7),
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Color(0xFF555555)),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text(
          'My Tasks',
          style: TextStyle(
            color: Color(0xFF1A1A2E),
            fontWeight: FontWeight.bold,
            fontSize: 16,
          ),
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 12),
            child: TextButton.icon(
              style: TextButton.styleFrom(
                backgroundColor: const Color(0xFF00B4A6),
                foregroundColor: Colors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
                padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
              ),
              icon: const Icon(Icons.add, size: 18),
              label: const Text(
                'Add Task',
                style: TextStyle(fontWeight: FontWeight.w600, fontSize: 13),
              ),
              onPressed: _openAddTaskDialog,
            ),
          ),
        ],
        bottom: const PreferredSize(
          preferredSize: Size.fromHeight(1),
          child: Divider(height: 1, color: Color(0xFFE0E0E0)),
        ),
      ),

      body: Row(
        children: [
          // Panneau filtres (gauche)
          TasksFilterPanel(
            selectedFilter:  _selectedFilter,
            selectedTag:     _selectedTag,
            onFilterChanged: (f) => setState(() => _selectedFilter = f),
            onTagChanged:    (t) => setState(() => _selectedTag    = t),
            onAddTask: _openAddTaskDialog,
          ),
          const VerticalDivider(width: 1, color: Color(0xFFE0E0E0)),
          // Liste des tâches (droite)
          Expanded(
            child: TaskListArea(
              tasks:             _filteredTasks,
              filterLabel:       _selectedFilter.name,
              onToggleComplete:  _toggleComplete,
              onToggleImportant: _toggleImportant,
              onDelete:          _deleteTask,
            ),
          ),
        ],
      ),
    );
  }
}