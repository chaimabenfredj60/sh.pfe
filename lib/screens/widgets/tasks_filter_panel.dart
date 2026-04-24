import 'package:flutter/material.dart';
import '../models/task_model.dart';

enum TaskFilter { myTasks, important, completed, deleted }

class TasksFilterPanel extends StatelessWidget {
  final TaskFilter selectedFilter;
  final TaskTag? selectedTag;
  final ValueChanged<TaskFilter> onFilterChanged;
  final ValueChanged<TaskTag?> onTagChanged;
  final VoidCallback onAddTask;

  const TasksFilterPanel({
    super.key,
    required this.selectedFilter,
    required this.selectedTag,
    required this.onFilterChanged,
    required this.onTagChanged,
    required this.onAddTask,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 200,
      color: Colors.white,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // ── Add Task button ────────────────────────────────────────────
          Padding(
            padding: const EdgeInsets.all(12),
            child: SizedBox(
              width: double.infinity,
              child: ElevatedButton.icon(
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF00B4A6),
                  foregroundColor: Colors.white,
                  padding: const EdgeInsets.symmetric(vertical: 12),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(6),
                  ),
                  elevation: 0,
                ),
                icon: const Icon(Icons.add, size: 18),
                label: const Text(
                  'Add Task',
                  style: TextStyle(fontWeight: FontWeight.w600, fontSize: 14),
                ),
                onPressed: onAddTask,
              ),
            ),
          ),

          // ── Filter items ───────────────────────────────────────────────
          _filterItem(
            icon: Icons.inbox_outlined,
            label: 'My Tasks',
            filter: TaskFilter.myTasks,
            isActive: selectedFilter == TaskFilter.myTasks && selectedTag == null,
          ),
          _filterItem(
            icon: Icons.star_outline,
            label: 'Important',
            filter: TaskFilter.important,
            isActive: selectedFilter == TaskFilter.important && selectedTag == null,
          ),
          _filterItem(
            icon: Icons.check_circle_outline,
            label: 'Completed',
            filter: TaskFilter.completed,
            isActive: selectedFilter == TaskFilter.completed && selectedTag == null,
          ),
          _filterItem(
            icon: Icons.delete_outline,
            label: 'Deleted',
            filter: TaskFilter.deleted,
            isActive: selectedFilter == TaskFilter.deleted && selectedTag == null,
          ),

          const SizedBox(height: 8),
          const Divider(height: 1, color: Color(0xFFF0F0F0)),
          const SizedBox(height: 8),

          // ── Tags section ───────────────────────────────────────────────
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  'TAGS',
                  style: TextStyle(
                    fontSize: 10,
                    fontWeight: FontWeight.w700,
                    color: Color(0xFF9E9E9E),
                    letterSpacing: 1.0,
                  ),
                ),
                Icon(Icons.add, size: 16, color: const Color(0xFF9E9E9E)),
              ],
            ),
          ),
          const SizedBox(height: 4),

          ...TaskTag.values.map((tag) => _tagItem(tag)),
        ],
      ),
    );
  }

  Widget _filterItem({
    required IconData icon,
    required String label,
    required TaskFilter filter,
    required bool isActive,
  }) {
    return InkWell(
      onTap: () => onFilterChanged(filter),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
        child: Row(
          children: [
            Icon(
              icon,
              size: 17,
              color: isActive
                  ? const Color(0xFF00B4A6)
                  : const Color(0xFF9E9E9E),
            ),
            const SizedBox(width: 10),
            Text(
              label,
              style: TextStyle(
                fontSize: 13,
                color: isActive
                    ? const Color(0xFF00B4A6)
                    : const Color(0xFF555555),
                fontWeight: isActive ? FontWeight.w600 : FontWeight.normal,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _tagItem(TaskTag tag) {
    final isActive = selectedTag == tag;
    return InkWell(
      onTap: () => onTagChanged(isActive ? null : tag),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 9),
        child: Row(
          children: [
            Container(
              width: 10,
              height: 10,
              decoration: BoxDecoration(
                color: tag.color,
                shape: BoxShape.circle,
              ),
            ),
            const SizedBox(width: 10),
            Text(
              tag.label,
              style: TextStyle(
                fontSize: 13,
                color: isActive ? const Color(0xFF00B4A6) : const Color(0xFF555555),
                fontWeight: isActive ? FontWeight.w600 : FontWeight.normal,
              ),
            ),
          ],
        ),
      ),
    );
  }
}