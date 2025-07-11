import 'package:flutter/material.dart';

class Task {
  String id;
  String title;
  String description;
  DateTime dueTime;
  bool isCompleted;
  Color color;
  String category;

  Task({
    required this.id,
    required this.title,
    required this.description,
    required this.dueTime,
    this.isCompleted = false,
    required this.color,
    required this.category,
  });

  // Factory constructor to create a Task from a map (useful for editing)
  factory Task.fromMap(Map<String, dynamic> map) {
    return Task(
      id: map['id'],
      title: map['title'],
      description: map['description'],
      dueTime: DateTime.parse(map['dueTime']),
      isCompleted: map['isCompleted'],
      color: Color(map['color']),
      category: map['category'],
    );
  }

  // Convert Task to a map (useful for editing)
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'title': title,
      'description': description,
      'dueTime': dueTime.toIso8601String(),
      'isCompleted': isCompleted,
      'color': color.value,
      'category': category,
    };
  }
}