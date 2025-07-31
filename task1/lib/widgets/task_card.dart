import 'package:flutter/material.dart';
import 'package:task1/models/task.dart'; // Import Task model
import 'package:task1/widgets/add_edit_task_dialog.dart'; // Import AddEditTaskDialog

class TaskCard extends StatelessWidget {
  final Task task;
  final VoidCallback onToggle;
  final VoidCallback onDelete;
  final Function(Task) onEdit;
  final VoidCallback onViewDetails;

  const TaskCard({
    super.key,
    required this.task,
    required this.onToggle,
    required this.onDelete,
    required this.onEdit,
    required this.onViewDetails,
  });

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 300),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.1),
            blurRadius: 10,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: GestureDetector(
        onTap: onViewDetails, // Tap on card to view details
        child: Row(
          children: [
            GestureDetector(
              onTap: onToggle,
              child: Container(
                width: 20,
                height: 20,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(
                    color: task.isCompleted ? task.color : Colors.grey,
                    width: 2,
                  ),
                  color: task.isCompleted ? task.color : Colors.transparent,
                ),
                child: task.isCompleted
                    ? const Icon(
                  Icons.check,
                  size: 14,
                  color: Colors.white,
                )
                    : null,
              ),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    task.title,
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      decoration: task.isCompleted
                          ? TextDecoration.lineThrough
                          : TextDecoration.none,
                      color: task.isCompleted ? Colors.grey : Colors.black87,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    task.description,
                    style: TextStyle(
                      color: Colors.grey[600],
                      fontSize: 14,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    task.category,
                    style: TextStyle(
                      color: task.color,
                      fontSize: 12,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
            Text(
              _formatTime(task.dueTime),
              style: TextStyle(
                color: Colors.grey[600],
                fontSize: 12,
              ),
            ),
            const SizedBox(width: 8),
            // Edit Button
            GestureDetector(
              onTap: () {
                showDialog(
                  context: context,
                  builder: (context) => AddEditTaskDialog(
                    taskToEdit: task,
                    onSaveTask: onEdit,
                  ),
                );
              },
              child: const Icon(
                Icons.edit,
                color: Colors.blue,
                size: 20,
              ),
            ),
            const SizedBox(width: 8),
            // Delete Button
            GestureDetector(
              onTap: onDelete,
              child: const Icon(
                Icons.delete_outline,
                color: Colors.red,
                size: 20,
              ),
            ),
          ],
        ),
      ),
    );
  }

  String _formatTime(DateTime time) {
    final hour = time.hour;
    final minute = time.minute;
    final period = hour >= 12 ? 'PM' : 'AM';
    final displayHour = hour > 12 ? hour - 12 : (hour == 0 ? 12 : hour);
    return '${displayHour.toString().padLeft(2, '0')}:${minute.toString().padLeft(2, '0')} $period';
  }
}