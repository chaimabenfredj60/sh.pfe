import 'package:flutter/material.dart';

enum TaskTag { team, low, medium, high, update }

extension TaskTagExtension on TaskTag {
  String get label {
    switch (this) {
      case TaskTag.team: return 'Team';
      case TaskTag.low: return 'Low';
      case TaskTag.medium: return 'Medium';
      case TaskTag.high: return 'High';
      case TaskTag.update: return 'Update';
    }
  }

  Color get color {
    switch (this) {
      case TaskTag.team: return const Color(0xFF4CAF50);
      case TaskTag.low: return const Color(0xFF4CAF50);
      case TaskTag.medium: return const Color(0xFFFF9800);
      case TaskTag.high: return const Color(0xFFF44336);
      case TaskTag.update: return const Color(0xFF00BCD4);
    }
  }
}

class Task {
  final String id;
  String title;
  String? description;
  bool isImportant;
  bool isCompleted;
  bool isDeleted;
  TaskTag? tag;
  DateTime? dueDate;

  Task({
    required this.id,
    required this.title,
    this.description,
    this.isImportant = false,
    this.isCompleted = false,
    this.isDeleted = false,
    this.tag,
    this.dueDate,
  });
}