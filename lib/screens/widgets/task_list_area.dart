import 'package:flutter/material.dart';
import '../models/task_model.dart';

class TaskListArea extends StatelessWidget {
  final List<Task> tasks;
  final String filterLabel;
  final Function(Task) onToggleComplete;
  final Function(Task) onToggleImportant;
  final Function(Task) onDelete;

  const TaskListArea({
    super.key,
    required this.tasks,
    required this.filterLabel,
    required this.onToggleComplete,
    required this.onToggleImportant,
    required this.onDelete,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // ── Search bar ───────────────────────────────────────────────────
        Container(
          color: Colors.white,
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
          child: Row(
            children: [
              Expanded(
                child: Container(
                  height: 38,
                  decoration: BoxDecoration(
                    color: const Color(0xFFF4F5F7),
                    borderRadius: BorderRadius.circular(6),
                    border: Border.all(color: const Color(0xFFE0E0E0)),
                  ),
                  child: const TextField(
                    decoration: InputDecoration(
                      hintText: 'Search tasks',
                      hintStyle:
                          TextStyle(fontSize: 13, color: Color(0xFFBDBDBD)),
                      prefixIcon: Icon(Icons.search,
                          size: 18, color: Color(0xFFBDBDBD)),
                      border: InputBorder.none,
                      contentPadding: EdgeInsets.symmetric(vertical: 10),
                    ),
                  ),
                ),
              ),
              const SizedBox(width: 10),
              Icon(Icons.more_vert, size: 20, color: const Color(0xFF9E9E9E)),
            ],
          ),
        ),

        const Divider(height: 1, color: Color(0xFFEEEEEE)),

        // ── Tasks list ───────────────────────────────────────────────────
        Expanded(
          child: tasks.isEmpty
              ? _emptyState()
              : ListView.separated(
                  padding: const EdgeInsets.symmetric(vertical: 8),
                  itemCount: tasks.length,
                  separatorBuilder: (_, __) =>
                      const Divider(height: 1, color: Color(0xFFF0F0F0)),
                  itemBuilder: (context, index) {
                    final task = tasks[index];
                    return _taskTile(context, task);
                  },
                ),
        ),
      ],
    );
  }

  Widget _emptyState() {
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            width: 64,
            height: 64,
            decoration: BoxDecoration(
              color: const Color(0xFFF0F0F0),
              shape: BoxShape.circle,
            ),
            child: const Icon(Icons.check_box_outline_blank,
                size: 32, color: Color(0xFFBDBDBD)),
          ),
          const SizedBox(height: 16),
          Text(
            'No tasks found',
            style: const TextStyle(
              fontSize: 15,
              color: Color(0xFF9E9E9E),
              fontWeight: FontWeight.w500,
            ),
          ),
          const SizedBox(height: 6),
          const Text(
            'Click "Add Task" to create your first task.',
            style: TextStyle(fontSize: 12, color: Color(0xFFBDBDBD)),
          ),
        ],
      ),
    );
  }

  Widget _taskTile(BuildContext context, Task task) {
    return Container(
      color: Colors.white,
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          // Checkbox
          GestureDetector(
            onTap: () => onToggleComplete(task),
            child: Container(
              width: 20,
              height: 20,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(
                  color: task.isCompleted
                      ? const Color(0xFF00B4A6)
                      : const Color(0xFFBDBDBD),
                  width: 2,
                ),
                color: task.isCompleted
                    ? const Color(0xFF00B4A6)
                    : Colors.transparent,
              ),
              child: task.isCompleted
                  ? const Icon(Icons.check, size: 13, color: Colors.white)
                  : null,
            ),
          ),
          const SizedBox(width: 12),

          // Title + description + tag
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  task.title,
                  style: TextStyle(
                    fontSize: 14,
                    color: task.isCompleted
                        ? const Color(0xFFBDBDBD)
                        : const Color(0xFF222222),
                    decoration:
                        task.isCompleted ? TextDecoration.lineThrough : null,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                if (task.description != null && task.description!.isNotEmpty)
                  Padding(
                    padding: const EdgeInsets.only(top: 2),
                    child: Text(
                      task.description!,
                      style: const TextStyle(
                          fontSize: 12, color: Color(0xFF9E9E9E)),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                if (task.tag != null)
                  Padding(
                    padding: const EdgeInsets.only(top: 4),
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 8, vertical: 2),
                      decoration: BoxDecoration(
                        color: task.tag!.color.withOpacity(0.12),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Container(
                            width: 6,
                            height: 6,
                            decoration: BoxDecoration(
                              color: task.tag!.color,
                              shape: BoxShape.circle,
                            ),
                          ),
                          const SizedBox(width: 4),
                          Text(
                            task.tag!.label,
                            style: TextStyle(
                              fontSize: 11,
                              color: task.tag!.color,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
              ],
            ),
          ),

          // Actions
          Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              IconButton(
                icon: Icon(
                  task.isImportant ? Icons.star : Icons.star_outline,
                  size: 18,
                  color: task.isImportant
                      ? const Color(0xFFFFB300)
                      : const Color(0xFFBDBDBD),
                ),
                onPressed: () => onToggleImportant(task),
                padding: EdgeInsets.zero,
                constraints: const BoxConstraints(minWidth: 30, minHeight: 30),
              ),
              IconButton(
                icon: const Icon(Icons.delete_outline,
                    size: 18, color: Color(0xFFBDBDBD)),
                onPressed: () => onDelete(task),
                padding: EdgeInsets.zero,
                constraints: const BoxConstraints(minWidth: 30, minHeight: 30),
              ),
            ],
          ),
        ],
      ),
    );
  }
}