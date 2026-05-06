import 'package:cooptalite/screens/models/task_model.dart';
import 'package:cooptalite/screens/widgets/add_task_dialog.dart';
import 'package:cooptalite/screens/widgets/task_list_area.dart';
import 'package:cooptalite/screens/widgets/tasks_filter_panel.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/app_theme.dart';
import '../utils/theme_colors.dart';

class MyTasksScreen extends StatefulWidget {
  final bool isDarkMode;
  final String language;

  const MyTasksScreen({
    super.key,
    this.isDarkMode = false,
    this.language = 'en',
  });

  @override
  State<MyTasksScreen> createState() => _MyTasksScreenState();
}

class _MyTasksScreenState extends State<MyTasksScreen> {
  TaskFilter _selectedFilter = TaskFilter.myTasks;
  TaskTag? _selectedTag;
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

  void _addTask(Task task) => setState(() => _allTasks.add(task));
  void _toggleComplete(Task task) =>
      setState(() => task.isCompleted = !task.isCompleted);
  void _toggleImportant(Task task) =>
      setState(() => task.isImportant = !task.isImportant);
  void _deleteTask(Task task) => setState(() {
        task.isDeleted = true;
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
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final appTheme = context.watch<AppTheme>();

    return Scaffold(
      backgroundColor: ThemeColors.getBgColor(isDark),
      appBar: AppBar(
        title: Text(appTheme.translate('my_tasks')),
        centerTitle: false,
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 12),
            child: ElevatedButton.icon(
              onPressed: _openAddTaskDialog,
              icon: const Icon(Icons.add),
              label: Text(appTheme.translate('add_task')),
              style: ElevatedButton.styleFrom(
                backgroundColor: ThemeColors.primary,
                foregroundColor: Colors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
            ),
          ),
        ],
      ),
      body: Row(
        children: [
          // Filter Panel (Left)
          TasksFilterPanel(
            selectedFilter: _selectedFilter,
            selectedTag: _selectedTag,
            onFilterChanged: (f) => setState(() => _selectedFilter = f),
            onTagChanged: (t) => setState(() => _selectedTag = t),
            onAddTask: _openAddTaskDialog,
          ),
          VerticalDivider(
            width: 1,
            color: ThemeColors.getBorderColor(isDark),
          ),
          // Task List (Right)
          Expanded(
            child: TaskListArea(
              tasks: _filteredTasks,
              filterLabel: _selectedFilter.name,
              onToggleComplete: _toggleComplete,
              onToggleImportant: _toggleImportant,
              onDelete: _deleteTask,
            ),
          ),
        ],
      ),
    );
  }
}
