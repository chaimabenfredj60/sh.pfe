import 'package:flutter/material.dart';
import '../models/task_model.dart';

class AddTaskDialog extends StatefulWidget {
  final Function(Task) onTaskAdded;

  const AddTaskDialog({super.key, required this.onTaskAdded});

  @override
  State<AddTaskDialog> createState() => _AddTaskDialogState();
}

class _AddTaskDialogState extends State<AddTaskDialog> {
  final _titleController = TextEditingController();
  final _descController = TextEditingController();
  TaskTag? _selectedTag;
  bool _isImportant = false;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      title: const Text(
        'Add Task',
        style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
      ),
      content: SizedBox(
        width: 360,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextField(
              controller: _titleController,
              autofocus: true,
              decoration: InputDecoration(
                labelText: 'Task title *',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                  borderSide: const BorderSide(color: Color(0xFF00B4A6), width: 2),
                ),
              ),
            ),
            const SizedBox(height: 12),
            TextField(
              controller: _descController,
              maxLines: 3,
              decoration: InputDecoration(
                labelText: 'Description (optional)',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                  borderSide: const BorderSide(color: Color(0xFF00B4A6), width: 2),
                ),
              ),
            ),
            const SizedBox(height: 12),
            const Text(
              'Tag',
              style: TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.w600,
                  color: Color(0xFF555555)),
            ),
            const SizedBox(height: 6),
            Wrap(
              spacing: 6,
              children: TaskTag.values.map((tag) {
                final selected = _selectedTag == tag;
                return FilterChip(
                  label: Text(tag.label,
                      style: TextStyle(
                          fontSize: 12,
                          color: selected ? Colors.white : tag.color)),
                  selected: selected,
                  onSelected: (_) =>
                      setState(() => _selectedTag = selected ? null : tag),
                  backgroundColor: tag.color.withOpacity(0.1),
                  selectedColor: tag.color,
                  checkmarkColor: Colors.white,
                  side: BorderSide(color: tag.color.withOpacity(0.4)),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20)),
                  padding: const EdgeInsets.symmetric(horizontal: 4),
                );
              }).toList(),
            ),
            const SizedBox(height: 8),
            Row(
              children: [
                Checkbox(
                  value: _isImportant,
                  onChanged: (v) => setState(() => _isImportant = v ?? false),
                  activeColor: const Color(0xFF00B4A6),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(4)),
                ),
                const Text('Mark as Important',
                    style: TextStyle(fontSize: 13, color: Color(0xFF555555))),
              ],
            ),
          ],
        ),
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(context),
          child: const Text('Cancel',
              style: TextStyle(color: Color(0xFF9E9E9E))),
        ),
        ElevatedButton(
          style: ElevatedButton.styleFrom(
            backgroundColor: const Color(0xFF00B4A6),
            foregroundColor: Colors.white,
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8)),
            elevation: 0,
          ),
          onPressed: () {
            if (_titleController.text.trim().isEmpty) return;
            widget.onTaskAdded(Task(
              id: DateTime.now().millisecondsSinceEpoch.toString(),
              title: _titleController.text.trim(),
              description: _descController.text.trim().isEmpty
                  ? null
                  : _descController.text.trim(),
              isImportant: _isImportant,
              tag: _selectedTag,
            ));
            Navigator.pop(context);
          },
          child: const Text('Add Task',
              style: TextStyle(fontWeight: FontWeight.w600)),
        ),
      ],
    );
  }
}